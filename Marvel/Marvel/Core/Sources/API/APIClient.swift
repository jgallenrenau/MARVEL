import Foundation
import os.log

public class APIClient: APIClientProtocol {
    private let baseURL: URL
    private let session: URLSessionProtocol
    private let logger: LoggerProtocol

    public init(baseURL: URL, session: URLSessionProtocol = URLSession.shared, logger: LoggerProtocol = Logger()) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
    }

    public func request<T: Decodable>(endpoint: EndpointProtocol, responseType: T.Type) async throws -> T {
        guard let urlRequest = endpoint.makeURLRequest(baseURL: baseURL) else {
            throw NetworkError.invalidRequest
        }

        logger.logInfo("Starting request to \(urlRequest.url?.absoluteString ?? "unknown URL")")

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            logger.logError("Invalid response for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            throw NetworkError.invalidResponse
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            logger.logInfo("Request succeeded for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            logger.logError("Raw Response: \(String(data: data, encoding: .utf8) ?? "nil")")
            return decodedResponse
        } catch {
            logger.logError("Decoding failed: \(error.localizedDescription)")
            logger.logError("Raw data: \(String(data: data, encoding: .utf8) ?? "nil")")
            throw NetworkError.decodingFailed
        }
    }
}
