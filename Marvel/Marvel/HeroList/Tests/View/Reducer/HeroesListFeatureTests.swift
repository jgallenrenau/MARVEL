import XCTest
import ComposableArchitecture
@testable import HeroList

final class HeroesListFeatureTests: XCTestCase {
    func testFetchHeroesSuccess() async {

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
    }

    func testFetchHeroesFailure() async {

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
    }
}
