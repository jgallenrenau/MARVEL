import SwiftUI
import Core

struct AppInitializer {

    private static let keychainHelper: KeychainHelperProtocol = KeychainHelper()

    static func initializeKeys() {
        do {
            let keys = try fetchKeysFromPlist()
            let predefinedKeys = PredefinedKeys.allCases

            for (index, value) in keys.enumerated() {
                try saveKeyIfNeeded(key: predefinedKeys[index].rawValue, value: value)
            }
        } catch {
            print("❌ Failed to initialize keys in Keychain: \(error)")
        }
    }

    private static func fetchKeysFromPlist() throws -> [String] {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let publicKey = infoDictionary[PredefinedKeys.publicKey.rawValue] as? String,
              let privateKey = infoDictionary[PredefinedKeys.privateKey.rawValue] as? String else {
            throw AppInitializerError.missingPlistEntry
        }
        return [publicKey, privateKey]
    }

    private static func saveKeyIfNeeded(key: String, value: String) throws {
        if (try? keychainHelper.retrieve(key: key)) == nil {
            try keychainHelper.save(key: key, value: value)
            print("✅ \(key) saved to Keychain 🔐")
        } else {
            print("ℹ️ \(key) already exists in Keychain 🔑")
        }
    }
}

private enum PredefinedKeys: String, CaseIterable {
    case publicKey = "MARVEL_PUBLIC_KEY"
    case privateKey = "MARVEL_PRIVATE_KEY"
}

enum AppInitializerError: Error {
    case missingPlistEntry
}

