import XCTest
@testable import Core
@testable import HeroDetail

final class HeroDetailAPIUnitTests: XCTestCase {
    
    func testFetchHeroDetailSuccess() async throws {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.response = HeroDetailResponseDTOContainer(
            code: 200,
            status: "Ok",
            data: HeroDetailDataDTO(
                total: 1,
                count: 1,
                results: [
                    HeroDetailResponseDTO(
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
                ]
            )
        )

        let api = HeroDetailAPI(apiClient: mockAPIClient)
        let response = try await api.fetchHeroDetail(characterId: 1011334)
        XCTAssertEqual(response.id, 1011334)
        XCTAssertEqual(response.name, "3-D Man")
    }

    func testFetchHeroDetailFailure() async throws {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.error = URLError(.badServerResponse)

        let api = HeroDetailAPI(apiClient: mockAPIClient)

        do {
            _ = try await api.fetchHeroDetail(characterId: 1011334)
            XCTFail("Expected an error to be thrown")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
