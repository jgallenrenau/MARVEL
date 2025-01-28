import XCTest
@testable import MarvelApp

final class AppInitializerTests: XCTestCase {
    
    func testInitializeKeys() {
        let mockHelper = MockInfoPlistHelper()
        InfoPlistHelper.instance = mockHelper
        
        AppInitializer.initializeKeys()
        
        XCTAssertTrue(mockHelper.didFetchKeys, "Should fetch keys from plist")
        XCTAssertTrue(mockHelper.didSaveKeys, "Should save keys in Keychain")
    }
}

final class MockInfoPlistHelper: InfoPlistHelperProtocol {
    var didFetchKeys = false
    var didSaveKeys = false

    func fetchKeysFromPlist() throws -> [String] {
        didFetchKeys = true
        return ["key1", "key2"]
    }

    func saveKeyIfNeeded(key: String, value: String) throws {
        didSaveKeys = true
    }
}
