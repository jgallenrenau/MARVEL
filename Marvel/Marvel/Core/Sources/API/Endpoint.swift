import Foundation

public protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    func makeURLRequest(baseURL: URL) -> URLRequest?
}

public struct Endpoint: EndpointProtocol {
    public let method: HTTPMethod
    public let path: String
    public let queryItems: [URLQueryItem]?

    public init(method: HTTPMethod, path: String, queryItems: [URLQueryItem]? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
    }

    public func makeURLRequest(baseURL: URL) -> URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
