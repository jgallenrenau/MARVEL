import Foundation

public struct Constants {
    
    public struct API {
        
        public static var baseURL: URL {
            return URL(string: "https://gateway.marvel.com")!
        }

        public static var publicKey: String {
            do {
                return try KeychainHelper.retrieve(key: "MARVEL_PUBLIC_KEY")
            } catch {
                fatalError("Public Key not found in Keychain: \(error)")
            }
        }

        public static var privateKey: String {
            do {
                return try KeychainHelper.retrieve(key: "MARVEL_PRIVATE_KEY")
            } catch {
                fatalError("Private Key not found in Keychain: \(error)")
            }
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
}
