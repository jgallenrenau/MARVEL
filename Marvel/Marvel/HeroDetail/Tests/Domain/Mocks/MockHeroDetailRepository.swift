import Foundation
@testable import HeroDetail

final class MockHeroDetailRepository: HeroDetailRepositoryProtocol {
    var mockHeroDetail: HeroDetail?

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetail {
        if let heroDetail = mockHeroDetail {
            return heroDetail
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
