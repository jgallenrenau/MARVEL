import XCTest
import Core
@testable import HeroDetail

final class HeroDetailAPITests: XCTestCase {
    
    func testFetchHeroDetailSuccess() async throws {

        let mockAPIClient = HeroDetailAPIMock()
        let mockThumbnail = ThumbnailDTO(path: "https://example.com/image", extension: "jpg")
        mockAPIClient.mockResponse = HeroDetailResponseDTO(
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

        let response = try await mockAPIClient.fetchHeroDetail(characterId: 1)

        XCTAssertEqual(response.name, "Spider-Man")
    }

    func testFetchHeroDetailFailure() async {
        let mockAPIClient = HeroDetailAPIMock()
        mockAPIClient.shouldThrowError = true
        
        do {
            _ = try await  mockAPIClient.fetchHeroDetail(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchHeroDetailInvalidData() async {
        let mockAPIClient = HeroDetailAPIMock()
        mockAPIClient.mockResponse = nil

        do {
            _ = try await mockAPIClient.fetchHeroDetail(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
