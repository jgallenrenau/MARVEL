import XCTest
import SwiftUI
import SnapshotTesting
@testable import DesignSystem

final class DSHeaderViewTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]
    
    func testHeaderViewSnapshot() {
        let view = DSHeaderView(
            key: "header_title",
            bundle: .main
        )
        .frame(width: 300, height: 100)

        assertSnapshot(of: view, as: .image)
        
        for (_, _) in devices {
            assertSnapshot(of: view, as: .image)
        }
    }
}
