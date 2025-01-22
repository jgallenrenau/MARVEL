protocol RemoteHeroesDataSourceProtocol {
    func getHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO]
}
