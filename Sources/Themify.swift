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
// This file purpose: Main library entry point/interface

import Foundation

/// Themify main interface. This library is implemented as a façade and singleton. But, you can create you own instance 
/// and spread it through your code as a simple plain swift class.
public final class Themify {
    /// Singleton instance of themify.
    fileprivate static var instance: Themify!
    
    /// Set of loaded themes
    fileprivate var themes = Set<Theme>()
    
    /// Shared instance of Themify. You can use it as a singleton. This is only a convenience.
    public static var shared: Themify {
        if Themify.instance == nil {
            Themify.instance = Themify()
        }
        return Themify.instance
    }
    
    /// A list with all loaded theme names
    public var themeNames: [String] {
        return themes.map({ (theme) -> String in
            return theme.name
        })
    }
    
    /// Contains the number of loaded themes
    public var count: Int {
        return themes.count
    }
    
    /// Default initializer. So far, does nothing.
    public init() {}
    
    /// Loads all themes written to a plist file.
    ///
    /// - Parameter fileURL: File URL for a plist containing theme definitions
    /// - Throws:
    ///     - ThemifyError.cantLoadThemeFile if could not read the input file
    ///     - ThemifyError.invalidThemeConfiguration if parsing of one theme was not successful
    public func loadThemes(from fileURL: URL) throws {
        guard let themeArray = NSArray(contentsOf: fileURL) as? Array<Any> else {
           throw ThemifyError.cantLoadThemeFile(themeFileURL: fileURL)
        }
        themes = try Parser().parse(rawThemes: themeArray)
    }
    
    /// Applies a theme based on its name
    ///
    /// - Parameter themeName: Theme name to apply
    /// - Throws: ThemifyError.themeNotFound if theme name was not found at all.
    public func applyTheme(themeName: String) throws {
        if let theme = (themes.filter { $0.name == themeName }).first {
            try theme.apply()
        } else {
            throw ThemifyError.themeNotFound(themeName: themeName)
        }
    }
}
