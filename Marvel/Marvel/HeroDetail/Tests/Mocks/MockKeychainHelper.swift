import Foundation
@testable import Core

final class MockKeychainHelper: KeychainHelperProtocol {
    private var storage: [String: String] = [:]

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
        guard storage.removeValue(forKey: key) != nil else {
            throw KeychainError.unableToDelete
        }
    }
}
