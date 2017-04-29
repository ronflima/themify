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
// This file purpose: Theme declarations/implementation

import Foundation

/// A theme is a composition of elements and its attributes. It uses appearence proxies to create a full theme
/// based on plist definitions.
public class Theme {
    /// This theme name, for reference
    let name: String
    
    /// Customized elements on this theme
    var elements: Set<Element>!
    
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
