import XCTest
@testable import HeroDetail

final class FetchHeroDetailUseCaseUnitTests: XCTestCase {
    func testExecuteFetchHeroDetail() async throws {
        let mockRepository = MockHeroDetailRepository()
        mockRepository.mockHeroDetail = HeroDetail(
            id: 1011334,
            name: "3-D Man",
            description: "",
            thumbnailURL: URL(string: "http://image.jpg")!,
            comics: [],
            series: [],
            stories: [],
            events: []
        )

        let useCase = FetchHeroDetailUseCase(repository: mockRepository)
        let heroDetail = try await useCase.execute(characterId: 1011334)

        XCTAssertEqual(heroDetail.id, 1011334)
        XCTAssertEqual(heroDetail.name, "3-D Man")
    }
}
