import XCTest
@testable import Core

final class LoggerTests: XCTestCase {
    func testLogging() {
        Logger.info("Test Info")
        Logger.warning("Test Warning")
        Logger.error("Test Error")
        XCTAssertTrue(true)
    }
}
