//
//  Array+shuffle.swift
//  Botanito
//
//  Created by Alex Motor on 22.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import Foundation

extension Array
{
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
