import Foundation
@testable import HeroList

final class MockRemoteHeroesDataSource: RemoteHeroesDataSourceProtocol {
    var mockHeroes: [HeroResponseDTO] = []
    var shouldReturnError: Bool = false

    func getHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        return mockHeroes
    }
}
