struct HeroesListEnvironment {
    let fetchHeroes: (Int, Int) async throws -> [Hero]
}
