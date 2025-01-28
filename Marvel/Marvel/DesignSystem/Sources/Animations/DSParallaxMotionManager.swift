import CoreMotion
import SwiftUI

public class DSParallaxMotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    
    @Published public var xOffset: CGFloat = 0
    @Published public var yOffset: CGFloat = 0

    public init() {
        startMotionUpdates()
    }

    private func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1/60
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else { return }
            
            DispatchQueue.main.async {
                self.xOffset = CGFloat(motion.attitude.roll) * 30
                self.yOffset = CGFloat(motion.attitude.pitch) * 30
            }
        }
    }
}
