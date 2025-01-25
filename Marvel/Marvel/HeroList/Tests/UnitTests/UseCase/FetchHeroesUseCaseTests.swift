import XCTest
@testable import Core
@testable import HeroList

final class FetchHeroesUseCaseTests: XCTestCase {
    var useCase: FetchHeroesUseCase!
    var repositoryMock: HeroesRepositoryMock!

    override func setUp() {
        super.setUp()

        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)

        repositoryMock = HeroesRepositoryMock()
        useCase = FetchHeroesUseCase(repository: repositoryMock)
    }

    override func tearDown() {
        Constants.setKeychainHelper(KeychainHelper())

        useCase = nil
        repositoryMock = nil
        super.tearDown()
    }

    func testExecuteSuccess() async throws {
        repositoryMock.result = .success([
            Hero(
                id: 1,
                name: "Spider-Man",
                description: "",
                thumbnailURL: URL(string: "https://example.com")!
            )
        ])

        let heroes = try await useCase.execute(offset: 0, limit: 10)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
    }

    func testExecuteFailure() async {
        repositoryMock.result = .failure(NetworkError.invalidResponse)

        do {
            _ = try await useCase.execute(offset: 0, limit: 10)
            XCTFail("Se esperaba un error, pero no se lanzó ninguno.")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Se esperaba un NetworkError, pero se lanzó otro error: \(error).")
        }
    }
}
