import XCTest
@testable import Core
@testable import HeroList

final class RemoteHeroesDataSourceTests: XCTestCase {
    
    var dataSource: RemoteHeroesDataSource!
    var apiMock: HeroesAPIMock!

    override func setUp() {
        super.setUp()
        apiMock = HeroesAPIMock()
        dataSource = RemoteHeroesDataSource(api: apiMock)
    }

    override func tearDown() {
        dataSource = nil
        apiMock = nil
        super.tearDown()
    }

    func testGetHeroesSuccess() async throws {
        let mockHeroes = [
            HeroResponseDTO(
                id: 1,
                name: "Spider-Man",
                description: "A hero",
                modified: "",
                thumbnail: ThumbnailDTO(path: "https://example.com/image", extension: "jpg"),
                resourceURI: "",
                comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
            )
        ]
        apiMock.result = .success(mockHeroes)

        let heroes = try await dataSource.getHeroes(offset: 0, limit: 10)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
    }

    func testGetHeroesFailure() async {
        apiMock.result = .failure(NetworkError.invalidResponse)

        do {
            _ = try await dataSource.getHeroes(offset: 0, limit: 10)
            XCTFail("Se esperaba un error, pero no se lanzó ninguno.")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Se esperaba un NetworkError, pero se lanzó otro error: \(error).")
        }
    }
}
