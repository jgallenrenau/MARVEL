import XCTest
@testable import Core

class MockConstantsTests: XCTestCase {
    
    private enum PredefinedKeys: String, CaseIterable {
        case publicKey = "MARVEL_PUBLIC_KEY"
        case privateKey = "MARVEL_PRIVATE_KEY"
    }
    
    override func setUp() {
        super.setUp()
        
        let mockKeychainHelper = MockKeychainHelper()
        
        do {
            try mockKeychainHelper.save(key: PredefinedKeys.privateKey.rawValue, value: "mockPrivateKey")
            try mockKeychainHelper.save(key: PredefinedKeys.publicKey.rawValue, value: "mockPublicKey")
        } catch {
            XCTFail("❌ [TEST] Failed to initialize keys in Keychain: \(error)")
        }
        
        Constants.setKeychainHelper(mockKeychainHelper)
    }
    
    override func tearDown() {
        super.tearDown()
        
        Constants.setKeychainHelper(KeychainHelper())
    }
    
    func testPublicKey() {
        XCTAssertEqual(Constants.API.publicKey, "mockPublicKey")
    }
    
    func testPrivateKey() {
        XCTAssertEqual(Constants.API.privateKey, "mockPrivateKey")
    }
}
