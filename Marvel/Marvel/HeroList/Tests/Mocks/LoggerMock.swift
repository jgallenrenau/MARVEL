import Foundation
@testable import Core

final class LoggerMock: LoggerProtocol {
    var infoLogs: [String] = []
    var errorLogs: [String] = []

    func logInfo(_ message: String) {
        infoLogs.append(message)
    }

    func logError(_ message: String) {
        errorLogs.append(message)
    }
}
