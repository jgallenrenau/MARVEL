import XCTest
import SwiftUI
import SnapshotTesting
@testable import DesignSystem

final class DSSectionHeaderViewTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]

    func testSectionHeaderViewSnapshot() {
        let view = DSSectionHeaderView(
            localizedKey: "section_title",
            bundle: .main
        )
        .frame(width: 300, height: 50)
        .background(Color.black)

        for (_, _) in devices {
            assertSnapshot(of: view, as: .image)
        }   
    }
}
