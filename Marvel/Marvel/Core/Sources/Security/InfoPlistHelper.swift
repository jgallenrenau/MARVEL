import Foundation
import Security

public protocol InfoPlistProvider {
    func value(forKey key: String) -> String?
}

public class DefaultInfoPlistProvider: InfoPlistProvider {
    public init() {}
    
    public func value(forKey key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
}

public class InfoPlistHelper {
    
    private static var infoPlistProvider: InfoPlistProvider = DefaultInfoPlistProvider()
    private static let keychainHelper: KeychainHelperProtocol = KeychainHelper()

    public static func fetchKeysFromPlist() throws -> [String] {
        guard let publicKey = infoPlistProvider.value(forKey: PredefinedKeys.publicKey.rawValue),
              let privateKey = infoPlistProvider.value(forKey: PredefinedKeys.privateKey.rawValue) else {
            throw AppInitializerError.missingPlistEntry
        }
        
        return [publicKey, privateKey]
    }
    
    public static func saveKeyIfNeeded(key: String, value: String) throws {
        if (try? keychainHelper.retrieve(key: key)) == nil {
            try keychainHelper.save(key: key, value: value)
            print("✅ \(key) saved to Keychain 🔐")
        } else {
            print("ℹ️ \(key) already exists in Keychain 🔑")
        }
    }
    
    public static func setInfoPlistProvider(_ provider: InfoPlistProvider) {
        infoPlistProvider = provider
    }
    
    public enum PredefinedKeys: String, CaseIterable {
        case publicKey = "MARVEL_PUBLIC_KEY"
        case privateKey = "MARVEL_PRIVATE_KEY"
    }
    
    enum AppInitializerError: Error {
        case missingPlistEntry
    }
}
