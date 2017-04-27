//
//  AttributeType.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 25/04/17.
//
//

import Foundation

/// Describes the type of attribute being themed
///
/// - backgroundColor: Background color
/// - foregroundColor: Foreground color. Depending on the element being customized, can be a text color or tint color
enum Attribute: Hashable {
    case backgroundColor(UIColor)
    case foregroundColor(UIColor)
    
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
