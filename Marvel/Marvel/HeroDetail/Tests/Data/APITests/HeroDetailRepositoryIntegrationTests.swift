import XCTest
@testable import HeroDetail

final class HeroDetailRepositoryIntegrationTests: XCTestCase {
    func testFetchHeroDetailFromRepository() async throws {
        let mockAPI = MockHeroDetailAPI()
        mockAPI.mockResponse = HeroDetailResponseDTO(
            id: 1011334,
            name: "3-D Man",
            description: "",
            modified: "2014-04-29T14:18:17-0400",
            thumbnail: ThumbnailDTO(path: "http://image", extension: "jpg"),
            resourceURI: "",
            comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0),
            series: SeriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            stories: StoriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            events: EventsDTO(available: 0, collectionURI: "", items: [], returned: 0)
        )

        let dataSource = RemoteHeroDetailDataSource(api: mockAPI)
        let repository = HeroDetailRepository(dataSource: dataSource)

        let heroDetail = try await repository.fetchHeroDetail(characterId: 1011334)

        XCTAssertEqual(heroDetail.id, 1011334)
        XCTAssertEqual(heroDetail.name, "3-D Man")
    }
}
