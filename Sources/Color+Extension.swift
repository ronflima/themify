// -*-swift-*-
// The MIT License (MIT)
//
// Copyright (c) 2017 - Nineteen
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Created: 2017-04-17 by Ronaldo Faria Lima
// This file purpose: Convenience extension for UIColor class

import Foundation
import UIKit

// MARK: - UIColor Extension
extension UIColor {

    typealias ColorComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    enum ColorType: Int {
        case fullRgb = 6
        case rgb = 3
        case fullRgba = 8
        case rgba = 4
    }

    /// Creates a UIColor based on a string hexadecimal RGB value.
    ///
    /// - Parameters:
    ///   - hex: hexadecimal string
    ///   - alpha: alpha for the new color. 1.0 is full opaque, 0.0 is full transparent.
    convenience init?(hex: String, alpha: CGFloat) {
        if let colorComps = UIColor.colorComponents(from: hex) {
            self.init(red: colorComps.red, green: colorComps.green, blue: colorComps.blue, alpha: alpha)
            return
        }
        return nil
    }

    /// Creates a UIColor based on a RGB or RGBA hexadecimal values
    ///
    /// - Parameters:
    ///     - hex: hexadecimal string containing RGB or RGBA on complete or simple representations
    convenience init?(hex: String) {
        if let colorComps = UIColor.colorComponents(from: hex) {
            self.init(red: colorComps.red, green: colorComps.green, blue: colorComps.blue, alpha: colorComps.alpha)
            return
        }
        return nil
    }

    /// Do the heavy lifting of parsing an hex string
    ///
    /// - Parameters:
    ///     - hexString: String containing both RGB or RGBA strings, on both simple or complete form.
    /// - Returns:
    ///     - A tuple of color components on success
    ///     - nil if provided hex string is invalid
    fileprivate static func colorComponents(from hexString: String) -> ColorComponents? {
        var components = ColorComponents(0, 0, 0, 1.0)
        var rawHex = hexString
        if let i = hexString.index(of: "#") {
            rawHex = String(hexString[hexString.index(i, offsetBy: 1)..<hexString.endIndex])
        }
        let colorType = ColorType(rawValue: hexString.count)
        if colorType == nil {
            // Invalid hex value provided
            return nil
        }
        let scanner = Scanner(string: rawHex)
        var rgba = UInt64(0)
        scanner.scanHexInt64(&rgba)
        switch colorType! {
        case .fullRgb:
            components.red  = CGFloat((rgba >> 0x10) & 0xff)
            components.green = CGFloat((rgba >> 0x8) & 0xff)
            components.blue  = CGFloat(rgba & 0xff)
        case .rgb:
            components.red = CGFloat(rgba >> 0x8 | (rgba & 0xf00) >> 0x4)
            components.green = CGFloat((rgba & 0xf0) | (rgba & 0xf0) >> 0x4)
            components.blue = CGFloat((rgba & 0xf) | (rgba & 0xf) << 0x4)
        case .fullRgba:
            components.red = CGFloat(rgba >> 0x18)
            components.green = CGFloat((rgba >> 0x10) & 0xff)
            components.blue = CGFloat((rgba >> 0x8) & 0xff)
            components.alpha = CGFloat(rgba & 0xff)
        case .rgba:
            components.red = CGFloat((rgba & 0xf000) >> 0x8 | (rgba & 0xf000) >> 0xC)
            components.green = CGFloat((rgba & 0xf00) >> 0x4 | (rgba & 0xf00) >> 0x8)
            components.blue = CGFloat(rgba & 0xf0 | (rgba & 0xf0) >> 0x4)
            components.alpha = CGFloat(rgba & 0xf | (rgba & 0xf) << 0x4)
        }
        return components
    }
}
