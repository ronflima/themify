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
// Created: 2017-04-25 by Ronaldo Faria Lima
// This file purpose: Attribute declarations

import Foundation

/// Describes the type of attribute being themed
///
/// - backgroundColor: Background color
/// - foregroundColor: Foreground color. Depending on the element being customized, can be a text color or tint color
enum Attribute {
    case backgroundColor(UIColor)
    case foregroundColor(UIColor)
    
    /// Converts a raw attribute and value to its internal representations.
    ///
    /// - Parameters:
    ///   - rawAttribute: Attribute in raw format
    ///   - rawValue: Attribute's value in raw format
    /// - Returns: The newly created attribute on success or nil otherwise.
    static func convertAttribute(rawAttribute: String, rawValue: String) -> Attribute? {
        let validAttributes: [String] = ["BACKGROUNDCOLOR", "FOREGROUNDCOLOR"]
        if !validAttributes.contains(rawAttribute.uppercased()) {
            return nil
        }
        var attribute: Attribute?
        switch rawAttribute.uppercased() {
        case validAttributes[0]:    // backgroundColor
            attribute = .backgroundColor(UIColor(hex: rawValue, alpha: 1.0))
        case validAttributes[1]:    // foregroundColor
            attribute = .foregroundColor(UIColor(hex: rawValue, alpha: 1.0))
        default:
            break
        }
        return attribute
    }
}

// MARK: - Hashable Conformance
extension Attribute: Hashable {
    var hashValue: Int {
        switch self {
        case .backgroundColor(let color):
            return color.hashValue + 0x1
        case .foregroundColor(let color):
            return color.hashValue + 0x2
        }
    }
    
    static func == (a: Attribute, b: Attribute) -> Bool {
        return a.hashValue == b.hashValue
    }
}
