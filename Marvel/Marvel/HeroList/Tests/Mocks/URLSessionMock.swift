import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

final public class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    public enum MockError: Error, LocalizedError {
        case incompleteConfiguration

        public var errorDescription: String? {
            switch self {
            case .incompleteConfiguration:
                return "Mock not configured properly"
            }
        }
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data, let response = response else {
            fatalError("Mock not configured properly")
        }
        return (data, response)
    }
}
