import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import HeroDetail

final class HeroDetailSnapshotTests: XCTestCase {
    
    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]

    func testHeroDetailViewSnapshot() {
        let mockHeroDetail = HeroDetail(
            id: 1,
            name: "Spider-Man",
            description: "Spider-Man is a fictional superhero created by writer-editor Stan Lee and writer-artist Steve Ditko. He first appeared in Amazing Fantasy #15 (August 1962).",
            thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            comics: ["Amazing Spider-Man #1", "Ultimate Spider-Man #1"],
            series: ["Spider-Man (1994-1998)", "The Amazing Spider-Man (1977-1979)"],
            stories: ["The Night Gwen Stacy Died", "Kraven's Last Hunt"],
            events: ["Civil War", "Secret Wars"]
        )
        
        let store = withDependencies {
            $0.fetchHeroDetailUseCase = FetchHeroDetailUseCaseMock(heroDetail: mockHeroDetail)
        } operation: {
            Store(
                initialState: HeroDetailFeature.State(heroId: 1, hero: mockHeroDetail),
                reducer: { HeroDetailFeature() }
            )
        }

        for (deviceName, config) in devices {
            let view = HeroDetailView(store: store)
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroDetailView_\(deviceName)"
            )
        }
    }
    
    func testHeroDetailViewLoadingStateSnapshot() {
        let store = Store(
            initialState: HeroDetailFeature.State(heroId: 1, isLoading: true),
            reducer: { HeroDetailFeature() }
        )

        for (deviceName, config) in devices {
            let view = HeroDetailView(store: store)
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroDetailView_Loading_\(deviceName)"
            )
        }
    }
    
    func testHeroDetailViewErrorStateSnapshot() {
        let store = Store(
            initialState: HeroDetailFeature.State(
                heroId: 1,
                errorMessage: "Failed to load hero details."
            ),
            reducer: { HeroDetailFeature() }
        )

        for (deviceName, config) in devices {
            let view = HeroDetailView(store: store)
            assertSnapshot(
                of: view,
                as: .image(layout: .device(config: config)),
                named: "HeroDetailView_Error_\(deviceName)"
            )
        }
    }
}
