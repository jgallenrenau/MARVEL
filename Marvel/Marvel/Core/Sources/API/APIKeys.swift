import Foundation

public struct APIKeys {
    
    internal static func getPublicKey() throws -> String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_PUBLIC_KEY") as? String else {
            throw APIKeysError.missingKey("API_PUBLIC_KEY")
        }
        return key
    }

    internal static func getPrivateKey() throws -> String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_PRIVATE_KEY") as? String else {
            throw APIKeysError.missingKey("API_PRIVATE_KEY")
        }
        return key
    }
}

internal enum APIKeysError: Error {
    case missingKey(String)
}
