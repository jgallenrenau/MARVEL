import XCTest
import HeroList
@testable import Core

final class APIClientHeroListTests: XCTestCase {
    var apiClient: APIClient!
    var sessionMock: URLSessionMock!
    var loggerMock: LoggerMock!

    override func setUp() {
        super.setUp()

        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        Constants.setKeychainHelper(mockKeychain)

        sessionMock = URLSessionMock()
        loggerMock = LoggerMock()
        apiClient = APIClient(baseURL: URL(string: "https://gateway.marvel.com")!, session: sessionMock, logger: loggerMock)
    }

    override func tearDown() {
        Constants.setKeychainHelper(KeychainHelper())
        apiClient = nil
        sessionMock = nil
        loggerMock = nil
        super.tearDown()
    }

    func testRequestSuccess() async throws {
        let mockResponse = HeroResponseDTOContainer(
            code: 200,
            status: "Success",
            data: HeroDataDTO(offset: 0, limit: 1, total: 1, count: 1, results: [])
        )
        
        sessionMock.data = try JSONEncoder().encode(mockResponse)
        sessionMock.response = HTTPURLResponse(
            url: URL(string: "https://gateway.marvel.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let endpoint = Endpoint(method: .get, path: "/v1/public/characters")
        
        let result: HeroResponseDTOContainer = try await apiClient.request(endpoint: endpoint, responseType: HeroResponseDTOContainer.self)
        
        XCTAssertEqual(result.status, "Success")
        XCTAssertEqual(loggerMock.infoLogs.count, 1)
    }

    func testRequestInvalidResponse() async {
        // Configurar respuesta inválida
        sessionMock.response = HTTPURLResponse(
            url: URL(string: "https://gateway.marvel.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        let endpoint = Endpoint(method: .get, path: "/v1/public/characters")
        
        do {
            _ = try await apiClient.request(endpoint: endpoint, responseType: HeroResponseDTOContainer.self)
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

