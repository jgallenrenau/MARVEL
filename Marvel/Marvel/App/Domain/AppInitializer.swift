import SwiftUI
import Core

struct AppInitializer {
        
    static func initializeKeys() {
        do {
            let keys = try InfoPlistHelper.fetchKeysFromPlist()
            let predefinedKeys = InfoPlistHelper.PredefinedKeys.allCases
            
            for (index, value) in keys.enumerated() {
                try InfoPlistHelper.saveKeyIfNeeded(key: predefinedKeys[index].rawValue, value: value)
            }
        } catch {
            print("❌ Failed to initialize keys in Keychain: \(error)")
        }
    }
}
