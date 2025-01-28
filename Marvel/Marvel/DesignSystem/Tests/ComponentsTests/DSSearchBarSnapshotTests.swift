import XCTest
import SwiftUI
import SnapshotTesting
@testable import DesignSystem

final class DSSearchBarSnapshotTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]
    
    func testSearchBarSnapshot() {
        @State var searchText = ""

        let view = DSSearchBar(
            text: $searchText,
            placeholder: "Search...",
            bundle: .main,
            icon: "magnifyingglass",
            clearIcon: "xmark.circle.fill"
        )
        .frame(width: 300, height: 50)

        for (_, _) in devices {
            assertSnapshot(of: view, as: .image)
        }
    }
}
