import XCTest
import SwiftUI
import SnapshotTesting
@testable import DesignSystem

final class DSCenteredSpinnerViewTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]
    
    func testDSCenteredSpinnerViewSnapshot() {
        let view = DSCenteredSpinnerView(isLoading: true)
            .frame(width: 100, height: 100)

        assertSnapshot(of: view, as: .image)
        
        for (deviceName, config) in devices {
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "DSCenteredSpinnerView_\(deviceName)"
            )
        }
    }
}
