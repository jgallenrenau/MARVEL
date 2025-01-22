import Foundation

final class HeroDetailRepository: HeroDetailRepositoryProtocol {
    private let dataSource: HeroDetailDataSourceProtocol

    init(dataSource: HeroDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetail {
        let responseDTO = try await dataSource.fetchHeroDetail(characterId: characterId)
        return responseDTO.toDomain()
    }
}
