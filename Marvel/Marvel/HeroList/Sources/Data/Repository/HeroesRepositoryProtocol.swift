protocol HeroesRepositoryProtocol {
    func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero]
}
