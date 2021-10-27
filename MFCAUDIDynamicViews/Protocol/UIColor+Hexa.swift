//
//  UIColor+Hexa.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 29/10/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit
/**
 Helper extension for creating a UIColor based on a hex value
 */
public extension UIColor {
    /**
     Helper extension for creating a UIColor based on a hex value
     
     -parameter hex: The hex value (like 0xffffff) that wil be used for the color
     */
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int = UInt32()
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        assert(hex.count == 6, "Invalid hex code used.")

//        Scanner(string: hex).scanHexInt32(&int)
//        let a, r, g, b: UInt32
        
        self.init (red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
//        switch hex.count {
//        case 3:
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)

    }
}
