import XCTest
@testable import Core

class APIClientIntegrationTests: XCTestCase {
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        apiClient = APIClient(baseURL: Constants.API.baseURL)
    }

    func testRealAPIRequest() async throws {
        let endpoint = Endpoint(method: .get, path: "/v1/public/characters", queryItems: APIHelper.generateQueryItems(offset: 0, limit: 20))
        let result: MockResponse = try await apiClient.request(endpoint: endpoint, responseType: MockResponse.self)
        XCTAssertNotNil(result)
    }

}
