import XCTest
import Core
@testable import HeroDetail

final class HeroDetailAPIMock: HeroDetailAPIProtocol {
    var shouldThrowError = false
    var mockResponse: HeroDetailResponseDTO?

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        guard let response = mockResponse else {
            throw URLError(.cannotParseResponse)
        }
        return response
    }
}
