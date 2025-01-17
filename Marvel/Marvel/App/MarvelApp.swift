import SwiftUI
import Core

@main
struct MarvelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    AppInitializer.initializeKeys()
                }
        }
    }
}

extension MarvelApp {
    
    struct AppInitializer {
        static func initializeKeys() {
            do {
                let keys = try fetchKeysFromPlist()
                
                let predefinedKeys = ["MARVEL_PUBLIC_KEY", "MARVEL_PRIVATE_KEY"]

                for (index, value) in keys.enumerated() {
                    try saveKeyIfNeeded(key: predefinedKeys[index], value: value)
                }
            } catch {
                print("Failed to initialize keys in Keychain: \(error) 😫")
            }
        }


        private static func fetchKeysFromPlist() throws -> [String] {
            guard let infoDictionary = Bundle.main.infoDictionary,
                  let publicKey = infoDictionary["MARVEL_PUBLIC_KEY"] as? String,
                  let privateKey = infoDictionary["MARVEL_PRIVATE_KEY"] as? String else {
                throw AppInitializerError.missingPlistEntry
            }
            return [publicKey, privateKey]
        }

        private static func saveKeyIfNeeded(key: String, value: String) throws {
            if (try? KeychainHelper.retrieve(key: key)) == nil {
                try KeychainHelper.save(key: key, value: value)
                print("\(key) saved to Keychain 🔐 !")
            } else {
                print("We have keys in Keychain 🔑 !")
            }
        }
    }

    enum AppInitializerError: Error {
        case missingPlistEntry
    }
}
