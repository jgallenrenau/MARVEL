import XCTest
@testable import Core

class KeychainHelperTests: XCTestCase {
    var mockKeychain: MockKeychainHelper!

    override func setUp() {
        super.setUp()
        mockKeychain = MockKeychainHelper()
    }

    func testSaveAndRetrieve() throws {
        try mockKeychain.save(key: "testKey", value: "testValue")
        let retrievedValue = try mockKeychain.retrieve(key: "testKey")
        XCTAssertEqual(retrievedValue, "testValue")
    }

    func testDelete() throws {
        try mockKeychain.save(key: "testKey", value: "testValue")
        try mockKeychain.delete(key: "testKey")
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "testKey"))
    }
}
