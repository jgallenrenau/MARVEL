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

//    func testGetHeroesSuccess() async throws {
//        let mockHeroes = [
//            HeroResponseDTO(
//                id: 1,
//                name: "Spider-Man",
//                description: "A hero",
//                modified: "",
//                thumbnail: ThumbnailDTO(path:"http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg"),
//                resourceURI: "",
//                comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
//            )
//        ]
//        apiMock.result = .success(mockHeroes)
//
//        let heroes = try await dataSource.getHeroes(offset: 0, limit: 10)
//
//        XCTAssertEqual(heroes.count, 1)
//        XCTAssertEqual(heroes.first?.name, "Spider-Man")
//    }
//
//    func testGetHeroesFailure() async {
//        apiMock.result = .failure(NetworkError.invalidResponse)
//
//        do {
//            _ = try await dataSource.getHeroes(offset: 0, limit: 10)
//            XCTFail("We want aa  error, but not throm any error.")
//        } catch let error as NetworkError {
//            XCTAssertEqual(error, .invalidResponse)
//        } catch {
//            XCTFail("We want a NetworkError, but throm other error: \(error).")
//        }
//    }
}
