import Foundation
import CryptoKit

public struct AuthHelper {
    
    public static func generateHash(ts: String, privateKey: String, publicKey: String) -> String {
        if #available(iOS 13.0, *) {
            let input = ts + privateKey + publicKey
            let inputData = Data(input.utf8)
            let hashedData = Insecure.MD5.hash(data: inputData)
            return hashedData.map { String(format: "%02hhx", $0) }.joined()
        } else {
            fatalError("MD5 hashing is not supported below iOS 13.0.")
        }
    }
}
