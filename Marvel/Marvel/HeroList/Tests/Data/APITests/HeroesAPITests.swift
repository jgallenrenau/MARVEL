import XCTest
import Foundation
@testable import Core
@testable import HeroList

final class HeroesAPITests: XCTestCase {
    var apiClient: APIClientProtocol!
    var heroesAPI: HeroesAPI!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        heroesAPI = HeroesAPI()
        Constants.API.keysProvider = MockAPIKeysProvider()
    }

    override func tearDown() {
        apiClient = nil
        heroesAPI = nil
        super.tearDown()
    }

// TO DO: Refactor on API
//
//    func testFetchHeroesSuccess() async throws {
//        
//        let mockResponse = HeroResponseDTOContainer(
//            code: 200,
//            status: "OK",
//            data: HeroDataDTO(
//                offset: 0,
//                limit: 20,
//                total: 1,
//                count: 1,
//                results: [
//                    HeroResponseDTO(
//                        id: 1,
//                        name: "Spider-Man",
//                        description: "A hero with spider-like abilities.",
//                        modified: "2023-01-01T00:00:00Z",
//                        thumbnail: ThumbnailDTO(
//                            path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0",
//                            extension: "jpg"
//                        ),
//                        resourceURI: "http://gateway.marvel.com/v1/public/characters/1",
//                        comics: ComicsDTO(
//                            available: 10,
//                            collectionURI: "http://gateway.marvel.com/v1/public/characters/1/comics",
//                            items: [
//                                ComicItemDTO(
//                                    resourceURI: "http://gateway.marvel.com/v1/public/comics/1",
//                                    name: "Amazing Spider-Man"
//                                )
//                            ],
//                            returned: 1
//                        )
//                    )
//                ]
//            )
//        )
//        
//        (apiClient as! MockAPIClient).mockResponseData = try JSONEncoder().encode(mockResponse)
//        
//        let heroes = try await heroesAPI.fetchHeroes(offset: 0, limit: 20)
//        
//        XCTAssertEqual(heroes.count, 1)
//        XCTAssertEqual(heroes.first?.name, "Spider-Man")
//    }
    
//    func testFetchHeroesFailure() async throws {
//        (apiClient as! MockAPIClient).shouldReturnError = true
//
//        do {
//            _ = try await heroesAPI.fetchHeroes(offset: 0, limit: 20)
//            XCTFail("Expected to throw, but did not")
//        } catch {
//            XCTAssertTrue(error is URLError)
//        }
//    }
    
    func testHeroResponseDTOToDomain() {
        let dto = HeroResponseDTO(
            id: 1,
            name: "Spider-Man",
            description: "A hero from New York",
            modified: "2023-01-01T12:00:00Z",
            thumbnail: ThumbnailDTO(
                path: "http://example.com/spiderman",
                extension: "jpg"
            ),
            resourceURI: "https://example.com",
            comics: ComicsDTO(
                available: 10,
                collectionURI: "https://example.com",
                items: [],
                returned: 10
            )
        )

        let hero = dto.toDomain()

        XCTAssertEqual(hero.id, 1)
        XCTAssertEqual(hero.name, "Spider-Man")
        XCTAssertEqual(hero.description, "A hero from New York")
        XCTAssertEqual(hero.thumbnailURL.absoluteString, "https://example.com/spiderman.jpg")
    }
}
