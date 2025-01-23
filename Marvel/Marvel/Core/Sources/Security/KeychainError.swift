import Foundation

public enum KeychainError: Error {
    case unableToSave
    case unableToRetrieve
    case unableToDelete

    public var localizedDescription: String {
        switch self {
        case .unableToSave:
            return "Unable to save data to the Keychain."
        case .unableToRetrieve:
            return "Unable to retrieve data from the Keychain."
        case .unableToDelete:
            return "Unable to delete data from the Keychain."
        }
    }
}
