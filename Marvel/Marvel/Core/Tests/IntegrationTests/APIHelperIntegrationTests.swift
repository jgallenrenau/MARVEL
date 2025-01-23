import XCTest
@testable import Core

class APIHelperIntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        
        Constants.setKeychainHelper(mockKeychain)
    }
    
    func testGenerateQueryItemsIntegration() {
        let queryItems = APIHelper.generateQueryItems(offset: 10, limit: 20)
        
        XCTAssertEqual(queryItems.count, 5)
        XCTAssertTrue(queryItems.contains { $0.name == "ts" })
        XCTAssertTrue(queryItems.contains { $0.name == "apikey" && $0.value == "mockPublicKey" })
        XCTAssertTrue(queryItems.contains { $0.name == "hash" })
        XCTAssertTrue(queryItems.contains { $0.name == "offset" && $0.value == "10" })
        XCTAssertTrue(queryItems.contains { $0.name == "limit" && $0.value == "20" })
    }
    
    func testGenerateQueryItemsWithoutOffsetAndLimit() {
        let queryItems = APIHelper.generateQueryItems()
        
        XCTAssertEqual(queryItems.count, 3)
        XCTAssertTrue(queryItems.contains { $0.name == "ts" })
        XCTAssertTrue(queryItems.contains { $0.name == "apikey" && $0.value == "mockPublicKey" })
        XCTAssertTrue(queryItems.contains { $0.name == "hash" })
    }
    
    func testGenerateQueryItemsWithDifferentTimestamps() {
        let queryItems1 = APIHelper.generateQueryItems()
        let queryItems2 = APIHelper.generateQueryItems()
        
        let timestamp1 = queryItems1.first { $0.name == "ts" }?.value
        let timestamp2 = queryItems2.first { $0.name == "ts" }?.value
        
        XCTAssertNotNil(timestamp1)
        XCTAssertNotNil(timestamp2)
        XCTAssertNotEqual(timestamp1, timestamp2, "Timestamps should be unique for each call.")
    }
}
