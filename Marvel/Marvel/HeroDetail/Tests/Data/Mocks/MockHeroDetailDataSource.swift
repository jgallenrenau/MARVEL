import Foundation
@testable import HeroDetail

class MockHeroDetailDataSource: HeroDetailDataSourceProtocol {
    var response: HeroDetailResponseDTO?
    var error: Error?

    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO {
        if let error = error {
            throw error
        }
        return response!
    }
}
