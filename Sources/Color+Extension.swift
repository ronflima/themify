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
    
    /// Creates a UIColor based on a string hexadecimal RGB value.
    ///
    /// - Parameters:
    ///   - hex: hexadecimal string
    ///   - alpha: alpha for the new color. 1.0 is full opaque, 0.0 is full transparent.
    convenience init(hex: String, alpha: CGFloat) {
        var rawHex = hex
        if let i = hex.index(of: "#") {
            rawHex = String(hex[hex.index(i, offsetBy: 1)..<hex.endIndex])
        }
        let scanner = Scanner(string: rawHex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let hexColor = (r: CGFloat((rgb >> 0x10) & 0xff)/CGFloat(0xff), g: CGFloat((rgb >> 0x8) & 0xff)/CGFloat(0xff), b: CGFloat(rgb & 0xff)/CGFloat(0xff))
        self.init(red: hexColor.r, green: hexColor.g, blue: hexColor.b, alpha: alpha)
    }
}
