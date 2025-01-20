import Foundation
@testable import HeroList

final class MockHeroesContainerAPI: HeroesAPIProtocol {
    var shouldReturnError = false
    var mockResponse: HeroResponseDTOContainer?

    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        guard let mockResponse = mockResponse else {
            return []
        }
        return mockResponse.data.results
    }
}
