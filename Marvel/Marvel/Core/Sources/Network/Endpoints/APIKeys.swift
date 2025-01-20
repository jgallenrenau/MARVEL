import Foundation

struct APIKeys {
    static func getPublicKey() throws -> String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_PUBLIC_KEY") as? String else {
            throw APIKeysError.missingKey("API_PUBLIC_KEY")
        }
        return key
    }

    static func getPrivateKey() throws -> String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_PRIVATE_KEY") as? String else {
            throw APIKeysError.missingKey("API_PRIVATE_KEY")
        }
        return key
    }
}

enum APIKeysError: Error {
    case missingKey(String)
}
