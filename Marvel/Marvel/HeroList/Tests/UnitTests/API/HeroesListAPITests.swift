import XCTest
@testable import Core
@testable import HeroList

@MainActor
final class HeroesListAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)
    }

    override func tearDown() {
        Constants.setKeychainHelper(KeychainHelper())
        super.tearDown()
    }

    func test_fetchHeroesSuccess() async throws {
        let mockHeroes = [
            HeroResponseDTO(
                id: 1011334,
                name: "3-D Man",
                description: "Hero",
                modified: "2023-01-01T00:00:00Z",
                thumbnail: ThumbnailDTO(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg"),
                resourceURI: "",
                comics: ComicsDTO(available: 12, collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/comics", items: [], returned: 0)
            )
        ]
        
        let mockResponse = HeroResponseDTOContainer(
            code: 200,
            status: "OK",
            data: HeroDataDTO(
                offset: 0,
                limit: 1,
                total: 1,
                count: 1,
                results: mockHeroes
            )
        )
        
        let apiClientMock = APIClientMock()
        let mockData = try! JSONEncoder().encode(mockResponse)
        apiClientMock.result = .success(mockData)
        
        let heroesAPI = HeroesAPI(apiClient: apiClientMock)

        let heroes = try await heroesAPI.fetchHeroes(offset: 0, limit: 1)

        XCTAssertEqual(heroes.count, mockHeroes.count, "The number of heroes should match.")
        
        for (hero, mockHero) in zip(heroes, mockHeroes) {
            XCTAssertEqual(hero.id, mockHero.id, "Hero IDs should match.")
            XCTAssertEqual(hero.name, mockHero.name, "Hero names should match.")
            XCTAssertEqual(hero.thumbnail.path, mockHero.thumbnail.path, "Hero thumbnail paths should match.")
            XCTAssertEqual(hero.thumbnail.extension, mockHero.thumbnail.extension, "Hero thumbnail extensions should match.")
            XCTAssertEqual(hero.comics.available, mockHero.comics.available, "Hero comics availability should match.")
            XCTAssertEqual(hero.comics.collectionURI, mockHero.comics.collectionURI, "Hero comics collection URIs should match.")
        }
    }

    func test_fetchHeroesDecodingFailure() async {
        let invalidData = Data("invalid json".utf8)
        let apiClientMock = APIClientMock()
        
        apiClientMock.result = .success(invalidData)
        
        let heroesAPI = HeroesAPI(apiClient: apiClientMock)

        do {
            _ = try await heroesAPI.fetchHeroes(offset: 0, limit: 1)
            XCTFail("The API call should have thrown a decoding error.")
        } catch {
            XCTAssertTrue(error is DecodingError, "The error should be of type DecodingError.")
        }
    }
}

