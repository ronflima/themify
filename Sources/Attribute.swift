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
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import Foundation
import UIKit

enum AttributeType {
    case color
    case image
    case container
    case textAttribute
    case font
    case unknown

    init(name: String) {
        let normalizedName = name.uppercased()
        if normalizedName.contains("COLOR") {
            self = .color
        } else if normalizedName.contains("IMAGE") {
            self = .image
        } else if normalizedName == "CONTAINER" {
            self = .container
        } else if normalizedName.contains("TEXTATTRIBUTES") {
            self = .textAttribute
        } else if normalizedName.contains("FONT") {
            self = .font
        } else {
            self = .unknown
        }
    }
}

class Attribute {
    let setSelector: Selector?
    let getSelector: Selector?
    let value: Any!
    var oldValue: Any!
    let name: String
    let type: AttributeType

    init? (name: String, value: Any) {
        var attrValue: Any? = nil
        self.name = name
        self.type = AttributeType(name: name)
        switch self.type {
        case .color:
            if let value = value as? String {
                attrValue = UIColor(hex: value)
            }
        case .image:
            if let value = value as? String {
                let url = URL(fileURLWithPath: value)
                if let data = try? Data(contentsOf: url) {
                    attrValue = UIImage(data: data)
                }
            }
        case .container:
            if let value = value as? String {
                attrValue = NSObject.swiftClassFromString(className: value)
            }
        case .textAttribute:
            var parsedValues: [NSAttributedStringKey: Any] = [:]
            if let value = value as? [String: Any] {
                for (key, strAttr) in value {
                    guard let stringKey = NSAttributedStringKey.fromString(representation: key) else {
                        return nil
                    }
                    if let attribute = Attribute(name: key, value: strAttr) {
                        parsedValues[stringKey] = attribute.value
                    }
                }
                attrValue = parsedValues
            }
        case .font:
            if let fontInfo = value as? [String: Any] {
                let fontName = fontInfo["name"] as? String
                let fontSize = fontInfo["size"] as? CGFloat
                guard fontName != nil, fontSize != nil else {
                    return nil
                }
                attrValue = UIFont(name: fontName!, size: fontSize!)
            } else {
                return nil
            }
        case .unknown:
            return nil
        }
        var setSelector: Selector? = nil
        var getSelector: Selector? = nil
        if type != .container {
            let first = name.startIndex
            let second = name.index(after: first)
            let setterName = "set\(name.capitalized[first])\(name[second..<name.endIndex]):"
            setSelector = NSSelectorFromString(setterName)
            getSelector = NSSelectorFromString(name)
        }
        self.setSelector = setSelector
        self.getSelector = getSelector
        self.value = attrValue
    }
}

// MARK: - Hashable Conformance
extension Attribute: Hashable {
    var hashValue: Int {
        return name.hashValue
    }

    static func == (first: Attribute, second: Attribute) -> Bool {
        return first.hashValue == first.hashValue
    }
}
