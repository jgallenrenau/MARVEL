import XCTest
@testable import Core

class KeychainHelperTests: XCTestCase {
    var mockKeychain: MockKeychainHelper!

    override func setUp() {
        super.setUp()
        mockKeychain = MockKeychainHelper()
    }

    override func tearDown() {
        super.tearDown()
        mockKeychain = nil
    }

    func testSaveAndRetrieve() throws {
        try mockKeychain.save(key: "testKey", value: "testValue")
        let retrievedValue = try mockKeychain.retrieve(key: "testKey")
        XCTAssertEqual(retrievedValue, "testValue")
    }

    func testRetrieveNonExistentKey() {
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "nonExistentKey")) { error in
            XCTAssertTrue(error is KeychainError)
            XCTAssertEqual(error as? KeychainError, .unableToRetrieve)
        }
    }

    func testOverwriteExistingKey() throws {
        try mockKeychain.save(key: "testKey", value: "testValue")
        try mockKeychain.save(key: "testKey", value: "newValue")
        let retrievedValue = try mockKeychain.retrieve(key: "testKey")
        XCTAssertEqual(retrievedValue, "newValue")
    }

    func testDelete() throws {
        try mockKeychain.save(key: "testKey", value: "testValue")
        try mockKeychain.delete(key: "testKey")
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "testKey")) { error in
            XCTAssertTrue(error is KeychainError)
            XCTAssertEqual(error as? KeychainError, .unableToRetrieve)
        }
    }

    func testDeleteNonExistentKey() {
        XCTAssertNoThrow(try mockKeychain.delete(key: "nonExistentKey"))
    }

    func testSaveSpecialCharactersInKey() throws {
        let specialKey = "test Key!@#%^&*()"
        let specialValue = "valueWith$pecialChars"
        try mockKeychain.save(key: specialKey, value: specialValue)
        let retrievedValue = try mockKeychain.retrieve(key: specialKey)
        XCTAssertEqual(retrievedValue, specialValue)
    }

    func testSaveAndRetrieveEmptyValue() throws {
        try mockKeychain.save(key: "emptyValueKey", value: "")
        let retrievedValue = try mockKeychain.retrieve(key: "emptyValueKey")
        XCTAssertEqual(retrievedValue, "")
    }

    func testSaveDuplicateKeys() throws {
        try mockKeychain.save(key: "duplicateKey", value: "value1")
        try mockKeychain.save(key: "duplicateKey", value: "value2")
        let retrievedValue = try mockKeychain.retrieve(key: "duplicateKey")
        XCTAssertEqual(retrievedValue, "value2")
    }

    func testSimultaneousOperations() throws {
        try mockKeychain.save(key: "key1", value: "value1")
        try mockKeychain.save(key: "key2", value: "value2")
        
        let value1 = try mockKeychain.retrieve(key: "key1")
        let value2 = try mockKeychain.retrieve(key: "key2")
        
        XCTAssertEqual(value1, "value1")
        XCTAssertEqual(value2, "value2")
    }
    
    func testErrorMessages() {
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "invalidKey")) { error in
            if let keychainError = error as? KeychainError {
                XCTAssertEqual(keychainError.localizedDescription, "Unable to retrieve data from the Keychain.")
            } else {
                XCTFail("Unexpected error type")
            }
        }
    }
}
