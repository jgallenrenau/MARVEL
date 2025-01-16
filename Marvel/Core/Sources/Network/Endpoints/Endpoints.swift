import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }

    func makeURLRequest(baseURL: URL) -> URLRequest?
}
