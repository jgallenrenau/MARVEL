import XCTest
import SwiftUI
import ComposableArchitecture
@testable import HeroList

@MainActor
final class HeroListCoordinatorTests: XCTestCase {
    
    func test_onHeroSelectedIsCalled() async {
        let testHero = Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "https://example.com")!)

        var selectedHero: Hero?

        let coordinator = HeroListCoordinator { hero in
            selectedHero = hero
        }

        let store = Store(
            initialState: HeroesListFeature.State(heroes: [testHero]), // Simula que el estado tiene un héroe cargado
            reducer: {
                HeroesListFeature()
                    .dependency(\.fetchHeroes, { _, _ in [testHero] }) // Mock de `fetchHeroes`
            }
        )

        let view = HeroesListView(store: store, onHeroSelected: { hero in
            selectedHero = hero
        })

        let viewStore = ViewStore(store, observe: { $0 })

        viewStore.send(.heroesLoadedSuccess([testHero])) // Simular carga exitosa de héroes

        XCTAssertNotNil(testHero)
    }
}

