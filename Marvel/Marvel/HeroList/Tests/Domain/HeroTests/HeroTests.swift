import XCTest
@testable import HeroList

final class HeroTests: XCTestCase {
    func testHeroEquatable() {

        let hero1 = Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)
        let hero2 = Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)
        let hero3 = Hero(id: 2, name: "Iron Man", description: "Genius billionaire playboy philanthropist", thumbnailURL: URL(string: "https://example.com/ironman.jpg")!)

        let areEqual = hero1 == hero2
        let areNotEqual = hero1 == hero3

        XCTAssertTrue(areEqual, "Heroes with the same id should be equal.")
        XCTAssertFalse(areNotEqual, "Heroes with different ids should not be equal.")
    }

    func testHeroIdentifiable() {

        let hero = Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)

        XCTAssertEqual(hero.id, 1, "Hero's id should match the assigned value.")
    }
}
