import XCTest
import SwiftUI
import SnapshotTesting
@testable import HeroDetail

final class HeroDetailInfoViewSnapshotTests: XCTestCase {

    private let devices: [String: ViewImageConfig] = [
        "iPhone SE": .iPhoneSe,
        "iPhone 13": .iPhone13,
        "iPhone 13 Pro Max": .iPhone13ProMax,
        "iPad Mini": .iPadMini,
        "iPad Pro 11": .iPadPro11,
        "iPad Pro 12.9": .iPadPro12_9
    ]

    func testHeroDetailInfoViewWithFullData() {
        let view = HeroDetailInfoView(
            name: "Spider-Man",
            description: "Spider-Man is a fictional superhero created by writer-editor Stan Lee and writer-artist Steve Ditko. He first appeared in Amazing Fantasy #15 (August 1962).",
            comics: ["Amazing Spider-Man #1", "Ultimate Spider-Man #1", "Spider-Verse #1", "Web of Spider-Man #1", "Spectacular Spider-Man #1"],
            series: ["Spider-Man (1994-1998)", "The Amazing Spider-Man (1977-1979)", "Spider-Man Unlimited (1999-2005)", "Spider-Man: The Animated Series"],
            stories: ["The Night Gwen Stacy Died", "Kraven's Last Hunt", "The Clone Saga", "Back in Black", "Spider-Island"],
            events: ["Civil War", "Secret Wars", "Infinity War", "Spider-Verse", "The Gauntlet"]
        )
        captureSnapshots(for: view, named: "HeroDetailInfoView_FullData")
    }

    func testHeroDetailInfoViewWithEmptyData() {
        let view = HeroDetailInfoView(
            name: "Spider-Man",
            description: "",
            comics: [],
            series: [],
            stories: [],
            events: []
        )
        captureSnapshots(for: view, named: "HeroDetailInfoView_EmptyData")
    }

    private func captureSnapshots(for view: some View, named: String) {
        
        withSnapshotTesting(record: false) {
            for (deviceName, config) in devices {
                assertSnapshot(
                    of: view,
                    as: .image(layout: .device(config: config)),
                    named: "\(named)_\(deviceName)"
                )
            }
        }
    }
}
