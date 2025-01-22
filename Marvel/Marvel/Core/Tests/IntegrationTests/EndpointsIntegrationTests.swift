import XCTest
@testable import Core

class EndpointsIntegrationTests: XCTestCase {
    func testEndpointCreation() {
        let endpoint = Endpoint(method: .get, path: "/test", queryItems: nil)
        let request = endpoint.makeURLRequest(baseURL: Constants.API.baseURL)
        XCTAssertEqual(request?.url?.absoluteString, "https://gateway.marvel.com/test")
    }
}
