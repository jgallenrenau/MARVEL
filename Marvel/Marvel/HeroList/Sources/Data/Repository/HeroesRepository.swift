import Foundation

final class HeroesRepository: HeroesRepositoryProtocol {
    private let remoteDataSource: RemoteHeroesDataSourceProtocol

    init(remoteDataSource: RemoteHeroesDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero] {
        let dtoList = try await remoteDataSource.getHeroes(offset: offset, limit: limit)
        return dtoList.map { $0.toDomain() }
    }
}
