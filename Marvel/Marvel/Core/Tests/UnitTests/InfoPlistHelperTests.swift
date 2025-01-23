import XCTest
@testable import Core

class InfoPlistHelperTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let mockKeychainHelper = MockKeychainHelper()
        Constants.setKeychainHelper(mockKeychainHelper)
    }
    
    func testFetchKeysFromPlistSuccess() throws {
        let mockValues: [String: String] = [
            "MARVEL_PUBLIC_KEY": "mockPublicKey",
            "MARVEL_PRIVATE_KEY": "mockPrivateKey"
        ]
        let mockProvider = MockInfoPlistProvider(mockValues: mockValues)
        InfoPlistHelper.setInfoPlistProvider(mockProvider)
        
        let keys = try InfoPlistHelper.fetchKeysFromPlist()
        
        XCTAssertEqual(keys.count, 2)
        XCTAssertEqual(keys[0], "mockPublicKey")
        XCTAssertEqual(keys[1], "mockPrivateKey")
    }
    
    func testFetchKeysFromPlistFailure() {
        let mockProvider = MockInfoPlistProvider(mockValues: [:])
        InfoPlistHelper.setInfoPlistProvider(mockProvider)
        
        XCTAssertThrowsError(try InfoPlistHelper.fetchKeysFromPlist()) { error in
            XCTAssertEqual(error as? InfoPlistHelper.AppInitializerError, .missingPlistEntry)
        }
    }
}
