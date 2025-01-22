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
}
