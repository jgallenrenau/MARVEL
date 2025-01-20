import Foundation

public struct AppAPIKeysProvider {
    public var publicKey: String {
        do {
            return try KeychainHelper.retrieve(key: "MARVEL_PUBLIC_KEY")
        } catch {
            fatalError("Public Key not found in Keychain: \(error)")
        }
    }

    public var privateKey: String {
        do {
            return try KeychainHelper.retrieve(key: "MARVEL_PRIVATE_KEY")
        } catch {
            fatalError("Private Key not found in Keychain: \(error)")
        }
    }
}
