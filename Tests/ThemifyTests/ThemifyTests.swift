import XCTest
@testable import Themify

class ThemifyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Themify().text, "Hello, World!")
    }


    static var allTests : [(String, (ThemifyTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
