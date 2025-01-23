import XCTest
@testable import Core

class ConstantsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)
    }
    
    override func tearDown() {
        super.tearDown()
        Constants.setKeychainHelper(KeychainHelper()) // Restaurar el helper original después de cada prueba
    }
    
    func testBaseURL() {
        XCTAssertEqual(Constants.API.baseURL.absoluteString, "https://gateway.marvel.com")
    }
    
    func testPublicKey() throws {
        let publicKey = Constants.API.publicKey
        XCTAssertEqual(publicKey, "mockPublicKey")
    }
    
    func testPrivateKey() throws {
        let privateKey = Constants.API.privateKey
        XCTAssertEqual(privateKey, "mockPrivateKey")
    }
    
    func testPublicKeyWhenMissing() {
        let mockKeychain = MockKeychainHelper()
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "MARVEL_PUBLIC_KEY")) { error in
            XCTAssertTrue(error is KeychainError)
            XCTAssertEqual((error as? KeychainError), .unableToRetrieve)
        }
    }
    
    func testPrivateKeyWhenMissing() {
        let mockKeychain = MockKeychainHelper()
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "MARVEL_PRIVATE_KEY")) { error in
            XCTAssertTrue(error is KeychainError)
            XCTAssertEqual((error as? KeychainError), .unableToRetrieve)
        }
    }
    
    func testSetKeychainHelper() {
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "newMockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "newMockPrivateKey")
        
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertEqual(Constants.API.publicKey, "newMockPublicKey")
        XCTAssertEqual(Constants.API.privateKey, "newMockPrivateKey")
    }
    
    func testBaseURLIsNotNil() {
        XCTAssertNotNil(Constants.API.baseURL)
    }
    
    func testKeysArePersistedAcrossTests() {
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "persistedPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "persistedPrivateKey")
        
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertEqual(Constants.API.publicKey, "persistedPublicKey")
        XCTAssertEqual(Constants.API.privateKey, "persistedPrivateKey")
    }
    
    func testRetrieveInvalidKey() {
        let mockKeychain = MockKeychainHelper()
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertThrowsError(try mockKeychain.retrieve(key: "INVALID_KEY")) { error in
            XCTAssertTrue(error is KeychainError)
            XCTAssertEqual((error as? KeychainError), .unableToRetrieve)
        }
    }
}
