import Foundation

public struct APIHelper {
    
    public static func generateQueryItems(offset: Int? = nil, limit: Int? = nil) -> [URLQueryItem] {
        let publicKey = Constants.API.publicKey
        let privateKey = Constants.API.privateKey
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = AuthHelper.generateHash(ts: timestamp, privateKey: privateKey, publicKey: publicKey)

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]

        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }

        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }

        return queryItems
    }

    public static func createEndpoint(
        path: String,
        method: HTTPMethod = .get,
        offset: Int? = nil,
        limit: Int? = nil
    ) -> EndpointImpl {
        let queryItems = generateQueryItems(offset: offset, limit: limit)
        return EndpointImpl(method: method, path: path, queryItems: queryItems)
    }

}
