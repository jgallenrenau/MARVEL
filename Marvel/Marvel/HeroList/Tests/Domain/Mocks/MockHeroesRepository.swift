import Foundation
@testable import HeroList

final class MockHeroesRepository: HeroesRepositoryProtocol {
    var mockHeroes: [Hero] = []
    var shouldReturnError: Bool = false

    func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero] {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        return mockHeroes
    }
}
