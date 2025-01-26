import XCTest
import SwiftUI
import ComposableArchitecture
@testable import HeroDetail

@MainActor
final class HeroDetailCoordinatorTests: XCTestCase {
    
    func test_heroDetailLoadedSuccessfully() async {

        let testHero = HeroDetail(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man.",
            thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            comics: ["Amazing Spider-Man #1", "Ultimate Spider-Man #1"],
            series: ["Spider-Man (1994-1998)", "The Amazing Spider-Man (1977-1979)"],
            stories: ["The Night Gwen Stacy Died", "Kraven's Last Hunt"],
            events: ["Civil War", "Secret Wars"]
        )

        let mockUseCase = MockFetchHeroDetailUseCase()
        mockUseCase.result = .success(testHero)

        DependencyValues.withValue(\.fetchHeroDetailUseCase, mockUseCase) {
            let coordinator = HeroDetailCoordinator(heroId: 1)

            let store = Store(
                initialState: HeroDetailFeature.State(heroId: 1),
                reducer: {
                    HeroDetailFeature()
                }
            )

            let viewStore = ViewStore(store, observe: { $0 })

            viewStore.send(.fetchHeroDetail)

            XCTAssertEqual(viewStore.hero?.id, testHero.id)
            XCTAssertEqual(viewStore.hero?.name, testHero.name)
        }
    }

    func test_heroDetailLoadError() async {

        let mockUseCase = MockFetchHeroDetailUseCase()
        mockUseCase.result = .failure(NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load hero details."]))

        DependencyValues.withValue(\.fetchHeroDetailUseCase, mockUseCase) {
            let coordinator = HeroDetailCoordinator(heroId: 1)

            let store = Store(
                initialState: HeroDetailFeature.State(heroId: 1),
                reducer: {
                    HeroDetailFeature()
                }
            )

            let viewStore = ViewStore(store, observe: { $0 })

            viewStore.send(.fetchHeroDetail)

            XCTAssertNotNil(viewStore.errorMessage)
            XCTAssertEqual(viewStore.errorMessage, "Failed to load hero details.")
        }
    }
}
