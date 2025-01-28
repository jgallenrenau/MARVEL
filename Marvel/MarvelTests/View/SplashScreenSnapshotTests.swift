import XCTest
import SnapshotTesting
@testable import MarvelApp

final class SplashScreenSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    func testSplashScreenView() {
        let splashScreen = SplashScreenView(onAnimationEnd: {})
        assertSnapshot(matching: splashScreen, as: .image(layout: .size(CGSize(width: 375, height: 667))))
    }
}
