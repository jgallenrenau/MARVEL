import Foundation
@testable import Core

final class MockAPIClient: APIClientProtocol {
    var shouldReturnError = false
    var mockResponseData: Data?

    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }

        guard let data = mockResponseData else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(responseType, from: data)
    }
}
