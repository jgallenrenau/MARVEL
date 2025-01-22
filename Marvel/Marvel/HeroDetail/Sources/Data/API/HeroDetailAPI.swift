import Foundation
import Core

final class HeroDetailAPI: HeroDetailAPIProtocol {
    
    func fetchHeroDetail(characterId: Int) async throws -> HeroDetailResponseDTO {
        
        let apiClient = APIClient(baseURL: Constants.API.baseURL)
        let endpoint = APIHelper.createEndpoint(path: "/v1/public/characters/\(characterId)")
        let response: HeroDetailResponseDTOContainer = try await apiClient.request(
            endpoint: endpoint,
            responseType: HeroDetailResponseDTOContainer.self
        )
        
        guard let heroDetail = response.data.results.first else {
            throw URLError(.badServerResponse)
        }
        return heroDetail
    }
}
