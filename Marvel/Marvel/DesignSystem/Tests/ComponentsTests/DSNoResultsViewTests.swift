import XCTest
import SwiftUI
import SnapshotTesting
@testable import DesignSystem

final class DSNoResultsViewTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]
    
    func testNoResultsViewSnapshot() {
        
        let view = DSNoResultsView(
            imageName: "magnifyingglass.circle",
            title: "No results found",
            message: "Try adjusting your search criteria."
        )
        .frame(width: 300, height: 300)
        
        for (_, _) in devices {
            assertSnapshot(of: view, as: .image)
        }
    }
}
