import XCTest
import SwiftUI
import SnapshotTesting
@testable import HeroList

final class HeroesRowViewSnapshotTests: XCTestCase {

    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]

    func testHeroesRowViewSnapshot() {
        let hero = Hero(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            thumbnailURL: URL(string: "https://via.placeholder.com/150")!
        )
        
        let view = HeroesRowView(hero: hero)
            .frame(width: 300, height: 100)

        for (deviceName, config) in devices {
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroesRowView_\(deviceName)"
            )
        }
    }
}
