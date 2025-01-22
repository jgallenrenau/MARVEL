import Foundation
@testable import HeroDetail

class MockFetchHeroDetailUseCase: FetchHeroDetailUseCaseProtocol {
    var response: HeroDetail?
    var error: Error?

    func execute(characterId: Int) async throws -> HeroDetail {
        if let error = error {
            throw error
        }
        return response!
    }
}
