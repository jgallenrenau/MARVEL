import XCTest
import SnapshotTesting
import SwiftUI
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

    func testHeroDetailImageViewSnapshot() {
        let imageURL = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!

        for (deviceName, config) in devices {
            let view = HeroDetailImageView(imageURL: imageURL)

            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroDetailImageView_\(deviceName)"
            )
        }
    }
}
