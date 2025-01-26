# **Core Module Documentation**

---

## **Introduction**

The `Core` module is the backbone of the application, providing essential utilities, protocols, API clients, and helpers. It is structured for scalability and testability, with a strong focus on separation of concerns and modularity.

---

## **Folder Structure**

The `Core` module is organized into the following key components:

1. **`API/`** - Contains classes and structures responsible for API communication.
2. **`Protocols/`** - Defines reusable protocols for dependency injection and testability.
3. **`Security/`** - Manages secure storage using the Keychain.
4. **`Utilities/`** - Includes utility classes for constants and logging.
5. **`Tests/`** - Contains integration tests, unit tests, and mock classes.

---

### **API Layer**

The `API/` directory contains components related to API requests and their management:

- **`APIClient`**: A class that handles HTTP requests and response decoding. Implements `APIClientProtocol`.
- **`APIHelper`**: Provides helper methods to create query parameters and endpoints.
- **`APIKeys`**: Retrieves API keys from the app’s `Info.plist`.
- **`Endpoint`**: Represents API endpoints, including paths, HTTP methods, and query parameters.
- **`HTTPMethod`**: Enumerates HTTP request methods such as `.get` and `.post`.
- **`NetworkError`**: Defines error cases for network-related failures, such as invalid requests or decoding errors.

---

### **Protocols**

The `Protocols` layer defines the contracts for key components, enabling dependency injection and easier testability.

- **`APIClientProtocol`**: Outlines the required methods for API client implementations, such as performing HTTP requests.
- **`KeychainHelperProtocol`**: Specifies the interface for interacting with the keychain, providing methods to save, retrieve, and delete data securely.

---

### **Security**

The `Security` layer handles keychain interactions and ensures secure storage of sensitive data.

- **`InfoPlistHelper`**: A utility to fetch predefined keys from the app's `Info.plist` file and store them securely in the keychain if needed.
- **`KeychainError`**: An enumeration that defines errors related to keychain operations (e.g., saving, retrieving, or deleting data).
- **`KeychainHelper`**: Implements `KeychainHelperProtocol`, providing methods to save, retrieve, and delete data securely using the system keychain.

---

### **Utilities**

The `Utilities` layer contains reusable components and shared logic across the core module.

- **`Constants`**: Stores static configuration data, such as base API URLs and secure access to API keys retrieved from the keychain.
- **`Logger`**: Implements logging functionality, allowing the application to log informational, warning, and error messages.

---

## **Tests**

The `Tests` layer is organized into three main subdirectories to ensure comprehensive testing of the Core module.

#### **IntegrationTests**

Focuses on testing the interaction between multiple components or external systems.
- **`APIClientIntegrationTests`**: Tests the full flow of API requests and responses using mocked endpoints.
- **`APIHelperIntegrationTests`**: Validates the correct generation of query parameters for API requests.
- **`EndpointsIntegrationTests`**: Verifies the correct construction of `Endpoint` objects and their URL requests.

#### **Mocks**

Provides mock implementations of protocols and dependencies for isolated unit testing.
- **`MockAPIClient`**: A mock version of the API client to simulate HTTP responses.
- **`MockConstantsTests`**: Mock configuration of constants for specific test scenarios.
- **`MockInfoPlistProvider`**: Mock utility to simulate `Info.plist` data in tests.
- **`MockKeychainHelper`**: A mock keychain helper to test secure storage operations.
- **`MockLogger`**: Captures log messages for validating logging behavior in tests.
- **`MockResponse`**: Represents a mocked HTTP response structure for API tests.
- **`MockURLProtocol`**: Simulates URL responses for mocking network requests.

#### **UnitTests**

Isolates testing to individual components or functionalities.
- **`APIClientTests`**: Tests the `APIClient` class for proper request and response handling.
- **`APIHelperTests`**: Verifies the logic for generating API query parameters.
- **`ConstantsTests`**: Ensures constant values and configurations behave as expected.
- **`InfoPlistHelperTests`**: Tests interactions with the `Info.plist` file and keychain integration.
- **`KeychainHelperTests`**: Validates the `KeychainHelper` methods for secure data storage.
- **`LoggerTests`**: Ensures that logging works correctly and captures expected messages.
- **`NetworkErrorTests`**: Tests error handling and messaging for various network-related errors.


## **Structure**

```
Core/
├── Sources/
│   ├── API/
│   │   ├── APIClient.swift
│   │   ├── APIHelper.swift
│   │   ├── APIKeys.swift
│   │   ├── Endpoint.swift
│   │   ├── HTTPMethod.swift
│   │   └── NetworkError.swift
│   ├── Protocols/
│   │   ├── APIClientProtocol.swift
│   │   └── KeychainHelperProtocol.swiftç
│   │   └── URLSessionProtocol.swift
│   ├── Security/
│   │   ├── InfoPlistHelper.swift
│   │   ├── KeychainError.swift
│   │   └── KeychainHelper.swift
│   └── Utilities/
│       ├── Constants.swift
│       └── Logger.swift
├── Tests/
│   ├── IntegrationTests/
│   │   ├── APIClientIntegrationTests.swift
│   │   ├── APIHelperIntegrationTests.swift
│   │   └── EndpointsIntegrationTests.swift
│   ├── Mocks/
│   │   ├── MockAPIClient.swift
│   │   ├── MockConstantsTests.swift
│   │   ├── MockInfoPlistProvider.swift
│   │   ├── MockKeychainHelper.swift
│   │   ├── MockLogger.swift
│   │   ├── MockResponse.swift
│   │   └── MockURLProtocol.swift
│   └── UnitTests/
│       ├── APIClientTests.swift
│       ├── APIHelperTests.swift
│       ├── ConstantsTests.swift
│       ├── InfoPlistHelperTests.swift
│       ├── KeychainHelperTests.swift
│       ├── LoggerTests.swift
│       └── NetworkErrorTests.swift

```

---

## **Usage**

This section provides practical examples of how to use the Core module functionalities in your project. 

### **1. APIClient**

The `APIClient` handles HTTP requests using `async/await` and decodes responses into the desired model type.

#### Example:

```swift
import Core

let apiClient = APIClient(baseURL: Constants.API.baseURL)

Task {
    do {
        let endpoint = Endpoint(method: .get, path: "/v1/public/characters", queryItems: APIHelper.generateQueryItems(offset: 0, limit: 20))
        let response: MockResponse = try await apiClient.request(endpoint: endpoint, responseType: MockResponse.self)
        print("Response:", response)
    } catch {
        print("Error:", error)
    }
}
```

### **2. Keychain Helper**

The KeychainHelper class provides secure storage for sensitive data. Here's an example:

#### Example:

```swift
import Core

let keychainHelper = KeychainHelper()

do {
    try keychainHelper.save(key: "USER_TOKEN", value: "mockToken123")
    let token = try keychainHelper.retrieve(key: "USER_TOKEN")
    print("Retrieved Token:", token)
    try keychainHelper.delete(key: "USER_TOKEN")
} catch {
    print("Keychain Error:", error)
}
```

### **3. Logger**

The Logger class logs messages at different levels (info, warning, error). Example:

#### Example:

```swift
import Core

let logger = Logger()

logger.logInfo("This is an info log.")
logger.logWarning("This is a warning log.")
logger.logError("This is an error log.")

```

### **4. Constants and Configuration**

The Constants struct provides centralized configuration for API keys and the base URL:

#### Example:

```swift
import Core

print("Base URL:", Constants.API.baseURL)

do {
    print("Public Key:", Constants.API.publicKey)
    print("Private Key:", Constants.API.privateKey)
} catch {
    print("Error retrieving keys:", error)
}

```

### *5. API Helper**

The APIHelper simplifies query item generation for API requests. Example:

#### Example:

```swift
import Core

let queryItems = APIHelper.generateQueryItems(offset: 0, limit: 20)
print("Generated Query Items:", queryItems)

```

---

### *6. Mocking for Testing**

When running tests, you can configure mock data and dependencies:

#### Example:

```swift
import Core
import XCTest

class ExampleTests: XCTestCase {
    func testExample() {
        let mockKeychain = MockKeychainHelper()
        try? mockKeychain.save(key: "MARVEL_PUBLIC_KEY", value: "mockPublicKey")
        Constants.setKeychainHelper(mockKeychain)
        
        XCTAssertEqual(Constants.API.publicKey, "mockPublicKey")
    }
}
```

These examples cover common scenarios for using the Core module in your project, including API requests, secure storage, logging, configuration management, and mocking for tests. 

---

## **Future Improvements**

1. Add caching mechanisms for API responses.
2. Integrate a retry mechanism for failed requests.
3. Support for more customizable log levels in `Logger`.

---
