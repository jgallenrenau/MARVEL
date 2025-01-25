import Foundation
@testable import HeroList

final class RemoteHeroesDataSourceMock: RemoteHeroesDataSourceProtocol {
    var result: Result<[HeroResponseDTO], Error>!

    func getHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        switch result {
        case .success(let heroes):
            return heroes
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set in mock")
        }
    }
}
