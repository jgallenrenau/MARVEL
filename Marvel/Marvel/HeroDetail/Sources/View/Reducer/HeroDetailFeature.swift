import Foundation
import ComposableArchitecture

struct HeroDetailFeature: Reducer {
    
    struct State: Equatable {
        let heroId: Int
        var hero: HeroDetail?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case fetchHeroDetail
        case heroDetailLoaded(Result<HeroDetail, HeroesDetailError>)
    }

    enum HeroesDetailError: Error, Equatable {
        case networkError(String)
        case decodingError(String)
        case unknown(String)
    }

    @Dependency(\.fetchHeroDetailUseCase) var fetchHeroDetailUseCase

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
            
        case .fetchHeroDetail:

            state.isLoading = true
            let heroId = state.heroId

            return .run { send in
                do {
                    let heroDetail = try await fetchHeroDetailUseCase.execute(characterId: heroId)
                    await send(.heroDetailLoaded(.success(heroDetail)))
                } catch {
                    let mappedError: HeroesDetailError
                    if let decodingError = error as? DecodingError {
                        mappedError = .decodingError(decodingError.localizedDescription)
                    } else {
                        mappedError = .networkError(error.localizedDescription)
                    }
                    await send(.heroDetailLoaded(.failure(mappedError)))
                }
            }

        case let .heroDetailLoaded(.success(hero)):
            state.hero = hero
            state.isLoading = false
            return .none

        case let .heroDetailLoaded(.failure(error)):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
            return .none
        }
    }
}

extension DependencyValues {
    
    var fetchHeroDetailUseCase: FetchHeroDetailUseCaseProtocol {
        get { self[FetchHeroDetailUseCaseKey.self] }
        set { self[FetchHeroDetailUseCaseKey.self] = newValue }
    }

    private enum FetchHeroDetailUseCaseKey: DependencyKey {
        static let liveValue: FetchHeroDetailUseCaseProtocol = FetchHeroDetailUseCase(
            repository: HeroDetailRepository(
                dataSource: RemoteHeroDetailDataSource(
                    api: HeroDetailAPI()
                )
            )
        )
    }
}
