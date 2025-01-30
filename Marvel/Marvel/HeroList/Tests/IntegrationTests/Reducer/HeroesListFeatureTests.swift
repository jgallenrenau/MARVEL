import XCTest
import ComposableArchitecture
@testable import HeroList

@MainActor
final class HeroesListFeatureTests: XCTestCase {
    
    func test_fetchHeroesSuccess() async {
        let testHeroes = [
            Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!),
            Hero(id: 2, name: "Iron Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
        ]
        
        let fetchHeroesMock: (Int, Int) async throws -> [Hero] = { _, _ in
            return testHeroes
        }

        let store = TestStore(
            initialState: HeroesListFeature.State(),
            reducer: { HeroesListFeature() }
        ) {
            $0.fetchHeroes = fetchHeroesMock
        }

        await store.send(.fetchHeroes) {
            $0.isLoading = true
        }

        await store.receive(.heroesLoadedSuccess(testHeroes)) {
            $0.isLoading = false
            $0.heroes = testHeroes
            $0.filteredHeroes = testHeroes
        }
    }
    
    func test_loadMoreHeroesSuccess() async {
        let initialHeroes = [
            Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
        ]
        let newHeroes = [
            Hero(id: 2, name: "Iron Man", description: "Hero", thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
        ]
        
        let fetchHeroesMock: (Int, Int) async throws -> [Hero] = { offset, _ in
            XCTAssertEqual(offset, 20, "Offset should be incremented correctly")
            return newHeroes
        }

        let store = TestStore(
            initialState: HeroesListFeature.State(heroes: initialHeroes, offset: 0, hasMoreHeroes: true),
            reducer: { HeroesListFeature() }
        ) {
            $0.fetchHeroes = fetchHeroesMock
        }

        await store.send(.loadMoreHeroes) {
            $0.offset = 20
            $0.isLoading = true
        }

        await store.receive(.heroesLoadedSuccess(newHeroes)) {
            $0.isLoading = false
            $0.heroes = initialHeroes + newHeroes
            $0.filteredHeroes = initialHeroes + newHeroes
        }
    }

    func test_loadMoreHeroesNoMoreData() async {
        let initialHeroes = [
            Hero(id: 1, name: "Spider-Man", description: "Hero", thumbnailURL: URL(string: "https://example.com")!)
        ]
        
        let fetchHeroesMock: (Int, Int) async throws -> [Hero] = { offset, _ in
            XCTAssertEqual(offset, 20, "Offset should be incremented correctly")
            return []
        }

        let store = TestStore(
            initialState: HeroesListFeature.State(heroes: initialHeroes, offset: 0, hasMoreHeroes: true),
            reducer: { HeroesListFeature() }
        ) {
            $0.fetchHeroes = fetchHeroesMock
        }

        await store.send(.loadMoreHeroes) {
            $0.offset = 20
            $0.isLoading = true
        }

        await store.receive(.heroesLoadedSuccess([])) {
            $0.isLoading = false
            $0.hasMoreHeroes = false
            $0.filteredHeroes = initialHeroes
        }
    }
}

