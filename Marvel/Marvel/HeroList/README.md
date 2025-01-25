# **HeroList Module Documentation**

---

## **Introduction**

The `HeroList` module is a feature module in the application that handles the retrieval and display of Marvel heroes. It is structured to follow clean architecture principles with modularity, testability, and scalability in mind. This module is responsible for interacting with APIs, managing the data flow through repositories and use cases, and rendering the user interface components.

---

## **Folder Structure**

The `HeroList` module is organized into the following key components:

1. **`Data/`** - Contains classes and protocols for API communication, data sources, and repositories.
2. **`Domain/`** - Includes the core business logic, such as models and use cases.
3. **`View/`** - Manages the UI components, state, and user interactions.
4. **`Tests/`** - Contains integration tests, unit tests, and mock classes.
5. **`Resources/`** - Stores localizable strings and other module-specific assets.

---

### **Data Layer**

The `Data/` directory is responsible for handling data from external sources and transforming it into domain models.

- **`API/`**
  - **`HeroesAPI`**: Handles the network requests for fetching heroes data.

    #### Example:
    ```swift
    let heroesAPI = HeroesAPI()
    Task {
        do {
            let heroes = try await heroesAPI.fetchHeroes(offset: 0, limit: 20)
            print("Fetched heroes: \(heroes)")
        } catch {
            print("Error fetching heroes: \(error)")
        }
    }
    ```

  - **`HeroesAPIProtocol`**: Defines the contract for the `HeroesAPI` implementation.

    #### Example:
    ```swift
    protocol HeroesAPIProtocol {
        func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero]
    }
    ```

  - **`HeroesResponseDTO`**: Represents the data transfer object for the heroes API response.

    #### Example:
    ```swift
    struct HeroesResponseDTO: Decodable {
        let data: HeroesData

        struct HeroesData: Decodable {
            let results: [HeroDTO]
        }
    }
    ```

- **`DataSource/`**
  - **`RemoteHeroesDataSource`**: Fetches heroes data from the remote API.

    #### Example:
    ```swift
    let remoteDataSource = RemoteHeroesDataSource(api: heroesAPI)
    Task {
        do {
            let heroes = try await remoteDataSource.fetchHeroes(offset: 0, limit: 20)
            print("Fetched heroes from data source: \(heroes)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`RemoteHeroesDataSourceProtocol`**: Protocol for the remote data source, enabling dependency injection.

    #### Example:
    ```swift
    protocol RemoteHeroesDataSourceProtocol {
        func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero]
    }
    ```

- **`Repository/`**
  - **`HeroesRepository`**: Provides the implementation for fetching heroes data through the data sources.

    #### Example:
    ```swift
    let repository = HeroesRepository(remoteDataSource: remoteDataSource)
    Task {
        do {
            let heroes = try await repository.fetchHeroes(offset: 0, limit: 20)
            print("Heroes from repository: \(heroes)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`HeroesRepositoryProtocol`**: Protocol for the repository, allowing for abstraction and easier testability.

    #### Example:
    ```swift
    protocol HeroesRepositoryProtocol {
        func fetchHeroes(offset: Int, limit: Int) async throws -> [Hero]
    }
    ```

---

### **Domain Layer**

The `Domain/` directory focuses on the core business logic and use cases.

- **`Models/`**
  - **`Hero`**: Represents the hero entity used across the app.

    #### Example:
    ```swift
    struct Hero: Identifiable {
        let id: Int
        let name: String
        let description: String
    }
    ```

- **`UseCases/`**
  - **`FetchHeroesUseCase`**: Handles the logic of retrieving heroes from the repository.

    #### Example:
    ```swift
    let useCase = FetchHeroesUseCase(repository: repository)
    Task {
        do {
            let heroes = try await useCase.execute(offset: 0, limit: 20)
            print("Heroes from use case: \(heroes)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`FetchHeroesUseCaseProtocol`**: Protocol for the use case, enabling abstraction for testing.

    #### Example:
    ```swift
    protocol FetchHeroesUseCaseProtocol {
        func execute(offset: Int, limit: Int) async throws -> [Hero]
    }
    ```

---

### **View Layer**

The `View/` directory contains the UI components and their corresponding state management.

- **`Components/`**
  - **`HeroesRowView`**: A reusable row component for displaying individual heroes.

    #### Example:
    ```swift
    HeroesRowView(hero: Hero(id: 1, name: "Spider-Man", description: "Friendly neighborhood Spider-Man"))
    ```

- **`Coordinator/`**
  - **`HeroesListCoordinator`**: Manages navigation logic within the `HeroList` module.

    #### Example:
    ```swift
    let coordinator = HeroesListCoordinator()
    coordinator.start()
    ```

- **`Redux/`**
  - **`HeroesListFeature`**: Manages the state and business logic for the heroes list screen.

    #### Example:
    ```swift
    let feature = HeroesListFeature()
    feature.dispatch(action: .fetchHeroes)
    ```

  - **`HeroesListView`**: The main view for displaying the list of heroes.

    #### Example:
    ```swift
    HeroesListView()
    ```

---

### **Resources Layer**

The `Resources/` directory includes all the localizable strings and other assets specific to the `HeroList` module.

---

### **Tests**

The `Tests/` directory ensures the functionality and reliability of the module through comprehensive testing.

#### **IntegrationTests**

- **API**
  - **`HeroesAPITests`**: Tests the integration between `HeroesAPI` and the remote service.

    #### Example:
    ```swift
    func testFetchHeroes() async throws {
        let api = HeroesAPI()
        let heroes = try await api.fetchHeroes(offset: 0, limit: 20)
        XCTAssertFalse(heroes.isEmpty)
    }
    ```

- **Repository**
  - **`HeroesRepositoryIntegrationTests`**: Verifies the data flow from the API to the repository.

    #### Example:
    ```swift
    func testRepositoryFetch() async throws {
        let repository = HeroesRepository(remoteDataSource: mockDataSource)
        let heroes = try await repository.fetchHeroes(offset: 0, limit: 20)
        XCTAssertEqual(heroes.count, 20)
    }
    ```

- **Redux**
  - **`HeroesListFeatureTests`**: Tests the state management logic for the heroes list.

    #### Example:
    ```swift
    func testReduxState() {
        let feature = HeroesListFeature()
        feature.dispatch(action: .fetchHeroes)
        XCTAssertNotNil(feature.state.heroes)
    }
    ```

#### **Mocks**

- **`APIClientMock`**: Simulates HTTP responses for the `HeroesAPI`.

    #### Example:
    ```swift
    let mockAPIClient = APIClientMock(response: mockResponse)
    ```

- **`FetchHeroesMock`**: Mock implementation for the `FetchHeroesUseCase`.

    #### Example:
    ```swift
    let fetchHeroesMock = FetchHeroesMock()
    ```

#### **UnitTests**

- **API**
  - **`APIClientTests`**: Verifies the `HeroesAPI` behavior for various scenarios.

    #### Example:
    ```swift
    func testAPIClient() async throws {
        let api = HeroesAPI()
        let response = try await api.fetchHeroes(offset: 0, limit: 20)
        XCTAssertNotNil(response)
    }
    ```

---

## **Structure**

```
HeroList/
├── Sources/
│   ├── Data/
│   │   ├── API/
│   │   │   ├── HeroesAPI.swift
│   │   │   ├── HeroesAPIProtocol.swift
│   │   │   └── HeroesResponseDTO.swift
│   │   ├── DataSource/
│   │   │   ├── RemoteHeroesDataSource.swift
│   │   │   └── RemoteHeroesDataSourceProtocol.swift
│   │   └── Repository/
│   │       ├── HeroesRepository.swift
│   │       └── HeroesRepositoryProtocol.swift
│   ├── Domain/
│   │   ├── Models/
│   │   │   └── Hero.swift
│   │   └── UseCases/
│   │       ├── FetchHeroesUseCase.swift
│   │       └── FetchHeroesUseCaseProtocol.swift
│   ├── View/
│   │   ├── Components/
│   │   │   └── HeroesRowView.swift
│   │   ├── Coordinator/
│   │   │   └── HeroesListCoordinator.swift
│   │   ├── Redux/
│   │   │   ├── HeroesListFeature.swift
│   │   │   └── HeroesListView.swift
│   │
│   └── Resources/
│       └── Localizable.strings
├── Tests/
│   ├── IntegrationTests/
│   │   ├── API/
│   │   │   └── HeroesAPITests.swift
│   │   ├── Redux/
│   │   │   └── HeroesListFeatureTests.swift
│   │   └── Repository/
│   │       └── HeroesRepositoryIntegrationTests.swift
│   ├── Mocks/
│   │   ├── APIClientMock.swift
│   │   ├── FetchHeroesMock.swift
│   │   ├── HeroesAPIMock.swift
│   │   ├── HeroesRepositoryMock.swift
│   │   ├── LoggerMock.swift
│   │   ├── RemoteHeroesDataSourceMock.swift
│   │   └── URLSessionMock.swift
│   ├── UnitTests/
│   │   ├── API/
│   │   │   └── APIClientTests.swift
│   │   ├── Coordinator/
│   │   │   └── HeroesListCoordinatorTests.swift
│   │   ├── DataSource/
│   │   │   └── RemoteHeroesDataSourceTests.swift
│   │   ├── UseCase/
│   │   │   └── FetchHeroesUseCaseTests.swift
│   │   └── View/
│   │       ├── Components/
│   │       │   └── HeroesRowSnapshotTests.swift
│   │       └── HeroesListSnapshotTests.swift
```

---

## **Future Improvements**

1. Add offline caching for heroes data.
2. Improve error handling for API responses.
3. Optimize performance for large datasets in the heroes list view.

---
