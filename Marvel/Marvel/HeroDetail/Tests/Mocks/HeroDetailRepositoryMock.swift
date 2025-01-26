import XCTest
import Core
@testable import HeroDetail

final class HeroDetailRepositoryMock: HeroDetailDataSourceProtocol {
    var shouldThrowError = false
    var mockResponse: HeroDetailResponseDTO!

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockResponse
    }
}
