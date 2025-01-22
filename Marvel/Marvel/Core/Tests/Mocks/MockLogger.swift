import Foundation
@testable import Core

class MockLogger: LoggerProtocol {
    var loggedMessages: [String] = []

    func logInfo(_ message: String) {
        loggedMessages.append("INFO: \(message)")
    }

    func logWarning(_ message: String) {
        loggedMessages.append("WARNING: \(message)")
    }

    func logError(_ message: String) {
        loggedMessages.append("ERROR: \(message)")
    }
}
