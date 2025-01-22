import XCTest
@testable import Core

class ConstantsTests: XCTestCase {
    func testBaseURL() {
        XCTAssertEqual(Constants.API.baseURL.absoluteString, "https://gateway.marvel.com")
    }
    
    func testPublicKey() throws {
        let mockKeychain = MockKeychainHelper()
        try mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")

        let publicKey = Constants.API.publicKey
        XCTAssertEqual(publicKey, "mockPublicKey")
    }
}
