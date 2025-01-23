import XCTest
@testable import Core

class LoggerTests: XCTestCase {
    func testLogInfo() {
        let logger = MockLogger()
        logger.logInfo("Test info message")
        XCTAssertTrue(logger.loggedMessages.contains("INFO: Test info message"))
    }

    func testLogError() {
        let logger = MockLogger()
        logger.logError("Test error message")
        XCTAssertTrue(logger.loggedMessages.contains("ERROR: Test error message"))
    }

    func testLogWarning() {
        let logger = MockLogger()
        logger.logWarning("Test warning message")
        XCTAssertTrue(logger.loggedMessages.contains("WARNING: Test warning message"))
    }

    func testLogMultipleMessages() {
        let logger = MockLogger()
        logger.logInfo("First info message")
        logger.logWarning("First warning message")
        logger.logError("First error message")
        XCTAssertEqual(logger.loggedMessages.count, 3)
        XCTAssertTrue(logger.loggedMessages.contains("INFO: First info message"))
        XCTAssertTrue(logger.loggedMessages.contains("WARNING: First warning message"))
        XCTAssertTrue(logger.loggedMessages.contains("ERROR: First error message"))
    }

    func testLogEmptyMessage() {
        let logger = MockLogger()
        logger.logInfo("")
        XCTAssertTrue(logger.loggedMessages.contains("INFO: "))
    }

    func testLogErrorWithAdditionalInfo() {
        let logger = MockLogger()
        logger.logError("Test error message with details: Invalid response")
        XCTAssertTrue(logger.loggedMessages.contains("ERROR: Test error message with details: Invalid response"))
    }

    func testLoggerResetsMessages() {
        let logger = MockLogger()
        logger.logInfo("Test message before reset")
        XCTAssertEqual(logger.loggedMessages.count, 1)

        logger.loggedMessages.removeAll()
        XCTAssertTrue(logger.loggedMessages.isEmpty)
    }
}
