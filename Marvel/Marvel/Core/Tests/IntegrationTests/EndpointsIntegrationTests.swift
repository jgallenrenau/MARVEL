import XCTest
@testable import Core

class EndpointsIntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        try? mockKeychain.save(key: "MARVEL_PRIVATE_KEY", value: "mockPrivateKey")
        
        Constants.setKeychainHelper(mockKeychain)
    }
    
    func testEndpointCreation() {
        let endpoint = Endpoint(method: .get, path: "/test", queryItems: nil)
        let request = endpoint.makeURLRequest(baseURL: Constants.API.baseURL)
        XCTAssertEqual(request?.url?.absoluteString, "https://gateway.marvel.com/test")
        XCTAssertEqual(request?.httpMethod, "GET")
    }
    
    func testEndpointWithQueryItems() {
        let queryItems = APIHelper.generateQueryItems(offset: 10, limit: 20)
        let endpoint = Endpoint(method: .get, path: "/v1/public/characters", queryItems: queryItems)
        let request = endpoint.makeURLRequest(baseURL: Constants.API.baseURL)
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let expectedURL = "https://gateway.marvel.com/v1/public/characters?ts=\(queryItems[0].value!)&apikey=\(queryItems[1].value!)&hash=\(queryItems[2].value!)&offset=10&limit=20"
        XCTAssertEqual(request?.url?.absoluteString, expectedURL)
    }
    
    func testEndpointWithPostMethod() {
        let endpoint = Endpoint(method: .post, path: "/v1/public/characters", queryItems: nil)
        let request = endpoint.makeURLRequest(baseURL: Constants.API.baseURL)
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, "POST")
        XCTAssertEqual(request?.url?.absoluteString, "https://gateway.marvel.com/v1/public/characters")
    }
    
    func testEndpointWithEmptyPath() {
        let endpoint = Endpoint(method: .get, path: "", queryItems: nil)
        let request = endpoint.makeURLRequest(baseURL: Constants.API.baseURL)
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.absoluteString, "https://gateway.marvel.com/")
    }
    
    func testEndpointWithInvalidBaseURL() {
        let invalidBaseURL = URL(string: "https://invalid.url")!
        let endpoint = Endpoint(method: .get, path: "/test", queryItems: nil)
        let request = endpoint.makeURLRequest(baseURL: invalidBaseURL)
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.absoluteString, "https://invalid.url/test")
    }
}
