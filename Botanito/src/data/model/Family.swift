//
//  Family.swift
//  Botanito
//
//  Created by Alex Motor on 17.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class Family: NSObject {
    let name: String
    var image: UIImage?
    var typeImages: [String : UIImage]?
    var types: [String]?
    
    init(snap: FIRDataSnapshot, storageRef: FIRStorageReference) {
        name = snap.childSnapshot(forPath: "name").value as! String
        if snap.hasChild("types") {
            types = []
            let typeSnaps = snap.childSnapshot(forPath: "types").children
            for typeSnap in typeSnaps {
                let snap = typeSnap as! FIRDataSnapshot
                types!.append(snap.value as! String)
            }
        }
        super.init()
     
        loadImages(storageRef: storageRef)
    }
    
    private func loadImages(storageRef: FIRStorageReference) {
        if let types = types {
            for type in types {
                typeImages = [:]
                var fileName = "\(name)"
                if !type.isEmpty {
                    fileName.append("-\(type)")
                }
                fileName.append(".png")
                storageRef.child(fileName).data(withMaxSize: 1 * 1024 * 1024) { [weak self] data, error in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    self?.typeImages![type] = UIImage(data: data!)
                }
            }
        } else {
            storageRef.child("\(name).png").data(withMaxSize: 1 * 1024 * 1024) { [weak self] data, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                self?.image = UIImage(data: data!)
            }
        }
    }
}
