import XCTest
import ComposableArchitecture
import Core
@testable import HeroDetail

final class HeroDetailReducerTests: XCTestCase {
    
    

    func test_fetchHeroDetail_success() async {
        
        let mockHeroDetail = HeroDetail(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            thumbnailURL: URL(string: "https://example.com/image.jpg")!,
            comics: ["Comic 1"],
            series: ["Series 1"],
            stories: ["Story 1"],
            events: ["Event 1"])

        let store = await TestStore(
            initialState: HeroDetailFeature.State(heroId: 1),
            reducer: { HeroDetailFeature() }
        )

        await MainActor.run {
            let mockUseCase = FetchHeroDetailUseCaseMock(result: .success(mockHeroDetail))
            store.dependencies.fetchHeroDetailUseCase = mockUseCase
        }
        
        await store.send(HeroDetailFeature.Action.fetchHeroDetail) {
            $0.isLoading = true
        }
        
        await store.receive(HeroDetailFeature.Action.heroDetailLoaded(.success(mockHeroDetail))) {
            $0.isLoading = false
            $0.hero = mockHeroDetail
        }
    }
}
