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
// This file purpose: Theme element declarations/implementations

import Foundation

/// Abstraction for an element to be themified.
class Element {
    
    /// List of attributes to be themified for this element
    var attributes = Set<Attribute>()
    
    /// Element container, if any.
    var container  : Element?
    
    /// Type of this element
    let elementType: ElementType
    
    /// Default initializer
    ///
    /// - Parameter elementType: Element type to identify this element inside a theme
    init (elementType: ElementType) {
        self.elementType = elementType
    }
}

// MARK: - Hashable protocol compliance
extension Element: Hashable {
    var hashValue: Int {
        if container != nil {
            return elementType.hashValue + container!.hashValue
        }
        return elementType.hashValue
    }
    static func == (a: Element, b: Element) -> Bool {
        return a.elementType == b.elementType
    }
}

// MARK: - Class map implementation
extension Element {
    
    /// Attribute applier. It is a simple block
    typealias AttributeApplier = (UIAppearance, Attribute) -> ()
    
    /// Element/Class mapping, with appliers
    fileprivate static let elementClassMap: [ElementType : (class: AnyClass, applier: AttributeApplier)] = [
        .label: (
            class: UILabel.self,
            applier: { (proxy, attribute) in
                let viewProxy = proxy as! UILabel
                switch attribute {
                case .backgroundColor(let color):
                    viewProxy.backgroundColor = color
                case .foregroundColor(let color):
                    viewProxy.textColor = color
                }
        }),
        .navigationBar: (
            class: UINavigationBar.self,
            applier: { (proxy, attribute) in
                let viewProxy = proxy as! UINavigationBar
                switch attribute {
                case .backgroundColor(let color):
                    viewProxy.backgroundColor = color
                case .foregroundColor(let color):
                    viewProxy.tintColor = color
                }
        }),
        .toolBar: (
            class: UIToolbar.self,
            applier: { (proxy, attribute) in
                let viewProxy = proxy as! UIToolbar
                switch attribute {
                case .backgroundColor(let color):
                    viewProxy.backgroundColor = color
                case .foregroundColor(let color):
                    viewProxy.tintColor = color
                }
        }),
        .tabBar: (
            class: UITabBar.self,
            applier: { (proxy, attribute) in
                let viewProxy = proxy as! UITabBar
                switch attribute {
                case .backgroundColor(let color):
                    viewProxy.backgroundColor = color
                case .foregroundColor(let color):
                    viewProxy.tintColor = color
                }
        }),
        .tableViewCell: (
            class: UITableViewCell.self,
            applier: { (proxy, attribute) in
                let viewProxy = proxy as! UITableViewCell
                switch attribute {
                case .backgroundColor(let color):
                    viewProxy.backgroundColor = color
                case .foregroundColor(let color):
                    viewProxy.tintColor = color
                }
        })
    ]
}

// MARK: - Functionality Implementation
extension Element {

    /// Class related to this element
    var elementClass: AnyClass? {
        return Element.elementClassMap[elementType]?.class
    }
    
    /// Attribute applier routine
    var attributeApplier: AttributeApplier? {
        return Element.elementClassMap[elementType]?.applier
    }
    
    /// Default appearance proxy related to this element
    var proxy: UIAppearance? {
        return (elementClass as? UIAppearance.Type)?.appearance()
    }
    
    /// Appearance proxy when this element is contained within another element
    ///
    /// - Parameter containers: list of containers
    /// - Returns: Appearance proxy
    func proxy(within containers: [UIAppearanceContainer.Type]) -> UIAppearance? {
        return (elementClass as? UIAppearance.Type)?.appearance(whenContainedInInstancesOf: containers)
    }
    
    /// Adds an attribute to this element
    ///
    /// - Parameter attribute: Attribute to add
    func addAttribute(attribute: Attribute) {
        attributes.insert(attribute)
    }
    
    /// Applies attributes to appearance proxies
    func applyAttributes() {
        var appearanceProxy: UIAppearance!
        if let container = container, let typeClass = container.elementClass {
            appearanceProxy = self.proxy(within: [typeClass as! UIAppearanceContainer.Type])
        } else {
            appearanceProxy = self.proxy
        }
        if appearanceProxy == nil {
            // Failed to get a proxy? Do nothing. Probably, we have a configuration issue
            return
        }
        for attribute in attributes {
            attributeApplier?(appearanceProxy, attribute)
        }
    }
}
