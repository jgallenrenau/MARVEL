protocol FetchHeroDetailUseCaseProtocol {
    func execute(characterId: Int) async throws -> HeroDetail
}
