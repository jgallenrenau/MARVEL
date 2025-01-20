import XCTest
@testable import HeroList

final class FetchHeroesUseCaseIntegrationTests: XCTestCase {
    func testFetchHeroesSuccess() async throws {

        let mockHeroes = [
            Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man", thumbnailURL: URL(string: "https://example.com/spiderman.jpg")!)
        ]
        
        let mockRemoteDataSource = MockRemoteHeroesDataSource()
        mockRemoteDataSource.mockHeroes = mockHeroes.map { hero in
            HeroResponseDTO(
                id: hero.id,
                name: hero.name,
                description: hero.description,
                modified: "",
                thumbnail: ThumbnailDTO(path: "https://example.com/spiderman", extension: "jpg"),
                resourceURI: "",
                comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
            )
        }
        
        let repository = HeroesRepository(remoteDataSource: mockRemoteDataSource)
        
        let useCase = FetchHeroesUseCase(repository: repository)
        
        let heroes = try await useCase.execute(offset: 0, limit: 20)
        
        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
    }

    func testFetchHeroesFailure() async throws {

        let mockRemoteDataSource = MockRemoteHeroesDataSource()
        mockRemoteDataSource.shouldReturnError = true
        
        let repository = HeroesRepository(remoteDataSource: mockRemoteDataSource)
        let useCase = FetchHeroesUseCase(repository: repository)
        
        do {
            _ = try await useCase.execute(offset: 0, limit: 20)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
