import XCTest
@testable import HeroDetail


final class MockFetchHeroDetailUseCase: FetchHeroDetailUseCaseProtocol {
    var result: Result<HeroDetail, Error>?
    
    func execute(characterId: Int) async throws -> HeroDetail {
        guard let result = result else {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        
        switch result {
        case .success(let heroDetail):
            return heroDetail
        case .failure(let error):
            throw error
        }
    }
}
