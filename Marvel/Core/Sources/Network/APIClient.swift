import Foundation

public protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T
}

public class APIClient: APIClientProtocol {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    @available(iOS 15.0.0, *)
    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        guard let urlRequest = endpoint.makeURLRequest(baseURL: baseURL) else {
            throw NetworkError.invalidRequest
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
