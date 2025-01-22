protocol HeroDetailAPIProtocol {
    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO
}
