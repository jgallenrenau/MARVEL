import Foundation

final class RemoteHeroDetailDataSource: HeroDetailDataSourceProtocol {
    private let api: HeroDetailAPIProtocol

    init(api: HeroDetailAPIProtocol) {
        self.api = api
    }

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO {
        return try await api.fetchHeroDetail(characterId: characterId)
    }
}
