import Foundation
@testable import Core

class MockKeychainHelper: KeychainHelperProtocol {
    var storage: [String: String] = [:]

    func save(key: String, value: String) throws {
        storage[key] = value
    }

    func retrieve(key: String) throws -> String {
        guard let value = storage[key] else {
            throw KeychainError.unableToRetrieve
        }
        return value
    }

    func delete(key: String) throws {
        storage.removeValue(forKey: key)
    }
}
