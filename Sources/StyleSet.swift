//
//  ContextualElement.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 29/01/2018.
//

import Foundation
import UIKit

/// This class is used for contextual elements which attributes varies during the process life-cycle.
public class StyleSet {
    public let element: String
    var attributes: Set<Attribute>

    init(element: String) {
        self.element = element
        self.attributes = Set<Attribute>()
    }

    public func apply(to element: UIAppearance) {
        for attribute in attributes {
            if element.responds(to: attribute.getSelector) {
                attribute.oldValue = element.perform(attribute.getSelector)
            }
            if element.responds(to: attribute.setSelector) {
                element.perform(attribute.setSelector, with: attribute.value)
            }
        }
    }
}

/// Hashable protocol conformance
extension StyleSet: Hashable {
    public var hashValue: Int {
        return element.hashValue
    }

    public static func == (first: StyleSet, second: StyleSet) -> Bool {
        return first.hashValue == second.hashValue
    }
}
