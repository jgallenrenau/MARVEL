import Foundation
@testable import Core

class MockAPIClient: APIClientProtocol {
    var shouldReturnError = false
    var mockResponseData: Data?

    func request<T: Decodable>(endpoint: EndpointProtocol, responseType: T.Type) async throws -> T {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        guard let data = mockResponseData else {
            throw NetworkError.decodingFailed
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
