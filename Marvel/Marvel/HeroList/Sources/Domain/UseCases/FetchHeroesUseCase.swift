import Foundation

final class FetchHeroesUseCase: FetchHeroesUseCaseProtocol {
    private let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(offset: Int, limit: Int) async throws -> [Hero] {
        return try await repository.fetchHeroes(offset: offset, limit: limit)
    }
}
