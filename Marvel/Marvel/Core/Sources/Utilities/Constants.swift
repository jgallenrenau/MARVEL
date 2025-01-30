import Foundation

public struct Constants {
    
    private static var keychainHelper: KeychainHelperProtocol = KeychainHelper()

    public struct API {
        
        public static var baseURL: URL {
            return URL(string: "https://gateway.marvel.com")!
        }

        public static var publicKey: String {
            do {
                return try keychainHelper.retrieve(key: "MARVEL_PUBLIC_KEY")
            } catch {
                fatalError("Public Key not found in Keychain: \(error)")
            }
        }

        public static var privateKey: String {
            do {
                return try keychainHelper.retrieve(key: "MARVEL_PRIVATE_KEY")
            } catch {
                fatalError("Private Key not found in Keychain: \(error)")
            }
        }
    }
    
    public static func setKeychainHelper(_ helper: KeychainHelperProtocol) {
        keychainHelper = helper
    }
    
    public struct PaginationConfig {
        public static let pageSize = 20
        public static let thresholdForLoadingMore = PaginationConfig.pageSize/2
    }
}
