import Foundation
@testable import Core

final class APIClientMock: APIClientProtocol {
    var result: Result<Data, Error>?

    func request<T: Decodable>(
        endpoint: EndpointProtocol,
        responseType: T.Type
    ) async throws -> T {
        guard let result = result else {
            fatalError("Result not set for APIClientMock")
        }

        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(responseType, from: data)
        case .failure(let error):
            throw error
        }
    }
}
