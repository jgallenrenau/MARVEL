import Foundation
@testable import Core

class MockKeychainHelper: KeychainHelperProtocol {
    
    private var storage: [String: String] = [:]
    
    func save(key: String, value: String) throws {
        storage[key] = value
    }
    
    func retrieve(key: String) throws -> String {
        if let value = storage[key] {
            return value
        } else {
            throw KeychainError.unableToRetrieve
        }
    }
    
    func delete(key: String) throws {
        storage.removeValue(forKey: key)
    }
}
