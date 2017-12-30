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
import UIKit

/// Abstraction for an element to be themified.
class Element {
    /// List of attributes to be themified for this element
    var attributes: Set<Attribute>!

    /// This element proxy
    let element: UIAppearance.Type!

    init? (className: String) {
        element = NSObject.swiftClassFromString(className: className) as? UIAppearance.Type
        if element == nil {
            return nil
        }
    }
}

// MARK: - Hashable protocol compliance
extension Element: Hashable {
    var hashValue: Int {
        return element.appearance().hash
    }
    static func == (first: Element, second: Element) -> Bool {
        return first.element == second.element
    }
}

// MARK: - Functionality Implementation
extension Element {
    var proxy: UIAppearance {
        if let container = (attributes.filter { $0.type == .container }).first {
            // swiftlint:disable:next force_cast
            return element.appearance(whenContainedInInstancesOf: [container.value as! UIAppearanceContainer.Type])
        }
        return element.appearance()
    }
    /// Applies attributes to appearance proxies
    ///
    /// - Throws: ThemifyError.invalidProxyConfiguration
    func applyAttributes(usingOldValues: Bool = false) throws {
        let proxy = element.appearance()
        for attribute in attributes {
            if attribute.type == .container {
                // Container is not taken into account. Skip it.
                continue
            }
            if let getSelector = attribute.getSelector {
                if (element as AnyClass).instancesRespond(to: getSelector) {
                    attribute.oldValue = proxy.perform(getSelector)
                }
            }
            if (element as AnyClass).instancesRespond(to: attribute.setSelector!) {
                proxy.perform(attribute.setSelector, with: usingOldValues ? attribute.oldValue : attribute.value)
            } else {
                throw ThemifyError.invalidProxyConfiguration(className: String(describing: element),
                                                             attributeName: attribute.name)
            }
        }
    }
}
