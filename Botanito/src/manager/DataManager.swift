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
    var families: [Family] = []
    
    override init() {
        dataBase = FIRDatabase.database()
        storage = FIRStorage.storage()
        super.init()
        
        dataBase.persistenceEnabled = true

        dataBase.reference().child("families").observe(.value, with: { [weak self] snapshot in
            guard self != nil else {
                return
            }
            for familyModel in snapshot.children {
                let snap = familyModel as! FIRDataSnapshot
                let family = Family(snap: snap,storageRef: self!.storage.reference(withPath: "Formula"))
                self!.families.append(family)
            }
        })
    }
}
