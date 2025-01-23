import Foundation

public enum NetworkError: Error, LocalizedError {
    
    case networkError(String)
    case invalidRequest
    case decodingFailed
    case invalidResponse
    case custom(message: String)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .networkError(let message): return "Network error: \(message)"
        case .invalidRequest: return "The request is invalid."
        case .decodingFailed: return "Failed to decode the server response."
        case .invalidResponse: return "The server response is invalid."
        case .custom(let message): return message
        case .unknown(let error): return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
