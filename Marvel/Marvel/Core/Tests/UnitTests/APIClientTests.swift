import XCTest
@testable import Core

class APIClientTests: XCTestCase {
    var apiClient: APIClient!
    var mockLogger: MockLogger!

    override func setUp() {
        super.setUp()
        mockLogger = MockLogger()
        apiClient = APIClient(baseURL: URL(string: "https://mockurl.com")!, logger: mockLogger)
    }

    func testRequestSuccess() async throws {
        let mockEndpoint = Endpoint(method: .get, path: "/test", queryItems: nil)
        let mockResponse = MockAPIClient()
        mockResponse.mockResponseData = "{\"key\":\"value\"}".data(using: .utf8)

        let result: [String: String] = try await apiClient.request(endpoint: mockEndpoint, responseType: [String: String].self)

        XCTAssertEqual(result["key"], "value")
    }

    func testRequestFailure() async throws {
        let mockEndpoint = Endpoint(method: .get, path: "/test", queryItems: nil)
        let mockResponse = MockAPIClient()
        mockResponse.shouldReturnError = true

        do {
            _ = try await apiClient.request(endpoint: mockEndpoint, responseType: [String: String].self)
            XCTFail("The request should have thrown an error, but it did not.")
        } catch {
            XCTAssertTrue(error is NetworkError, "Expected NetworkError, but got \(error)")
        }
    }
}
