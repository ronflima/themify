//
//  Theme.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 25/04/17.
//
//

import Foundation
import UIKit

/// A theme is a composition of elements and its attributes. It uses appearence proxies to create a full theme
/// based on plist definitions.
public class Theme : Equatable {
    let name: String
    var elements = Set<Element>()
    
    public init(name: String) {
        self.name = name
    }
    
    public func apply() {
        for element in elements {
            element.applyAttributes()
        }
    }
    
    public static func == (a: Theme, b: Theme) -> Bool {
        return a.name == b.name
    }
    
    func addElement(element: Element) {
        elements.insert(element)
    }
}
