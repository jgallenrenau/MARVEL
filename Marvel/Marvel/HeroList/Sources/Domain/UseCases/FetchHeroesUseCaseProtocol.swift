protocol FetchHeroesUseCaseProtocol {
    func execute(offset: Int, limit: Int) async throws -> [Hero]
}
