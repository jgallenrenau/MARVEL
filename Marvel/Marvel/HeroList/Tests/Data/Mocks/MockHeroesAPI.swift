import Foundation
@testable import HeroList

final class MockHeroesAPI: HeroesAPIProtocol {
    var shouldReturnError = false
    var mockResponse: [HeroResponseDTO] = []

    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return mockResponse
    }
}
