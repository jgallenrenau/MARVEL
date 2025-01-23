import XCTest
@testable import Core

class APIClientTests: XCTestCase {
    var apiClient: APIClient!
    var mockLogger: MockLogger!

    override func setUp() {
        super.setUp()
        
        mockLogger = MockLogger()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)

        apiClient = APIClient(baseURL: URL(string: "https://mockurl.com")!, session: mockSession, logger: mockLogger)
    }

    override func tearDown() {
        super.tearDown()
        MockURLProtocol.reset()
    }

    func testRequestSuccess() async throws {
        MockURLProtocol.mockResponseData = """
        {
            "key": "value"
        }
        """.data(using: .utf8)
        MockURLProtocol.mockResponseStatusCode = 200

        let mockEndpoint = Endpoint(method: .get, path: "/test", queryItems: nil)

        let result: [String: String] = try await apiClient.request(endpoint: mockEndpoint, responseType: [String: String].self)
        
        XCTAssertEqual(result["key"], "value")
        XCTAssertTrue(mockLogger.loggedMessages.contains(where: { $0.contains("Starting request to https://mockurl.com/test") }))
        XCTAssertTrue(mockLogger.loggedMessages.contains(where: { $0.contains("Request succeeded for https://mockurl.com/test") }))
    }

    func testRequestInvalidResponse() async throws {
        MockURLProtocol.mockResponseStatusCode = 404
        MockURLProtocol.mockResponseData = nil

        let mockEndpoint = Endpoint(method: .get, path: "/not-found", queryItems: nil)

        do {
            _ = try await apiClient.request(endpoint: mockEndpoint, responseType: [String: String].self)
            XCTFail("Expected invalidResponse error")
        } catch NetworkError.invalidResponse {
            XCTAssertTrue(mockLogger.loggedMessages.contains(where: { $0.contains("Invalid response for https://mockurl.com/not-found") }))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRequestEmptyResponse() async throws {
        MockURLProtocol.mockResponseData = Data()
        MockURLProtocol.mockResponseStatusCode = 200

        let mockEndpoint = Endpoint(method: .get, path: "/empty-response", queryItems: nil)

        do {
            _ = try await apiClient.request(endpoint: mockEndpoint, responseType: [String: String].self)
            XCTFail("Expected decodingFailed error due to empty response")
        } catch NetworkError.decodingFailed {
            XCTAssertTrue(mockLogger.loggedMessages.contains(where: { $0.contains("Decoding failed") }))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
