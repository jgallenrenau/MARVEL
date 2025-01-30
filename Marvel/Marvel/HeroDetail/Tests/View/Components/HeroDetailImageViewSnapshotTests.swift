import XCTest
import SwiftUI
import SnapshotTesting
import ComposableArchitecture
@testable import HeroDetail

final class HeroDetailImageViewSnapshotTests: XCTestCase {

    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]

    func testHeroDetailImageViewEmptyState() {
        let view = HeroDetailImageViewMock(state: .empty)
        captureSnapshots(for: view, named: "HeroDetailImageView_EmptyState")
    }

    func testHeroDetailImageViewSuccessState() {
        let mockImage = Image(systemName: "checkmark")
        let view = HeroDetailImageViewMock(state: .success(mockImage))
        captureSnapshots(for: view, named: "HeroDetailImageView_SuccessState")
    }

    func testHeroDetailImageViewFailureState() {
        let view = HeroDetailImageViewMock(state: .failure)
        captureSnapshots(for: view, named: "HeroDetailImageView_FailureState")
    }

    private func captureSnapshots(for view: some View, named: String) {
        
        withSnapshotTesting(record: false) {
            for (deviceName, config) in devices {
                assertSnapshot(
                    of: view,
                    as: .image(layout: .device(config: config)),
                    named: "\(named)_\(deviceName)"
                )
            }
        }
    }
}
