//import XCTest
//import SwiftUI
//@testable import Marvel
//
//final class MarvelAppIntegrationTests: XCTestCase {
//
//    func testSplashScreenTransition() {
//        var didTransitionToMainView = false
//        let splashScreen = SplashScreenView(onAnimationEnd: {
//            didTransitionToMainView = true
//        })
//
//        let hostingController = UIHostingController(rootView: splashScreen)
//        
//        let window = UIWindow()
//        window.rootViewController = hostingController
//        window.makeKeyAndVisible()
//
//        let exp = expectation(description: "Transition to main view")
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
//            XCTAssertTrue(didTransitionToMainView, "Should transition to HeroListCoordinator")
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 4.0)
//    }
//}
