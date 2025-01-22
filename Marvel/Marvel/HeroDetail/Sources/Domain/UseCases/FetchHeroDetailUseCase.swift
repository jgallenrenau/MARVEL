import Foundation

final class FetchHeroDetailUseCase: FetchHeroDetailUseCaseProtocol {
    private let repository: HeroDetailRepositoryProtocol

    init(repository: HeroDetailRepositoryProtocol) {
        self.repository = repository
    }

    func execute(characterId: Int) async throws -> HeroDetail {
        return try await repository.fetchHeroDetail(characterId: characterId)
    }
}
