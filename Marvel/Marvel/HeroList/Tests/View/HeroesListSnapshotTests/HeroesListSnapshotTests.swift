import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import HeroList

final class HeroesListSnapshotTests: XCTestCase {
    func testHeroesListViewSnapshot() {
        let heroes = [
            Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "https://example.com")!),
            Hero(id: 2, name: "Iron Man", description: "Hero", thumbnailURL: URL(string: "https://example.com")!)
        ]
        
        let store = Store(
            initialState: HeroesListFeature.State(heroes: heroes),
            reducer: { HeroesListFeature() }
        )
        
        let view = HeroesListView(store: store, onHeroSelected: { _ in })
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
