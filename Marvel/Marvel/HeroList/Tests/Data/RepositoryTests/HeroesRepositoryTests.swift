import XCTest
@testable import Core
@testable import HeroList

final class HeroesRepositoryTests: XCTestCase {
    var repository: HeroesRepository!
    var mockDataSource: MockRemoteHeroesDataSource!

    override func setUp() {
        super.setUp()
        mockDataSource = MockRemoteHeroesDataSource()
        repository = HeroesRepository(remoteDataSource: mockDataSource)
        Constants.API.keysProvider = MockAPIKeysProvider()
    }

    override func tearDown() {
        repository = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testFetchHeroesSuccess() async throws {

        let mockHero = HeroResponseDTO(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man",
            modified: "2025-01-19T10:00:00Z",
            thumbnail: ThumbnailDTO(path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg"),
            resourceURI: "https://gateway.marvel.com/v1/public/characters/1",
            comics: ComicsDTO(
                available: 1,
                collectionURI: "https://gateway.marvel.com/v1/public/characters/1/comics",
                items: [ComicItemDTO(resourceURI: "https://gateway.marvel.com/v1/public/comics/1", name: "Amazing Spider-Man")],
                returned: 1
            )
        )
        mockDataSource.mockHeroes = [mockHero]

        let heroes = try await repository.fetchHeroes(offset: 0, limit: 20)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
        XCTAssertEqual(heroes.first?.description, "Friendly neighborhood Spider-Man")
        XCTAssertEqual(heroes.first?.thumbnailURL.absoluteString, "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }

    func testFetchHeroesFailure() async throws {
        mockDataSource.shouldReturnError = true

        do {
            _ = try await repository.fetchHeroes(offset: 0, limit: 20)
            XCTFail("Expected an error to be thrown, but no error was thrown.")
        } catch {
            XCTAssertNotNil(error, "Expected an error, but got nil.")
        }
    }
}

