import XCTest
import SnapshotTesting
@testable import Marvel

import XCTest
import SnapshotTesting
@testable import Marvel

final class SplashScreenSnapshotTests: XCTestCase {
    
    func testSplashScreenView() {
        let splashScreen = SplashScreenView(onAnimationEnd: {})

        assertSnapshot(of: splashScreen, as: .image(layout: .fixed(width: 375, height: 667)))
    }
}

