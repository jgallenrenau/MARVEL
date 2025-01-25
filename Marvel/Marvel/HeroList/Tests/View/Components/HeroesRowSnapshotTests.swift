import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroList

final class HeroesRowSnapshotTests: XCTestCase {
    func testHeroesRowViewSnapshot() {

        let hero = Hero(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man",
            thumbnailURL: URL(string: "https://example.com")!
        )

        let view = HeroesRowView(hero: hero)
            .frame(width: 300, height: 120)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }
}
