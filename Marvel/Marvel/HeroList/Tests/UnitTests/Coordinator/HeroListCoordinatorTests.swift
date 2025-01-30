import XCTest
import SwiftUI
import ComposableArchitecture
@testable import HeroList

@MainActor
final class HeroListCoordinatorTests: XCTestCase {
    
    func test_onHeroSelectedIsCalled() async {
        let testHero = Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)

        let store = Store(
            initialState: HeroesListFeature.State(heroes: [testHero]),
            reducer: {
                HeroesListFeature()
                    .dependency(\.fetchHeroes, { _, _ in [testHero] })
            }
        )

        _ = HeroesListView(store: store, onHeroSelected: { _ in
        })

        let viewStore = ViewStore(store, observe: { $0 })

        viewStore.send(.heroesLoadedSuccess([testHero]))

        XCTAssertNotNil(testHero)
    }
}
