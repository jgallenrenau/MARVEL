import Foundation

public protocol KeychainHelperProtocol {
    func save(key: String, value: String) throws
    func retrieve(key: String) throws -> String
    func delete(key: String) throws
}
