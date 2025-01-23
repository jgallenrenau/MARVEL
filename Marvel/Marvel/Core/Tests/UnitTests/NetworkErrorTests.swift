import XCTest
@testable import Core

class NetworkErrorTests: XCTestCase {
    
    func testNetworkErrorDescription() {
        let error = NetworkError.networkError("Test network error")
        XCTAssertEqual(error.errorDescription, "Network error: Test network error")
    }
    
    func testInvalidRequestDescription() {
        let error = NetworkError.invalidRequest
        XCTAssertEqual(error.errorDescription, "The request is invalid.")
    }
    
    func testDecodingFailedDescription() {
        let error = NetworkError.decodingFailed
        XCTAssertEqual(error.errorDescription, "Failed to decode the server response.")
    }
    
    func testInvalidResponseDescription() {
        let error = NetworkError.invalidResponse
        XCTAssertEqual(error.errorDescription, "The server response is invalid.")
    }
    
    func testCustomErrorDescription() {
        let error = NetworkError.custom(message: "Custom error message")
        XCTAssertEqual(error.errorDescription, "Custom error message")
    }
    
    func testUnknownErrorDescription() {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Underlying error occurred"])
        let error = NetworkError.unknown(underlyingError)
        XCTAssertEqual(error.errorDescription, "An unknown error occurred: Underlying error occurred")
    }
}
