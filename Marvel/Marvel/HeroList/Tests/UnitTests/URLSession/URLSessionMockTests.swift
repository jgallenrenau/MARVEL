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
            url: URL(string:"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        mock.data = expectedData
        mock.response = expectedResponse

        let request = URLRequest(url: URL(string:"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)

        let (data, response) = try await mock.data(for: request)

        XCTAssertEqual(data, expectedData, "The data returned should match the mock data.")
        XCTAssertEqual(response as? HTTPURLResponse, expectedResponse, "The response returned should match the mock response.")
    }
}

