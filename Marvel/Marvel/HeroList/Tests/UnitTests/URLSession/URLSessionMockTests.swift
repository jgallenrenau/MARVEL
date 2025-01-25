import XCTest
@testable import HeroList

final class URLSessionMockTests: XCTestCase {

    var request: URLSessionMock!
    var mock: URLSessionMock!

    override func setUp() {
        super.setUp()
        mock = URLSessionMock()
    }

    override func tearDown() {
        mock = nil
        request = nil
        super.tearDown()
    }

    func test_dataForRequest_success() async throws {
        let expectedData = "Mock data".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        mock.data = expectedData
        mock.response = expectedResponse

        let request = URLRequest(url: URL(string: "https://example.com")!)

        let (data, response) = try await mock.data(for: request)

        XCTAssertEqual(data, expectedData, "The data returned should match the mock data.")
        XCTAssertEqual(response as? HTTPURLResponse, expectedResponse, "The response returned should match the mock response.")
    }

    func test_dataForRequest_error() async {
        let expectedError = URLError(.badServerResponse)
        mock.error = expectedError

        let request = URLRequest(url: URL(string: "https://example.com")!)

        do {
            _ = try await mock.data(for: request)
            XCTFail("The mock should throw an error.")
        } catch {
            XCTAssertEqual(error as? URLError, expectedError, "The error thrown should match the mock error.")
        }
    }

    func test_dataForRequest_incompleteConfiguration() async {
        let request = URLRequest(url: URL(string: "https://example.com")!)

        do {
            _ = try await mock.data(for: request)
            XCTFail("The mock should throw an error due to incomplete configuration.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Mock not configured properly", "The error should indicate an incomplete configuration.")
        }
    }
}

