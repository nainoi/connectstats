import XCTest
@testable import ConnectStatsSP

final class ConnectStatsSPTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ConnectStatsSP().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
