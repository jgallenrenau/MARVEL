import XCTest
@testable import Core

class APIClientIntegrationTests: XCTestCase {
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)

        apiClient = APIClient(baseURL: Constants.API.baseURL, session: mockSession)
    }

    override func tearDown() {
        super.tearDown()
        MockURLProtocol.reset()
    }

    func testRealAPIRequest() async throws {
        MockURLProtocol.mockResponseData = """
        {
            "data": {
                "results": [
                    { "id": 1, "name": "Spider-Man" },
                    { "id": 2, "name": "Iron Man" }
                ]
            }
        }
        """.data(using: .utf8)

        let endpoint = Endpoint(method: .get, path: "/v1/public/characters", queryItems: APIHelper.generateQueryItems(offset: 0, limit: 20))
        let result: MockResponse = try await apiClient.request(endpoint: endpoint, responseType: MockResponse.self)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.data.results.count, 2)
        XCTAssertEqual(result.data.results.first?.name, "Spider-Man")
    }

    func testInvalidResponseStatusCode() async throws {
        MockURLProtocol.mockResponseData = """
        {
            "error": "Invalid API Key"
        }
        """.data(using: .utf8)
        MockURLProtocol.mockResponseStatusCode = 401

        let endpoint = Endpoint(method: .get, path: "/v1/public/characters", queryItems: APIHelper.generateQueryItems(offset: 0, limit: 20))

        do {
            let _: MockResponse = try await apiClient.request(endpoint: endpoint, responseType: MockResponse.self)
            XCTFail("Request should have thrown an invalid response error")
        } catch NetworkError.invalidResponse {
            XCTAssertTrue(true, "Correctly threw invalidResponse error")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
