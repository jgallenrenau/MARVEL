import XCTest
@testable import HeroList

final class HeroesRepositoryIntegrationTests: XCTestCase {
    
    func testFetchHeroesSuccess() async throws {

        let mockResponse = HeroResponseDTOContainer(
            code: 200,
            status: "Ok",
            data: HeroDataDTO(
                offset: 0,
                limit: 20,
                total: 1,
                count: 1,
                results: [
                    HeroResponseDTO(
                        id: 1,
                        name: "Spider-Man",
                        description: "Friendly neighborhood Spider-Man",
                        modified: "",
                        thumbnail: ThumbnailDTO(path: "https://example.com/spiderman", extension: "jpg"),
                        resourceURI: "",
                        comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0)
                    )
                ]
            )
        )

        let mockAPI = MockHeroesContainerAPI()
        mockAPI.mockResponse = mockResponse

        let remoteDataSource = RemoteHeroesDataSource(api: mockAPI)
        let repository = HeroesRepository(remoteDataSource: remoteDataSource)

        let heroes = try await repository.fetchHeroes(offset: 0, limit: 20)

        XCTAssertEqual(heroes.count, 1)
        XCTAssertEqual(heroes.first?.name, "Spider-Man")
        XCTAssertEqual(heroes.first?.thumbnailURL.absoluteString, "https://example.com/spiderman.jpg")
    }

    func testFetchHeroesFailure() async throws {

        let mockAPI = MockHeroesAPI()
        mockAPI.shouldReturnError = true
        
        let remoteDataSource = RemoteHeroesDataSource(api: mockAPI)
        let repository = HeroesRepository(remoteDataSource: remoteDataSource)
        
        do {
            _ = try await repository.fetchHeroes(offset: 0, limit: 20)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
