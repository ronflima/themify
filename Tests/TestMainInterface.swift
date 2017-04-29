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
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThemeLoad() {
        let bundle = Bundle(for: self.classForCoder)
        guard let themeFileURL = bundle.url(forResource: "TestTheme", withExtension: "plist") else {
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
}
