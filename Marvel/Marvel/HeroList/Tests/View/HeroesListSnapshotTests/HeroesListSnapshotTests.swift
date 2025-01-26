import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import HeroList

final class HeroesListSnapshotTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 1· Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]
    
    func testHeroesListViewSnapshot() {
        let heroes = [
            Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!),
            Hero(id: 2, name: "Iron Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
        ]
        
        let store = Store(
            initialState: HeroesListFeature.State(heroes: heroes),
            reducer: { HeroesListFeature() }
        )
        
        for (deviceName, config) in devices {
            let view = HeroesListView(store: store, onHeroSelected: { _ in })
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroesListView_\(deviceName)"
            )
        }
    }
}
