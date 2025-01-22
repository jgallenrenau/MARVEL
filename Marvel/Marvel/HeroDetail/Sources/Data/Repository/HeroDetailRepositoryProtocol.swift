protocol HeroDetailRepositoryProtocol {
    func fetchHeroDetail(characterId: Int) async throws -> HeroDetail
}
