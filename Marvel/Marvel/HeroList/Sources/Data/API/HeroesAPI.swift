import Foundation
import Core

final class HeroesAPI: HeroesAPIProtocol {
    
    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
        
        let apiClient =  APIClient(baseURL: Constants.API.baseURL)
        
        let endpoint = APIHelper.createEndpoint(
            path: "/v1/public/characters",
            offset: offset,
            limit: limit
        )

        let response: HeroResponseDTOContainer = try await apiClient.request(
            endpoint: endpoint,
            responseType: HeroResponseDTOContainer.self
        )

        return response.data.results
    }
}
