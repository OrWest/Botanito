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
    
    init(snap: FIRDataSnapshot, storageRef: FIRStorageReference) {
        name = snap.childSnapshot(forPath: "name").value as! String
        super.init()
        
        // 1 MB
        storageRef.child("\(name).png").data(withMaxSize: 1 * 1024 * 1024) { [weak self] data, error in
            guard error == nil else {
                print(error!)
                return
            }
            self?.image = UIImage(data: data!)
        }
    }
}
