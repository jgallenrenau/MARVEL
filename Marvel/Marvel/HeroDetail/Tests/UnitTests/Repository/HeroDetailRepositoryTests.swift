import XCTest
import Core
@testable import HeroDetail

final class HeroDetailRepositoryTests: XCTestCase {
    func testFetchHeroDetailSuccess() async throws {
        let mockDataSource = HeroDetailDataSourceMock()
        let repository = HeroDetailRepository(dataSource: mockDataSource)

        mockDataSource.mockResponse = HeroDetailResponseDTO(
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

        let heroDetail = try await repository.fetchHeroDetail(characterId: 1)

        XCTAssertEqual(heroDetail.name, "Spider-Man")
    }

    func testFetchHeroDetailFailure() async throws {
        let mockDataSource = HeroDetailDataSourceMock()
        let repository = HeroDetailRepository(dataSource: mockDataSource)
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.fetchHeroDetail(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchHeroDetailInvalidData() async throws {
        let mockDataSource = HeroDetailDataSourceMock()
        let repository = HeroDetailRepository(dataSource: mockDataSource)
        mockDataSource.mockResponse = nil // No hay datos válidos

        do {
            _ = try await repository.fetchHeroDetail(characterId: 1)
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
