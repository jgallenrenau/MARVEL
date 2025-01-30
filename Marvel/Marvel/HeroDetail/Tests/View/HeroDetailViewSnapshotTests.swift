import XCTest
import SwiftUI
import SnapshotTesting
import ComposableArchitecture
import DesignSystem
@testable import HeroDetail

final class HeroDetailViewSnapshotTests: XCTestCase {
    
    func testHeroDetailViewSnapshot() {
        UIView.setAnimationsEnabled(false)

        let mockHeroDetail = HeroDetail(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!,
            comics: ["Amazing Spider-Man #1", "Ultimate Spider-Man #2"],
            series: ["Marvel's Spider-Man", "Ultimate Comics"],
            stories: ["Spider-Verse", "The Clone Saga"],
            events: ["Civil War", "Secret Wars"]
        )

        let initialState = HeroDetailFeature.State(
            heroId: 1,
            hero: mockHeroDetail, // Hero cargado desde el inicio
            isLoading: false
        )

        let store = Store(
            initialState: initialState,
            reducer: { HeroDetailFeature() }
        )

        let view = HeroDetailView(store: store)
            .frame(width: 375, height: 812)
            .padding(DSPadding.normal)
            .background(DSColors.black.opacity(DSOpacity.dotFour))

        // Permitir que la vista termine de renderizarse antes de la snapshot
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))

        assertSnapshot(
            of: view,
            as: .image(layout: .fixed(width: 375, height: 812)), // Tamaño fijo
            named: "HeroDetailView_Snapshot"
        )
    }

    

//    func testHeroDetailViewLoadingStateSnapshot() {
//        let store = withDependencies {
//            $0.fetchHeroDetailUseCase = FetchHeroDetailUseCaseMock(result: .success(mockHeroDetail))
//        } operation: {
//            Store(
//                initialState: HeroDetailFeature.State(heroId: 1, isLoading: true),
//                reducer: { HeroDetailFeature() }
//            )
//        }
//        
//        withSnapshotTesting(record: false) {
//            for (deviceName, config) in devices {
//                let view = HeroDetailView(store: store)
//                assertSnapshot(
//                    of: view,
//                    as: .image(layout: .device(config: config)),
//                    named: "HeroDetailView_Error_\(deviceName)"
//                )
//            }
//        }
//    }
//    
//    func testHeroDetailViewErrorStateSnapshot() {
//        let store = withDependencies {
//            $0.fetchHeroDetailUseCase = FetchHeroDetailUseCaseMock(result: .failure(HeroDetailFeature.HeroesDetailError.networkError("Failed to load hero details.")))
//        } operation: {
//            Store(
//                initialState: HeroDetailFeature.State(
//                    heroId: 1,
//                    errorMessage: "Failed to load hero details."
//                ),
//                reducer: { HeroDetailFeature() }
//            )
//        }
//        
//        withSnapshotTesting(record: false) {
//            for (deviceName, config) in devices {
//                let view = HeroDetailView(store: store)
//                assertSnapshot(
//                    of: view,
//                    as: .image(layout: .device(config: config)),
//                    named: "HeroDetailView_Error_\(deviceName)"
//                )
//            }
//        }
//    }
    
}
