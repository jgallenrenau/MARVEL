import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroList

final class HeroesRowSnapshotTests: XCTestCase {
    
    internal var devices: [(name: String, size: CGSize)] {
        [
            ("iPhone SE", CGSize(width: 320, height: 120)),
            ("iPhone 13", CGSize(width: 390, height: 120)),
            ("iPhone 13 Pro Max", CGSize(width: 430, height: 120)),
            ("iPad Mini", CGSize(width: 820, height: 120)),
            ("iPad Pro 11", CGSize(width: 834, height: 120)),
            ("iPad Pro 12.9", CGSize(width: 1024, height: 120))
        ]
    }
    
    func testHeroesRowViewSnapshot() {

        let hero = Hero(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man",
            thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!
        )
        

        runSnapshotTests(for: hero, using: HeroesRowView.init, namedPrefix: "HeroesRow")
    }
    
    func runSnapshotTests<Model, T: View>(
        for model: Model,
        using viewProvider: (Model) -> T,
        namedPrefix: String = ""
    ) {
        for device in devices {
            let view = viewProvider(model)
                .frame(width: device.size.width, height: device.size.height)

            withSnapshotTesting {
                assertSnapshot(
                    of: view,
                    as: .image(layout: .sizeThatFits),
                    named: "\(namedPrefix)_\(String(describing: T.self))_\(device.name)"
                )
            }
        }
    }
}
