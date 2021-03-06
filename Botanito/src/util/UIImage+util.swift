//
//  UIImage+util.swift
//  Botanito
//
//  Created by Alex Motor on 19.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
