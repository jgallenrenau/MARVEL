import Foundation

public protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: EndpointProtocol, responseType: T.Type) async throws -> T
}
