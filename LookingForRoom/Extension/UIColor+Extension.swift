//
//  UIColor+Extension.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/11/30.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  UIColor扩展

import UIKit

public extension UIColor {
    
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    convenience init?(hexString: String, alpha: Float) {
        var hex = hexString
        
        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        if (hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil) {
            
            // Deal with 3 character Hex strings
            if hex.count == 3 {
                
                let redHex = String(hex.dropLast(2))
                let greenHex = String(hex.dropFirst().dropLast())
                let blueHex = String(hex.dropFirst(2))
                
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            
            let redHex = String(hex.dropLast(4))
            let greenHex = String(hex.dropLast(2).dropFirst(2))
            let blueHex = String(hex.dropFirst(4))
            
            var redInt: CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt: CUnsignedInt = 0
            
            Scanner(string: redHex).scanHexInt32(&redInt)
            Scanner(string: greenHex).scanHexInt32(&greenInt)
            Scanner(string: blueHex).scanHexInt32(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        } else {
            self.init()
            return nil
        }
    }
}
