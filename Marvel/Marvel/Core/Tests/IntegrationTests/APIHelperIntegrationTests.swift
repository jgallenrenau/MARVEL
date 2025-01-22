import XCTest
@testable import Core

class APIHelperIntegrationTests: XCTestCase {
    func testGenerateQueryItemsIntegration() {
        let queryItems = APIHelper.generateQueryItems(offset: 10, limit: 20)
        XCTAssertEqual(queryItems.count, 5)
    }
}
