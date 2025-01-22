
# **Core SPM Module - Marvel App**

The `Core` module is a **Swift Package** that provides essential functionalities shared across the Marvel app. It includes:

- **Networking** capabilities (API Client, Endpoints).
- **Utilities** (Logger, Constants).
- **Error handling** for networking and decoding.

---

## **Features**

### **1. Network**
- **`APIClient`**: A reusable HTTP client for making requests with `async/await`.
- **`Endpoints`**: Configurations for Marvel API endpoints.
- **`NetworkError`**: Centralized error management for network operations.

### **2. Utilities**
- **`Constants`**: Centralized storage for API keys, base URLs, and configuration constants.
- **`Logger`**: A lightweight logging utility for debugging and tracking events.

---

## **Structure**

```
Core/
├── Sources/
│   ├── Network/
│   │   ├── Endpoints/
│   │   │   ├── Endpoint.swift
│   │   │   └── MarvelEndpoint.swift
│   │   ├── APIClient.swift
│   │   ├── NetworkError.swift
│   ├── Utilities/
│   │   ├── Constants.swift
│   │   └── Logger.swift
└── Tests/
```

---

## **Usage**

### **1. APIClient**

The `APIClient` handles HTTP requests using `async/await` and decodes responses into the desired model type.

#### Example:
```swift
let apiClient = APIClient(baseURL: URL(string: "https://gateway.marvel.com")!)

do {
    let response: CharacterListResponse = try await apiClient.request(
        endpoint: MarvelEndpoint.getCharacters(limit: 20, offset: 0),
        responseType: CharacterListResponse.self
    )
    print(response.data.results)
} catch {
    print("Error: \(error.localizedDescription)")
}
```

### **2. Endpoints**

Endpoints define API routes and parameters.

#### Example:
```swift
public struct MarvelEndpoint: Endpoint {
    public static func getCharacters(limit: Int = 20, offset: Int = 0) -> MarvelEndpoint {
        return MarvelEndpoint(
            path: "/v1/public/characters",
            queryItems: [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "apikey", value: "your_public_api_key")
            ]
        )
    }
}
```

### **3. NetworkError**

Centralized error handling for consistent and meaningful error messages.

#### Example:
```swift
public enum NetworkError: Error, LocalizedError {
    case invalidRequest
    case invalidResponse
    case decodingFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "The request is invalid."
        case .invalidResponse:
            return "The server response is invalid."
        case .decodingFailed(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}
```

### **4. Utilities**

#### **Constants**
Centralized configuration for API keys, base URLs, and other constants.

```swift
public struct Constants {
    public static let baseURL = URL(string: "https://gateway.marvel.com")!
    public static let apiKey = "your_public_api_key"
}
```

#### **Logger**
A simple utility for logging messages at different levels.

```swift
Logger.info("Fetching Marvel characters")
Logger.error("Failed to fetch characters", error: someError)
```

---

## **Testing**

Unit tests for the `Core` module are located in the `Tests/` directory. These include:

1. Tests for **`APIClient`**.
2. Tests for **`MarvelEndpoint`**.
3. Validation of **`NetworkError`** handling.

#### Example Test Case:
```swift
func testAPIClientRequest() async throws {
    let mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
    let apiClient = APIClient(baseURL: Constants.baseURL, session: mockSession)

    let response: CharacterListResponse = try await apiClient.request(
        endpoint: MarvelEndpoint.getCharacters(limit: 20, offset: 0),
        responseType: CharacterListResponse.self
    )

    XCTAssertEqual(response.data.results.count, 20)
}
```

---

## **Installation**

To include the `Core` module in your project:

1. Add the package dependency to your `Core.swift`:

```swift
.package(url: "https://github.com/your-repo/marvel-core", from: "1.0.0")
```

2. Add `Core` as a dependency in your target:

```swift
.target(
    name: "YourFeatureModule",
    dependencies: ["Core"]
)
```

---

## **Future Improvements**

1. Add caching mechanisms for API responses.
2. Integrate a retry mechanism for failed requests.
3. Support for more customizable log levels in `Logger`.

---
