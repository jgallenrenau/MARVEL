import XCTest
@testable import Core

final class KeychainHelperTests: XCTestCase {

    // MARK: - Constants
    let testKey = "MARVEL_PUBLIC_KEY"
    let testValue = "f72273260db3ac0d725ed41d1667c4a1"
    let nonExistentKey = "nonExistentKey"

    // MARK: - Test Setup and Teardown
    override func setUpWithError() throws {
        try? KeychainHelper.delete(key: testKey)
    }

    override func tearDownWithError() throws {
        try? KeychainHelper.delete(key: testKey)
    }

    // MARK: - Tests

    func testRetrieveNonExistentKey() {
        XCTAssertThrowsError(try KeychainHelper.retrieve(key: nonExistentKey)) { error in
            XCTAssertEqual(error as? KeychainError, .unableToRetrieve)
        }
    }

    func testSaveEmptyValue() {
        XCTAssertThrowsError(try KeychainHelper.save(key: testKey, value: "")) { error in
            XCTAssertEqual(error as? KeychainError, .unableToSave)
        }
    }

    func testKeychainFailureCases() {
        let invalidKey = "testKey"
        let invalidValue = String(repeating: "a", count: 1_000_000)
        
        XCTAssertThrowsError(try KeychainHelper.save(key: invalidKey, value: invalidValue)) { error in
            XCTAssertEqual(error as? KeychainError, .unableToSave)
        }
    }
}
