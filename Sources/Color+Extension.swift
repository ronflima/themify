//
//  Color+Extension.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 28/04/17.
//
//

import Foundation
import UIKit

// MARK: - UIColor Extension
extension UIColor {
    
    /// Creates a UIColor based on a string hexadecimal RGB value.
    ///
    /// - Parameters:
    ///   - hex: hexadecimal string
    ///   - alpha: alpha for the new color. 1.0 is full opaque, 0.0 is full transparent.
    convenience init(hex: String, alpha: CGFloat) {
        var rawHex = hex
        if hex.contains("#") {
            rawHex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 1))
        }
        let scanner = Scanner(string: rawHex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let hexColor = (r: CGFloat((rgb >> 0x10) & 0xff)/CGFloat(0xff), g: CGFloat((rgb >> 0x8) & 0xff)/CGFloat(0xff), b: CGFloat(rgb & 0xff)/CGFloat(0xff))
        self.init(red: hexColor.r, green: hexColor.g, blue: hexColor.b, alpha: alpha)
    }
}
