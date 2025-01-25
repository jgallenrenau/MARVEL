import Foundation
@testable import HeroList

struct FetchHeroesMock {
    var result: Result<[Hero], HeroesListFeature.HeroesListError>
    
    func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero] {
        switch result {
        case .success(let heroes):
            return heroes
        case .failure(let error):
            throw error
        }
    }
}
