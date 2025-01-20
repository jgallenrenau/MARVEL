import XCTest
import ComposableArchitecture
@testable import HeroList

final class HeroesListIntegrationTests: XCTestCase {
    func testHeroesListIntegrationSuccess() async {

        let heroes = [
            Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)
        ]
        let store = await TestStore(
            initialState: HeroesListFeature.State(),
            reducer: { HeroesListFeature() }
        )
        
        await MainActor.run {
            store.dependencies.fetchHeroes = { _, _ in heroes }
        }

        await store.send(.fetchHeroes) {
            $0.isLoading = true
        }
        await store.receive(.heroesLoadedSuccess(heroes)) {
            $0.heroes = heroes
            $0.isLoading = false
        }

        await MainActor.run {
            XCTAssertEqual(store.state.heroes.count, 1)
            XCTAssertEqual(store.state.heroes.first?.name, "Spider-Man")
        }
    }

    func testHeroesListIntegrationFailure() async {

        let store = await TestStore(
            initialState: HeroesListFeature.State(),
            reducer: { HeroesListFeature() }
        )
        
        await MainActor.run {
            store.dependencies.fetchHeroes = { _, _ in throw NSError(domain: "Test", code: 1, userInfo: nil) }
        }

        await store.send(.fetchHeroes) {
            $0.isLoading = true
        }
        await store.receive(.heroesLoadedFailure(.networkError("The operation couldn’t be completed. (Test error 1.)"))) {
            $0.isLoading = false
        }

        await MainActor.run {
            XCTAssertEqual(store.state.heroes.count, 0)
        }
    }
}
