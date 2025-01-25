import XCTest
@testable import Core

final class LoggerMockTests: XCTestCase {
    
    private var logger: LoggerMock!

    override func setUp() {
        super.setUp()
        logger = LoggerMock()
    }

    override func tearDown() {
        logger = nil
        super.tearDown()
    }

    func test_logInfo_addsMessageToInfoLogs() {
        let message = "This is an info log"
        
        logger.logInfo(message)
        
        XCTAssertEqual(logger.infoLogs.count, 1, "The infoLogs array should contain exactly one entry.")
        XCTAssertEqual(logger.infoLogs.first, message, "The first log in infoLogs should match the logged message.")
    }

    func test_logError_addsMessageToErrorLogs() {
        let message = "This is an error log"
        
        logger.logError(message)
        
        XCTAssertEqual(logger.errorLogs.count, 1, "The errorLogs array should contain exactly one entry.")
        XCTAssertEqual(logger.errorLogs.first, message, "The first log in errorLogs should match the logged message.")
    }

    func test_logInfoAndLogError_areIndependent() {
        let infoMessage = "Info log message"
        let errorMessage = "Error log message"
        
        logger.logInfo(infoMessage)
        logger.logError(errorMessage)
        
        XCTAssertEqual(logger.infoLogs.count, 1, "The infoLogs array should contain exactly one entry.")
        XCTAssertEqual(logger.errorLogs.count, 1, "The errorLogs array should contain exactly one entry.")
        XCTAssertEqual(logger.infoLogs.first, infoMessage, "The first log in infoLogs should match the logged message.")
        XCTAssertEqual(logger.errorLogs.first, errorMessage, "The first log in errorLogs should match the logged message.")
    }
}
