import XCTest
@testable import Core

class APIHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)
    }

    override func tearDown() {
        super.tearDown()
        Constants.setKeychainHelper(KeychainHelper())
    }

    func testGenerateQueryItems() {
        let queryItems = APIHelper.generateQueryItems(offset: 0, limit: 20)
        
        XCTAssertEqual(queryItems.count, 5)
        XCTAssertTrue(queryItems.contains { $0.name == "ts" })
        XCTAssertTrue(queryItems.contains { $0.name == "apikey" && $0.value == "mockPublicKey" })
        XCTAssertTrue(queryItems.contains { $0.name == "hash" })
        XCTAssertTrue(queryItems.contains { $0.name == "offset" && $0.value == "0" })
        XCTAssertTrue(queryItems.contains { $0.name == "limit" && $0.value == "20" })
    }

    func testGenerateQueryItemsWithoutOffsetAndLimit() {
        let queryItems = APIHelper.generateQueryItems()
        
        XCTAssertEqual(queryItems.count, 3)
        XCTAssertTrue(queryItems.contains { $0.name == "ts" })
        XCTAssertTrue(queryItems.contains { $0.name == "apikey" && $0.value == "mockPublicKey" })
        XCTAssertTrue(queryItems.contains { $0.name == "hash" })
    }

    func testGenerateQueryItemsWithInvalidKeychain() {
        let invalidKeychain = MockKeychainHelper()
        Constants.setKeychainHelper(invalidKeychain)

        XCTAssertThrowsError(try invalidKeychain.retrieve(key: "MARVEL_PUBLIC_KEY")) { error in
            XCTAssertTrue(error is KeychainError)
        }
        
        XCTAssertThrowsError(try invalidKeychain.retrieve(key: "MARVEL_PRIVATE_KEY")) { error in
            XCTAssertTrue(error is KeychainError)
        }
    }

    func testGenerateQueryItemsWithDifferentOffsetAndLimit() {
        let queryItems = APIHelper.generateQueryItems(offset: 50, limit: 100)
        
        XCTAssertTrue(queryItems.contains { $0.name == "offset" && $0.value == "50" })
        XCTAssertTrue(queryItems.contains { $0.name == "limit" && $0.value == "100" })
    }

    func testCreateEndpoint() {
        let endpoint = APIHelper.createEndpoint(path: "/test/path", method: .get, offset: 10, limit: 20)
        XCTAssertEqual(endpoint.path, "/test/path")
        XCTAssertEqual(endpoint.method, .get)
        
        let queryItems = endpoint.queryItems ?? []
        XCTAssertTrue(queryItems.contains { $0.name == "offset" && $0.value == "10" })
        XCTAssertTrue(queryItems.contains { $0.name == "limit" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "apikey" && $0.value == "mockPublicKey" })
    }
}
