import XCTest
@testable import Core
@testable import HeroList

final class FetchHeroesUseCaseTests: XCTestCase {
    var useCase: FetchHeroesUseCase!
    var mockRepository: MockHeroesRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockHeroesRepository()
        useCase = FetchHeroesUseCase(repository: mockRepository)
        Constants.API.keysProvider = MockAPIKeysProvider()
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchHeroesSuccess() async throws {
        let mockHero = Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)
        mockRepository.mockHeroes = [mockHero]

        let heroes = try await useCase.execute(offset: 0, limit: 20)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
        XCTAssertEqual(heroes.first?.description, "Friendly neighborhood Spider-Man")
    }

    func testFetchHeroesFailure() async throws {

        mockRepository.shouldReturnError = true

        do {
            _ = try await useCase.execute(offset: 0, limit: 20)
            XCTFail("Expected an error to be thrown, but no error was thrown.")
        } catch {

            XCTAssertNotNil(error, "Expected an error, but got nil.")
        }
    }
}
