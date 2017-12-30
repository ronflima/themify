//
//  NSAttributedStringKey+Extension.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 03/09/17.
//
import UIKit
import Foundation

extension NSAttributedStringKey {
    static let stringMap: [String : NSAttributedStringKey] = [
        "ATTACHMENT"            : .attachment,
        "BACKGROUNDCOLOR"       : .backgroundColor,
        "BASELINEOFFSET"        : .baselineOffset,
        "EXPANSION"             : .expansion,
        "FONT"                  : .font,
        "FOREGROUNDCOLOR"       : .foregroundColor,
        "KERN"                  : .kern,
        "LIGATURE"              : .ligature,
        "LINK"                  : .link,
        "OBLIQUENESS"           : .obliqueness,
        "PARAGRAPHSTYLE"        : .paragraphStyle,
        "SHADOW"                : .shadow,
        "STRIKETHROUGHCOLOR"    : .strikethroughColor,
        "STRIKETHROUGHSTYLE"    : .strikethroughStyle,
        "STROKECOLOR"           : .strokeColor,
        "STROKEWIDTH"           : .strokeWidth,
        "TEXTEFFECT"            : .textEffect,
        "UNDERLINECOLOR"        : .underlineColor,
        "UNDERLINESTYLE"        : .underlineStyle,
        "VERTICALGLYPHFORM"     : .verticalGlyphForm,
        "WRITINGDIRECTION"      : .writingDirection
    ]
    static func fromString(representation: String) -> NSAttributedStringKey? {
        if let parts = representation.split(separator: ".").last {
            return NSAttributedStringKey.stringMap[parts.uppercased()]
        }
        return nil
    }
}
