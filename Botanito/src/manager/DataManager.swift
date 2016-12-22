//
//  DataManager.swift
//  Botanito
//
//  Created by Alex Motor on 17.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class DataManager: NSObject {
    private let dataBase: FIRDatabase!
    private let storage: FIRStorage!
    private var loadingFamilies: [Family] = []
    private var loadCompletion: (() -> ())?
    
    var families: [Family] = []
    var familiesLoaded: Bool = false
    
    override init() {
        dataBase = FIRDatabase.database()
        storage = FIRStorage.storage()
        super.init()
        
        dataBase.persistenceEnabled = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(familyLoaded(notification:)),
                                               name: .FamilyLoaded,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func fillDataBase(completion: @escaping () -> ()) {
        loadFamilies(completion: completion)
    }
    
    // MARK: - Private
    
    private func loadFamilies(completion: (() -> ())?) {
        loadCompletion = completion
        
        dataBase.reference().child("flowers").observe(.value, with: { [weak self] snapshot in
            guard self != nil else {
                return
            }
            for flowerModel in snapshot.children {
                let snap = flowerModel as! FIRDataSnapshot
                let flower = Flower(snap: snap,storageRef: self!.storage.reference(withPath: "Formula"))
                self!.loadingFamilies.append(flower)
                self!.families.append(flower)
            }
        })
        dataBase.reference().child("families").observe(.value, with: { [weak self] snapshot in
            guard self != nil else {
                return
            }
            for familyModel in snapshot.children {
                let snap = familyModel as! FIRDataSnapshot
                let family = Family(snap: snap,storageRef: self!.storage.reference(withPath: "Formula"))
                self!.loadingFamilies.append(family)
                self!.families.append(family)
            }
            
            self!.familiesLoaded = true
        })
    }
    
    @objc
    private func familyLoaded(notification: Notification) {
        let family = notification.userInfo!["family"] as! Family
        loadingFamilies.remove(at: loadingFamilies.index(of: family)!)
        if loadingFamilies.count == 0 {
            loadCompletion?()
        }
    }
}
