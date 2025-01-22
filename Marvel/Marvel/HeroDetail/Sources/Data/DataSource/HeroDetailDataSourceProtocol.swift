protocol HeroDetailDataSourceProtocol {
    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO
}
