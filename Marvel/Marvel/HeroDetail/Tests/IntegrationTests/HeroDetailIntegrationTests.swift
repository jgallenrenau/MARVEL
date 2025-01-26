import XCTest
import Core
@testable import HeroDetail

final class HeroDetailIntegrationTests: XCTestCase {
    
    func testIntegrationSuccess() async throws {

        let mockAPI = HeroDetailAPIMock()
        let dataSource = RemoteHeroDetailDataSource(api: mockAPI)
        let repository = HeroDetailRepository(dataSource: dataSource)
        let useCase = FetchHeroDetailUseCase(repository: repository)
        let mockHeroDetail = HeroDetail(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            thumbnailURL: URL(string: "https://example.com/image.jpg")!,
            comics: ["Comic 1"],
            series: ["Series 1"],
            stories: ["Story 1"],
            events: ["Event 1"]
        )
        mockAPI.mockResponse = HeroDetailResponseDTO(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            modified: "",
            thumbnail: ThumbnailDTO(path: "https://example.com/image", extension: "jpg"),
            resourceURI: "",
            comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0),
            series: SeriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            stories: StoriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            events: EventsDTO(available: 0, collectionURI: "", items: [], returned: 0)
        )

        let heroDetail = try await useCase.execute(characterId: 1)

        XCTAssertEqual(heroDetail.name, "Spider-Man")
    }

    func testIntegrationFailure() async {
        let mockAPI = HeroDetailAPIMock()
        mockAPI.shouldThrowError = true
        let dataSource = RemoteHeroDetailDataSource(api: mockAPI)
        let repository = HeroDetailRepository(dataSource: dataSource)
        let useCase = FetchHeroDetailUseCase(repository: repository)
        
        do {
            _ = try await useCase.execute(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
