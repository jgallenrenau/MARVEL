import Foundation
import Core

final class MockAPIClient: APIClientProtocol {
    
    var response: Decodable?
    var error: Error?
    
    func request<T>(endpoint: Core.Endpoint, responseType: T.Type) async throws -> T where T : Decodable {
        if let error = error {
            throw error
        }
        guard let response = response as? T else {
            throw URLError(.badServerResponse)
        }
        return response
    }
}
