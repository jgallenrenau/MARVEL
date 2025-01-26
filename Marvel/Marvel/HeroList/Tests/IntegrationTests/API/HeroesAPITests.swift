import XCTest
@testable import Core
@testable import HeroList

@MainActor
final class HeroesAPIIntegrationTests: XCTestCase {

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
                id: 1,
                name: "Spider-Man",
                description: "Hero",
                modified: "2023-01-01T00:00:00Z",
                thumbnail: ThumbnailDTO(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg"),
                resourceURI: "",
                comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
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
        
        let api = HeroesAPI(apiClient: apiClientMock)

        let heroes = try await api.fetchHeroes(offset: 0, limit: 1)

        XCTAssertEqual(heroes.count, 1, "The number of heroes should match.")
        XCTAssertEqual(heroes.first?.id, mockHeroes.first?.id, "The hero ID should match.")
    }
}
