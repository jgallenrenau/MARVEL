//import XCTest
//
//import Foundation
//@testable import Core
//
//
//// Mock para InfoPlistProvider
//final class MockInfoPlistProvider: InfoPlistProvider {
//    private let values: [String: String]
//    
//    init(values: [String: String]) {
//        self.values = values
//    }
//    
//    func value(forKey key: String) -> String? {
//        return values[key]
//    }
//}
//
//// Mock para KeychainHelper
//final class MockKeychainHelper: KeychainHelperProtocol {
//    private var storage: [String: String] = [:]
//    
//    func save(key: String, value: String) throws {
//        storage[key] = value
//    }
//    
//    func retrieve(key: String) throws -> String {
//        guard let value = storage[key] else { throw NSError(domain: "Key not found", code: -1, userInfo: nil) }
//        return value
//    }
//    
//    func delete(key: String) throws {
//        storage.removeValue(forKey: key)
//    }
//}
//
//final class AppInitializerTests: XCTestCase {
//    
//    override func setUp() {
//        super.setUp()
//        // Reset mocks antes de cada test
//        InfoPlistHelper.setKeychainHelper(MockKeychainHelper())
//        InfoPlistHelper.setInfoPlistProvider(MockInfoPlistProvider(values: [:]))
//    }
//
//    func test_initializeKeys_success() throws {
//        // Mock InfoPlistProvider con claves válidas
//        let mockPlistProvider = MockInfoPlistProvider(values: [
//            InfoPlistHelper.PredefinedKeys.publicKey.rawValue: "mockPublicKey",
//            InfoPlistHelper.PredefinedKeys.privateKey.rawValue: "mockPrivateKey"
//        ])
//        
//        // Mock KeychainHelper
//        let mockKeychainHelper = MockKeychainHelper()
//        
//        // Reemplazar los valores en el helper
//        InfoPlistHelper.setInfoPlistProvider(mockPlistProvider)
//        InfoPlistHelper.setKeychainHelper(mockKeychainHelper)
//        
//        // Ejecutar método
//        AppInitializer.initializeKeys()
//        
//        // Validar que las claves se guardaron en el keychain
//        XCTAssertEqual(try mockKeychainHelper.retrieve(key: "MARVEL_PUBLIC_KEY"), "mockPublicKey")
//        XCTAssertEqual(try mockKeychainHelper.retrieve(key: "MARVEL_PRIVATE_KEY"), "mockPrivateKey")
//    }
//    
//    func test_initializeKeys_missingKeys() throws {
//        let mockPlistProvider = MockInfoPlistProvider(values: [:]) // Simulamos claves faltantes
//        InfoPlistHelper.setInfoPlistProvider(mockPlistProvider)
//        
//        XCTAssertThrowsError(try InfoPlistHelper.fetchKeysFromPlist(), "Debe lanzar un error por claves faltantes") { error in
//            XCTAssertEqual(error as? InfoPlistHelper.AppInitializerError, .missingPlistEntry)
//        }
//    }
//}
