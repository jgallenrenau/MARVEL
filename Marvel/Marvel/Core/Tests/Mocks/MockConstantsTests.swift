import XCTest
@testable import Core

class MockConstantsTests: XCTestCase {
    
    private enum PredefinedKeys: String, CaseIterable {
        case publicKey = "MARVEL_PUBLIC_KEY"
        case privateKey = "MARVEL_PRIVATE_KEY"
    }
    
    override func setUp() {
        super.setUp()
        let keychainHelper: KeychainHelperProtocol = KeychainHelper()

        do {
            try keychainHelper.save(key: PredefinedKeys.privateKey.rawValue, value: "mockPrivateKey")
            try keychainHelper.save(key: PredefinedKeys.publicKey.rawValue, value: "mockPublicKey")
        } catch {
            print("❌ [TEST] Failed to initialize keys in Keychain: \(error)")
        }
    }
    
    func testPublicKey() {
        XCTAssertEqual(Constants.API.publicKey, "mockPublicKey")
    }
    
    func testPrivateKey() {
        XCTAssertEqual(Constants.API.privateKey, "mockPrivateKey")
    }
}
