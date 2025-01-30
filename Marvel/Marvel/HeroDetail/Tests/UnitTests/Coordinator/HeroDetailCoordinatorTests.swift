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

        let store = withDependencies {
            $0.fetchHeroDetailUseCase = mockUseCase
        } operation: {
            Store(
                initialState: HeroDetailFeature.State(heroId: 1),
                reducer: { HeroDetailFeature() }
            )
        }

        let viewStore = ViewStore(store, observe: { $0 })

        await viewStore.send(.fetchHeroDetail).finish()

        XCTAssertEqual(viewStore.hero?.id, testHero.id)
        XCTAssertEqual(viewStore.hero?.name, testHero.name)
    }

    @MainActor
    func test_heroDetailLoadError() async {

        let mockUseCase = MockFetchHeroDetailUseCase()
        mockUseCase.result = .failure(NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load hero details."]))

        let store = withDependencies {
            $0.fetchHeroDetailUseCase = mockUseCase
        } operation: {
            Store(
                initialState: HeroDetailFeature.State(heroId: 1),
                reducer: { HeroDetailFeature() }
            )
        }

        let viewStore = ViewStore(store, observe: { $0 })

        await viewStore.send(.fetchHeroDetail).finish()

        XCTAssertNotNil(viewStore.errorMessage, "El errorMessage no debería ser nil después de un fallo en la carga")
    }
}
