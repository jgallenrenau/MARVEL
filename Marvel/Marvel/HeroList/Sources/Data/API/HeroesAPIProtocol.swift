protocol HeroesAPIProtocol {
    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO]
}
