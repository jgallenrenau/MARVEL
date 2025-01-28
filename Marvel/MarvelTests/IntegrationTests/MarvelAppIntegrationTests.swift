import XCTest
import SwiftUI
@testable import MarvelApp

final class MarvelAppIntegrationTests: XCTestCase {

    func testSplashScreenTransition() {
        let app = MarvelApp()
        
        var didTransitionToMainView = false
        let splashScreen = SplashScreenView(onAnimationEnd: {
            didTransitionToMainView = true
        })

        let exp = expectation(description: "Transition to main view")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            XCTAssertTrue(didTransitionToMainView, "Should transition to HeroListCoordinator")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 4.0)
    }
}
