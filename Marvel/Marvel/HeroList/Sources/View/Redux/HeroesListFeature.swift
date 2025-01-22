import Foundation
import ComposableArchitecture
import Core

struct HeroesListFeature: Reducer {
    
    struct Config {
        static let pageSize = 20
        static let thresholdForLoadingMore = 10
    }
    
    struct HeroesListEnvironment {
        let fetchHeroes: (Int, Int) async throws -> [Hero]
    }
    
    struct State: Equatable {
        var heroes: [Hero] = []
        var isLoading: Bool = false
        var offset: Int = 0
        var hasMoreHeroes: Bool = true
    }
    
    enum Action: Equatable {
        case fetchHeroes
        case loadMoreHeroes
        case heroesLoadedSuccess([Hero])
        case heroesLoadedFailure(HeroesListError)
    }
    
    enum HeroesListError: Error, Equatable {
        case networkError(String)
        case decodingError(String)
        case unknown(String)
    }
    
    @Dependency(\.fetchHeroes) var fetchHeroes
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
            
        case .fetchHeroes:
            state.isLoading = true
            
            let offset = state.offset
            
            return .run { send in
                do {
                    let heroes = try await fetchHeroes(offset, Config.pageSize)
                    await send(.heroesLoadedSuccess(heroes))
                } catch {
                    let mappedError: HeroesListError
                    if let decodingError = error as? DecodingError {
                        mappedError = .decodingError(decodingError.localizedDescription)
                    } else {
                        mappedError = .networkError(error.localizedDescription)
                    }
                    await send(.heroesLoadedFailure(mappedError))
                }
            }
            
        case .loadMoreHeroes:
            guard !state.isLoading, state.hasMoreHeroes else { return .none }
            
            state.offset += Config.pageSize
            state.isLoading = true
            
            let offset = state.offset
            
            return .run { send in
                do {
                    let heroes = try await fetchHeroes(offset, Config.pageSize)
                    await send(.heroesLoadedSuccess(heroes))
                } catch {
                    let mappedError: HeroesListError
                    if let decodingError = error as? DecodingError {
                        mappedError = .decodingError(decodingError.localizedDescription)
                    } else if let urlError = error as? URLError {
                        mappedError = .networkError(urlError.localizedDescription)
                    } else {
                        mappedError = .unknown(error.localizedDescription)
                    }
                    await send(.heroesLoadedFailure(mappedError))
                }
            }
            
        case let .heroesLoadedSuccess(heroes):
            if heroes.isEmpty {
                state.hasMoreHeroes = false
            } else {
                state.heroes.append(contentsOf: heroes)
            }
            
            state.isLoading = false
            
            return .none
            
        case .heroesLoadedFailure:
            state.isLoading = false
            
            return .none
        }
    }
}

extension DependencyValues {
    
    var fetchHeroes: (Int, Int) async throws -> [Hero] {
        get { self[FetchHeroesUseCaseKey.self] }
        set { self[FetchHeroesUseCaseKey.self] = newValue }
    }

    private enum FetchHeroesUseCaseKey: DependencyKey {
        
        static let liveValue: (Int, Int) async throws -> [Hero] = { offset, limit in
            let repository = HeroesRepository(remoteDataSource: RemoteHeroesDataSource(api: HeroesAPI()))
            let fetchHeroesUseCase = FetchHeroesUseCase(repository: repository)
            return try await fetchHeroesUseCase.execute(offset: offset, limit: limit)
        }
    }
}
