import Foundation

final class RemoteHeroesDataSource: RemoteHeroesDataSourceProtocol {
    private let api: HeroesAPIProtocol

    init(api: HeroesAPIProtocol) {
        self.api = api
    }

    func getHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        return try await api.fetchHeroes(offset: offset, limit: limit)
    }
}
