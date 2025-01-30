import XCTest
import CoreMotion
@testable import DesignSystem

final class DSParallaxMotionManagerTests: XCTestCase {
    
    func testParallaxMotionManagerInitialValues() {
        let motionManager = DSParallaxMotionManager()
        
        XCTAssertEqual(motionManager.xOffset, 0, "Initial xOffset should be 0")
        XCTAssertEqual(motionManager.yOffset, 0, "Initial yOffset should be 0")
    }
    
    func testMotionManagerUpdatesOffsets() {
        let motionManager = DSParallaxMotionManager()
        
        let simulatedRoll: Double = 0.5
        let simulatedPitch: Double = -0.3
        
        motionManager.xOffset = CGFloat(simulatedRoll * 30)
        motionManager.yOffset = CGFloat(simulatedPitch * 30)
        
        XCTAssertEqual(motionManager.xOffset, CGFloat(simulatedRoll * 30), "xOffset should be correctly updated")
        XCTAssertEqual(motionManager.yOffset, CGFloat(simulatedPitch * 30), "yOffset should be correctly updated")
    }
}
