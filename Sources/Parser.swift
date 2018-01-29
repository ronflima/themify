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
// Created: 2017-04-27 by Ronaldo Faria Lima
// This file purpose: plist/in memory parser

import Foundation

struct Parser {
    func parse(rawThemes: [Any]) throws -> Set<Theme> {
        var themes = Set<Theme>()
        for readTheme in rawThemes {
            if let rawTheme = readTheme as? [String: Any] {
                if let name = rawTheme["name"] as? String {
                    let theme = Theme(name: name)
                    if let rawElements = rawTheme["elements"] as? [[String: Any]] {
                        theme.elements = try parseElements(rawElements: rawElements)
                    }
                    if let rawStyleSets = rawTheme["styleSets"] as? [[String: Any]] {
                        theme.styleSets = try parseStyleSets(rawStyleSets: rawStyleSets)
                    }
                    themes.insert(theme)
                } else {
                    throw ThemifyError.invalidThemeConfiguration
                }
            }
        }
        return themes
    }

    fileprivate func parseElements(rawElements: [[String: Any]]) throws -> Set<Element> {
        var elements = Set<Element>()
        for rawElement in rawElements {
            guard let rawElementType = rawElement["element"] as? String else {
                throw ThemifyError.invalidThemeConfiguration
            }
            if let element = Element(className: rawElementType) {
                if let attributes = rawElement["attributes"] as? [String: Any] {
                    element.attributes = try parseAttributes(rawAttributes: attributes)
                }
                elements.insert(element)
            } else {
                throw ThemifyError.invalidThemeConfiguration
            }
        }
        return elements
    }

    fileprivate func parseStyleSets(rawStyleSets: [[String: Any]]) throws -> Set<StyleSet> {
        var styleSets = Set<StyleSet>()
        for rawElement in rawStyleSets {
            guard let styleSetContext = rawElement["element"] as? String else {
                throw ThemifyError.invalidThemeConfiguration
            }
            let styleSet = StyleSet(element: styleSetContext)
            if let attributes = rawElement["attributes"] as? [String: Any] {
                styleSet.attributes = try parseAttributes(rawAttributes: attributes)
            }
            styleSets.insert(styleSet)
        }
        return styleSets
    }

    fileprivate func parseAttributes(rawAttributes: [String: Any]) throws -> Set<Attribute> {
        var attributes = Set<Attribute>()
        for (name, value) in rawAttributes {
            let attribute: Attribute! = Attribute(name: name, value: value)
            if attribute == nil {
                continue
            }
            attributes.insert(attribute)
        }
        if attributes.count == 0 {
            // There must be at least one single attribute. Otherwise, this theme is not good.
            throw ThemifyError.invalidThemeConfiguration
        }
        return attributes
    }
}
