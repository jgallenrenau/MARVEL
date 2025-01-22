import XCTest
@testable import Core

class APIHelperTests: XCTestCase {
    func testGenerateQueryItems() {
        let queryItems = APIHelper.generateQueryItems(offset: 10, limit: 20)
        XCTAssertEqual(queryItems.count, 5)
        XCTAssertNotNil(queryItems.first(where: { $0.name == "apikey" }))
    }

    func testGenerateHash() {
        let hash = APIHelper.generateQueryItems(offset: nil, limit: nil)
        XCTAssertNotNil(hash)
    }
}

