//
//  TestMainInterface.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 28/04/17.
//
//

import XCTest
@testable import Themify

/// Tests the main interface of Themify library
class TestMainInterface: XCTestCase {
    var testBundle: Bundle!
    
    override func setUp() {
        super.setUp()
        testBundle = Bundle(for: self.classForCoder)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThemeLoad() {
        guard let themeFileURL = testBundle.url(forResource: "TestTheme", withExtension: "plist") else {
            XCTFail("Unable to load theme test file")
            return
        }
        do {
            try Themify.shared.loadThemes(from: themeFileURL)
        } catch {
            XCTFail("Could not load themes from test file")
        }
        XCTAssertEqual(Themify.shared.count, 2, "Wrong number of loaded themes")
    }
    
    func testThemeApply() {
        guard let themeFileURL = testBundle.url(forResource: "TestTheme", withExtension: "plist") else {
            XCTFail("Unable to load theme test file")
            return
        }
        do {
            try Themify.shared.loadThemes(from: themeFileURL)
        } catch {
            XCTFail("Could not load themes from test file")
        }
        do {
            try Themify.shared.applyTheme(themeName: "Light Blue")
        } catch {
            XCTFail("Failed to apply theme")
        }
    }
    
    func testThemeNames() {
        guard let themeFileURL = testBundle.url(forResource: "TestTheme", withExtension: "plist") else {
            XCTFail("Unable to load theme test file")
            return
        }
        do {
            try Themify.shared.loadThemes(from: themeFileURL)
        } catch {
            XCTFail("Could not load themes from test file")
        }
        XCTAssertEqual(Themify.shared.themeNames.count, 2, "Wrong theme names")
    }
}
