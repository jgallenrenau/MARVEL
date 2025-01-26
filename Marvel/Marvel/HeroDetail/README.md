# **HeroDetail Module Documentation**

---

## **Introduction**

The `HeroDetail` module is a feature module in the application that focuses on displaying detailed information about a specific Marvel hero. It adheres to clean architecture principles, ensuring modularity, testability, and scalability. The module is designed to handle API interactions, manage data flow through repositories and use cases, and render user interface components for the hero detail screen.

---

## **Folder Structure**

The `HeroDetail` module is organized into the following key components:

1. **`Data/`** - Contains classes and protocols for API communication, data sources, and repositories.
2. **`Domain/`** - Includes the core business logic, such as models and use cases.
3. **`View/`** - Manages the UI components, state, and user interactions.
4. **`Tests/`** - Contains integration tests, unit tests, and mock classes.
5. **`Resources/`** - Stores localizable strings and other module-specific assets.

---

### **Data Layer**

The `Data/` directory is responsible for handling data from external sources and transforming it into domain models.

- **`API/`**
  - **`HeroDetailAPI`**: Handles the network requests for fetching hero details.

    #### Example:
    ```swift
    let heroDetailAPI = HeroDetailAPI()
    Task {
        do {
            let heroDetail = try await heroDetailAPI.fetchHeroDetail(heroId: 1)
            print("Fetched hero detail: \(heroDetail)")
        } catch {
            print("Error fetching hero detail: \(error)")
        }
    }
    ```

  - **`HeroDetailAPIProtocol`**: Defines the contract for the `HeroDetailAPI` implementation.

    #### Example:
    ```swift
    protocol HeroDetailAPIProtocol {
        func fetchHeroDetail(heroId: Int) async throws -> HeroDetailResponseDTO
    }
    ```

  - **`HeroDetailResponseDTO`**: Represents the data transfer object for the hero detail API response.

    #### Example:
    ```swift
    struct HeroDetailResponseDTO: Decodable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: ThumbnailDTO
    }
    ```

- **`DataSource/`**
  - **`RemoteHeroDetailDataSource`**: Fetches hero detail data from the remote API.

    #### Example:
    ```swift
    let remoteDataSource = RemoteHeroDetailDataSource(api: heroDetailAPI)
    Task {
        do {
            let heroDetail = try await remoteDataSource.fetchHeroDetail(heroId: 1)
            print("Fetched hero detail from data source: \(heroDetail)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`HeroDetailDataSourceProtocol`**: Protocol for the remote data source, enabling dependency injection.

    #### Example:
    ```swift
    protocol HeroDetailDataSourceProtocol {
        func fetchHeroDetail(heroId: Int) async throws -> HeroDetail
    }
    ```

- **`Repository/`**
  - **`HeroDetailRepository`**: Provides the implementation for fetching hero detail data through the data sources.

    #### Example:
    ```swift
    let repository = HeroDetailRepository(dataSource: remoteDataSource)
    Task {
        do {
            let heroDetail = try await repository.fetchHeroDetail(heroId: 1)
            print("Hero detail from repository: \(heroDetail)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`HeroDetailRepositoryProtocol`**: Protocol for the repository, allowing for abstraction and easier testability.

    #### Example:
    ```swift
    protocol HeroDetailRepositoryProtocol {
        func fetchHeroDetail(heroId: Int) async throws -> HeroDetail
    }
    ```

---

### **Domain Layer**

The `Domain/` directory focuses on the core business logic and use cases.

- **`Models/`**
  - **`HeroDetail`**: Represents the hero detail entity used across the app.

    #### Example:
    ```swift
    struct HeroDetail: Identifiable {
        let id: Int
        let name: String
        let description: String
        let thumbnailURL: URL
    }
    ```

- **`UseCases/`**
  - **`FetchHeroDetailUseCase`**: Handles the logic of retrieving hero detail from the repository.

    #### Example:
    ```swift
    let useCase = FetchHeroDetailUseCase(repository: repository)
    Task {
        do {
            let heroDetail = try await useCase.execute(heroId: 1)
            print("Hero detail from use case: \(heroDetail)")
        } catch {
            print("Error: \(error)")
        }
    }
    ```

  - **`FetchHeroDetailUseCaseProtocol`**: Protocol for the use case, enabling abstraction for testing.

    #### Example:
    ```swift
    protocol FetchHeroDetailUseCaseProtocol {
        func execute(heroId: Int) async throws -> HeroDetail
    }
    ```

---

### **View Layer**

The `View/` directory contains the UI components and their corresponding state management.

- **`Components/`**
  - **`HeroDetailImageView`**: Displays the hero's image.

    #### Example:
    ```swift
    HeroDetailImageView(imageURL: URL(string: "https://example.com/image.jpg")!)
    ```

  - **`HeroDetailInfoView`**: Shows detailed information about the hero.

    #### Example:
    ```swift
    HeroDetailInfoView(hero: hero)
    ```

- **`Coordinator/`**
  - **`HeroDetailCoordinator`**: Manages navigation logic within the `HeroDetail` module.

    #### Example:
    ```swift
    HeroDetailCoordinator(heroId: 1)
    ```

- **`Redux/`**
  - **`HeroDetailFeature`**: Manages the state and business logic for the hero detail screen.

    #### Example:
    ```swift
    let feature = HeroDetailFeature()
    feature.dispatch(action: .fetchHeroDetail)
    ```

  - **`HeroDetailView`**: The main view for displaying the hero detail.

    #### Example:
    ```swift
    HeroDetailView(store: store)
    ```

---

### **Resources Layer**

The `Resources/` directory includes all the localizable strings and other assets specific to the `HeroDetail` module.

---

### **Tests**

The `Tests/` directory ensures the functionality and reliability of the module through comprehensive testing.

#### **IntegrationTests**

- **API**
  - **`HeroDetailAPITests`**: Tests the integration between `HeroDetailAPI` and the remote service.

    #### Example:
    ```swift
    func testFetchHeroDetail() async throws {
        let api = HeroDetailAPI()
        let heroDetail = try await api.fetchHeroDetail(heroId: 1)
        XCTAssertNotNil(heroDetail)
    }
    ```

- **Repository**
  - **`HeroDetailRepositoryIntegrationTests`**: Verifies the data flow from the API to the repository.

    #### Example:
    ```swift
    func testRepositoryFetch() async throws {
        let repository = HeroDetailRepository(dataSource: mockDataSource)
        let heroDetail = try await repository.fetchHeroDetail(heroId: 1)
        XCTAssertEqual(heroDetail.name, "Spider-Man")
    }
    ```

#### **Mocks**

- **`FetchHeroDetailUseCaseMock`**: Mock implementation for the `FetchHeroDetailUseCase`.

    #### Example:
    ```swift
    let fetchHeroDetailMock = FetchHeroDetailUseCaseMock()
    ```

#### **UnitTests**

- **API**
  - **`HeroDetailAPITests`**: Verifies the `HeroDetailAPI` behavior for various scenarios.

- **View**
  - **`HeroDetailViewSnapshotTests`**: Ensures the UI renders correctly for different states.

    #### Example:
    ```swift
    func testHeroDetailViewSnapshot() {
        let view = HeroDetailView(store: mockStore)
        assertSnapshot(of: view, as: .image)
    }
    ```

---

## **Structure**

```
HeroDetail/
├── Sources/
│   ├── Data/
│   │   ├── API/
│   │   │   ├── HeroDetailAPI.swift
│   │   │   ├── HeroDetailAPIProtocol.swift
│   │   │   └── HeroDetailResponseDTO.swift
│   │   ├── DataSource/
│   │   │   ├── RemoteHeroDetailDataSource.swift
│   │   │   └── HeroDetailDataSourceProtocol.swift
│   │   └── Repository/
│   │       ├── HeroDetailRepository.swift
│   │       └── HeroDetailRepositoryProtocol.swift
│   ├── Domain/
│   │   ├── Models/
│   │   │   └── HeroDetail.swift
│   │   └── UseCases/
│   │       ├── FetchHeroDetailUseCase.swift
│   │       └── FetchHeroDetailUseCaseProtocol.swift
│   ├── View/
│   │   ├── Components/
│   │   │   ├── HeroDetailImageView.swift
│   │   │   └── HeroDetailInfoView.swift
│   │   ├── Coordinator/
│   │   │   └── HeroDetailCoordinator.swift
│   │   ├── Redux/
│   │   │   ├── HeroDetailFeature.swift
│   │   │   └── HeroDetailView.swift
│   │
│   └── Resources/
│       └── Localizable.strings
├── Tests/
│   ├── IntegrationTests/
│   │   ├── API/
│   │   │   └── HeroDetailAPITests.swift
│   │   ├── Redux/
│   │   │   └── HeroDetailFeatureTests.swift
│   │   └── Repository/
│   │       └── HeroDetailRepositoryIntegrationTests.swift
│   ├── Mocks/
│   │   ├── FetchHeroDetailUseCaseMock.swift
│   │   ├── HeroDetailAPIMock.swift
│   │   ├── HeroDetailRepositoryMock.swift
│   │   ├── RemoteHeroDetailDataSourceMock.swift
│   │   └── KeychainHelperMock.swift
│   ├── UnitTests/
│   │   ├── API/
│   │   │   └── HeroDetailAPITests.swift
│   │   ├── Coordinator/
│   │   │   └── HeroDetailCoordinatorTests.swift
│   │   ├── DataSource/
│   │   │   └── RemoteHeroDetailDataSourceTests.swift
│   │   ├── UseCase/
│   │   │   └── FetchHeroDetailUseCaseTests.swift
│   │   └── View/
│   │       ├── Components/
│   │       │   └── HeroDetailImageViewSnapshotTests.swift
│   │       └── HeroDetailViewSnapshotTests.swift
```

---

## **Future Improvements**

1. Add offline caching for hero detail data.
2. Enhance error handling for API responses.
3. Improve snapshot testing coverage for edge cases.

---


