import XCTest
import Core
@testable import HeroDetail

final class HeroDetailDataSourceTests: XCTestCase {
    
    func testFetchHeroDetailSuccess() async throws {
        let mockAPI = HeroDetailAPIMock()
        let dataSource = RemoteHeroDetailDataSource(api: mockAPI)
        let mockThumbnail = ThumbnailDTO(path: "https://example.com/image", extension: "jpg")
        mockAPI.mockResponse = HeroDetailResponseDTO(
            id: 1,
            name: "Spider-Man",
            description: "A friendly neighborhood superhero.",
            modified: "",
            thumbnail: mockThumbnail,
            resourceURI: "",
            comics: ComicsDTO(available: 0, collectionURI: "", items: [], returned: 0),
            series: SeriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            stories: StoriesDTO(available: 0, collectionURI: "", items: [], returned: 0),
            events: EventsDTO(available: 0, collectionURI: "", items: [], returned: 0)
        )

        let response = try await dataSource.fetchHeroDetail(characterId: 1)

        XCTAssertEqual(response.name, "Spider-Man")
    }

    func testFetchHeroDetailFailure() async {
        let mockAPI = HeroDetailAPIMock()
        let dataSource = RemoteHeroDetailDataSource(api: mockAPI)
        mockAPI.shouldThrowError = true

        
        do {
            _ = try await  dataSource.fetchHeroDetail(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
