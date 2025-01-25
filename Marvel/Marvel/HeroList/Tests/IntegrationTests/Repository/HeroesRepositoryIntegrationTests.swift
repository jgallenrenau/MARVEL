import XCTest
@testable import Core
@testable import HeroList

final class HeroesRepositoryIntegrationTests: XCTestCase {
    var repository: HeroesRepository!
    var remoteDataSourceMock: RemoteHeroesDataSourceMock!

    override func setUp() {
        super.setUp()

        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)

        remoteDataSourceMock = RemoteHeroesDataSourceMock()
        repository = HeroesRepository(remoteDataSource: remoteDataSourceMock)
    }

    override func tearDown() {
        Constants.setKeychainHelper(KeychainHelper())

        repository = nil
        remoteDataSourceMock = nil
        super.tearDown()
    }

    func testFetchHeroesSuccess() async throws {
        let mockHeroes = [
            HeroResponseDTO(
                id: 1,
                name: "Spider-Man",
                description: "Hero",
                modified: "",
                thumbnail: ThumbnailDTO(path: "", extension: ""),
                resourceURI: "",
                comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
            )
        ]
        remoteDataSourceMock.result = .success(mockHeroes)

        let heroes = try await repository.fetchHeroes(offset: 0, limit: 10)
        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
    }

    func testFetchHeroesFailure() async {
        remoteDataSourceMock.result = .failure(NetworkError.invalidResponse)

        do {
            _ = try await repository.fetchHeroes(offset: 0, limit: 10)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

