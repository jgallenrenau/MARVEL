import Foundation
import Core

final class HeroesAPI: HeroesAPIProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient(baseURL: Constants.API.baseURL)) {
        self.apiClient = apiClient
    }

    func fetchHeroes(offset: Int, limit: Int) async throws -> [HeroResponseDTO] {
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
