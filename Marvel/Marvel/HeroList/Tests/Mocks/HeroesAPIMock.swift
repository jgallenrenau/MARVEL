import Foundation
@testable import HeroList

final class HeroesAPIMock: HeroesAPIProtocol {
    var result: Result<[HeroResponseDTO], Error>!

    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
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
