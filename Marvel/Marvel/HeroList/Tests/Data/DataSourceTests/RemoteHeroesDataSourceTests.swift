import XCTest
@testable import Core
@testable import HeroList

final class RemoteHeroesDataSourceTests: XCTestCase {
    var dataSource: RemoteHeroesDataSource!
    var mockAPI: MockHeroesAPI!

    override func setUp() {
        super.setUp()
        mockAPI = MockHeroesAPI()
        dataSource = RemoteHeroesDataSource(api: mockAPI)
        Constants.API.keysProvider = MockAPIKeysProvider()
    }

    override func tearDown() {
        mockAPI = nil
        dataSource = nil
        super.tearDown()
    }

    func testGetHeroesSuccess() async throws {

        let mockHero = HeroResponseDTO(
            id: 1,
            name: "Spider-Man",
            description: "A hero with spider-like abilities.",
            modified: "2023-01-01T00:00:00Z",
            thumbnail: ThumbnailDTO(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0",
                extension: "jpg"
            ),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1",
            comics: ComicsDTO(
                available: 10,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1/comics",
                items: [
                    ComicItemDTO(
                        resourceURI: "http://gateway.marvel.com/v1/public/comics/1",
                        name: "Amazing Spider-Man"
                    )
                ],
                returned: 1
            )
        )
        mockAPI.mockResponse = [mockHero]

        let heroes = try await dataSource.getHeroes(offset: 0, limit: 20)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
        XCTAssertEqual(heroes.first?.thumbnail.path, "https://i.annihil.us/u/prod/marvel/i/mg/c/e0")
    }

    func testGetHeroesFailure() async throws {

        mockAPI.shouldReturnError = true

        do {
            _ = try await dataSource.getHeroes(offset: 0, limit: 20)
            XCTFail("Expected an error to be thrown, but no error was thrown.")
        } catch {
            XCTAssertNotNil(error, "Expected an error, but got nil.")
        }
    }
}
