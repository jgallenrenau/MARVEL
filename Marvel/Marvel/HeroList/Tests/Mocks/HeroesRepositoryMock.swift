import Foundation
@testable import HeroList

final class HeroesRepositoryMock: HeroesRepositoryProtocol {
    var result: Result<[Hero], Error>!

    func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero] {
        switch result {
        case .success(let heroes):
            return heroes
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result no configurado en el mock")
        }
    }
}
