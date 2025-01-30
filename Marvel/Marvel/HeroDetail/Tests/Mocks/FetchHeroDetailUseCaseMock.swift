import Foundation
@testable import HeroDetail

final class FetchHeroDetailUseCaseMock: FetchHeroDetailUseCaseProtocol {
    var result: Result<HeroDetail, HeroDetailFeature.HeroesDetailError>

    init(result: Result<HeroDetail, HeroDetailFeature.HeroesDetailError>) {
        self.result = result
    }

    func execute(characterId: Int) async throws -> HeroDetail {
        switch result {
        case .success(let hero): return hero
        case .failure(let error): throw error
        }
    }
}
