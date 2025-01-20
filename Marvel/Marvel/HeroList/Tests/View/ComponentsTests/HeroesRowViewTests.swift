import XCTest
import SnapshotTesting
@testable import HeroList

final class HeroesRowViewTests: XCTestCase {
    func testHeroRowViewSnapshot() {
        let hero = Hero(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man",
            thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!
        )
        let view = HeroesRowView(hero: hero)

        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
    }
}
