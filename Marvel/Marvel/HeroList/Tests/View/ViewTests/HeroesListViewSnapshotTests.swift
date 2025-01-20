import XCTest
import ComposableArchitecture
import SnapshotTesting
@testable import Core
@testable import HeroList
final class HeroesListViewSnapshotTests: XCTestCase {

// TO DO: Refactor on Reduce
//
//    override func setUp() {
//        super.setUp()
//        
//        // Configura el keysProvider con valores mock
//        Constants.API.keysProvider = MockAPIKeysProvider(
//            publicKey: "mockPublicKey",
//            privateKey: "mockPrivateKey"
//        )
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//        
//        // Limpia el keysProvider después de cada prueba
//        Constants.API.keysProvider = nil
//    }
//    
//    func testHeroesListViewSnapshot() {
//        let store = Store(
//            initialState: HeroesListFeature.State(
//                heroes: [
//                    Hero(
//                        id: 1,
//                        name: "Spider-Man",
//                        description: "Friendly neighborhood Spider-Man",
//                        thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg")!
//                    ),
//                    Hero(
//                        id: 2,
//                        name: "Iron Man",
//                        description: "Genius billionaire playboy philanthropist",
//                        thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg")!
//                    )
//                ],
//                isLoading: false
//            ),
//            reducer: {
//                HeroesListFeature()
//            }
//        )
//        let view = HeroesListView(store: store, onHeroSelected: { _ in })
//        
//        assertSnapshot(of: view, as: .image(layout: .sizeThatFits))
//    }
}
