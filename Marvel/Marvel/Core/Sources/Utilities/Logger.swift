import os.log

public class Logger {
    private static let logger = Logger()

    public static func info(_ message: String) {
        os_log(.info, "%@", message)
    }

    public static func warning(_ message: String) {
        os_log(.default, "%@", message)
    }

    public static func error(_ message: String, error: Error? = nil) {
        os_log(.error, "%@", message)
        if let error = error {
            os_log(.error, "Details: %@", error.localizedDescription)
        }
    }
}
