import os.log

public protocol LoggerProtocol {
    func logInfo(_ message: String)
    func logError(_ message: String)
}

public class Logger: LoggerProtocol {
    public init() {}

    public func logInfo(_ message: String) {
        os_log(.info, "%@", message)
    }

    public func logError(_ message: String) {
        os_log(.error, "%@", message)
    }
}
