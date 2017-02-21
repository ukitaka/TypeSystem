import XCTest
@testable import TypeInference

class TypeInferenceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TypeInference().text, "Hello, World!")
    }


    static var allTests : [(String, (TypeInferenceTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
