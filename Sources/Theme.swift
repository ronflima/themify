//
//  Theme.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 25/04/17.
//
//

import Foundation

/// A theme is a composition of elements and its attributes. It uses appearence proxies to create a full theme
/// based on plist definitions.
public class Theme {
    /// This theme name, for reference
    let name: String
    
    /// Customized elements on this theme
    var elements = Set<Element>()
    
    /// Initializer
    ///
    /// - Parameter name: Theme name
    public init(name: String) {
        self.name = name
    }
    
    /// Applies the theme to the app by using appearance proxies.
    public func apply() {
        for element in elements {
            element.applyAttributes()
        }
    }
    
    /// Adds a customized element to this theme. Used internally
    ///
    /// - Parameter element: Element to add
    func addElement(element: Element) {
        elements.insert(element)
    }
}

// MARK: - Hashable conformance
extension Theme: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
    
    public static func == (a: Theme, b: Theme) -> Bool {
        return a.name == b.name
    }
}
