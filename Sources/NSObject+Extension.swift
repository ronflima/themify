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
// Created: 2017-06-02 by Ronaldo Faria Lima
// This file purpose: internal extension for NSObject

import Foundation

/// Adds a class function to NSObject in order to get a class type for a given string representing the class name.
/// This is based on Maxim Bilan extension, updated to Swift 4. 
/// - seealso: https://medium.com/@maximbilan/ios-objective-c-project-nsclassfromstring-method-for-swift-classes-dbadb721723
extension NSObject {
    class func swiftClassFromString(className: String) -> AnyClass? {
        #if DEBUG
            let bundle = Bundle(for: NSObject.self)
        #else
            let bundle = Bundle.main
        #endif
        var foundClass: AnyClass? = NSClassFromString(className)
        if foundClass == nil {
            if let bundleName = bundle.infoDictionary?["CFBundleName"] as? String {
                let appName = bundleName.replacingOccurrences(of: " ", with: "_")
                foundClass = NSClassFromString("\(appName).\(className)")
            }
        }
        return foundClass;
    }
}
