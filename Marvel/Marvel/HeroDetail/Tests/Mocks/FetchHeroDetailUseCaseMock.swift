import Foundation
@testable import HeroDetail

struct FetchHeroDetailUseCaseMock: FetchHeroDetailUseCaseProtocol {
    let heroDetail: HeroDetail

    init(heroDetail: HeroDetail) {
        self.heroDetail = heroDetail
    }

    func execute(characterId: Int) async throws -> HeroDetail {
        return heroDetail
    }
}
