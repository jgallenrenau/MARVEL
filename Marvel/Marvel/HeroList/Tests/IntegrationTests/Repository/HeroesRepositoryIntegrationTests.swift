import XCTest
import ComposableArchitecture
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

