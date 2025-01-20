# **HeroList SPM Module - Marvel App**

The `HeroList` module is a **Swift Package** that provides functionality for displaying and managing the list of Marvel heroes. It includes:

- **Listing Heroes** with paginated API requests.
- **Clean Architecture** implementation with `Data`, `Domain`, and `View` layers.
- **Redux-style State Management** using The Composable Architecture (TCA).

---

## **Features**

### **1. Data Layer**
- **`HeroesAPI`**: Handles the API requests to fetch Marvel heroes.
- **`RemoteHeroesDataSource`**: Abstracts the interaction with the API client.
- **`HeroesRepository`**: Provides a clean interface for fetching heroes, converting data to domain models.

### **2. Domain Layer**
- **`Hero`**: The domain model representing a Marvel hero.
- **`FetchHeroesUseCase`**: Encapsulates the business logic for fetching paginated heroes.

### **3. View Layer**
- **`HeroesListView`**: Displays the list of heroes.
- **`HeroesRowView`**: Represents individual hero cells.
- **`HeroListCoordinator`**: Handles the coordination and communication between the module and the app.

---

## **Structure**

```plaintext
HeroList/
├── Sources/
│   ├── Data/
│   │   ├── HeroesAPI.swift
│   │   ├── RemoteHeroesDataSource.swift
│   │   ├── HeroesRepository.swift
│   │   └── HeroesRepositoryProtocol.swift
│   ├── Domain/
│   │   ├── Hero.swift
│   │   ├── FetchHeroesUseCase.swift
│   │   └── FetchHeroesUseCaseProtocol.swift
│   ├── View/
│   │   ├── Components/
│   │   │   └── HeroesRowView.swift
│   │   ├── Coordinator/
│   │   │   └── HeroListCoordinator.swift
│   │   ├── Redux/
│   │   │   ├── HeroesListAction.swift
│   │   │   ├── HeroesListEnvironment.swift
│   │   │   ├── HeroesListFeature.swift
│   │   │   └── HeroesListState.swift
│   │   └── HeroesListView.swift
└── Tests/
    ├── Data/
    │   ├── HeroesAPIStub.swift
    │   └── HeroesRepositoryTests.swift
    ├── Domain/
    │   └── FetchHeroesUseCaseTests.swift
    └── View/
        ├── Redux/
        │   └── HeroesListFeatureTests.swift
        ├── HeroesListViewTests.swift
        └── HeroesRowViewTests.swift
```

---

## **Usage**

### **1. HeroesListView**

The main view for displaying a paginated list of Marvel heroes, integrated with TCA.

#### Example:
```swift
HeroesListView(
    store: Store(
        initialState: HeroesListState(),
        reducer: heroesListReducer,
        environment: HeroesListEnvironment(fetchHeroes: { offset, limit in
            let useCase = FetchHeroesUseCase(
                repository: HeroesRepository(
                    remoteDataSource: RemoteHeroesDataSource(
                        api: HeroesAPI()
                    )
                )
            )
            return try await useCase.execute(offset: offset, limit: limit)
        })
    ),
    onHeroSelected: { hero in
        print("Selected Hero: \(hero.name)")
    }
)
```

---

### **2. HeroListCoordinator**

Handles coordination between the list and other modules (e.g., navigating to HeroDetail).

#### Example:
```swift
HeroListCoordinator(onHeroSelected: { hero in
    print("Navigate to HeroDetail with Hero: \(hero.name)")
})
```

---

### **3. FetchHeroesUseCase**

Encapsulates business logic for fetching heroes with pagination.

#### Example:
```swift
let repository = HeroesRepository(remoteDataSource: RemoteHeroesDataSource(api: HeroesAPI()))
let useCase = FetchHeroesUseCase(repository: repository)

do {
    let heroes = try await useCase.execute(offset: 0, limit: 20)
    print(heroes)
} catch {
    print("Error fetching heroes: \(error)")
}
```

---

### **4. TCA Integration**

The module uses **The Composable Architecture (TCA)** for state management and logic. The `HeroesListFeature` reducer handles actions and manages the state.

#### Example:
```swift
let store = Store(
    initialState: HeroesListState(),
    reducer: heroesListReducer,
    environment: HeroesListEnvironment(fetchHeroes: { offset, limit in
        // Fetch heroes implementation
    })
)
```

---

## **Testing**

Unit tests for the `HeroList` module are located in the `Tests/` directory. These include:

1. **Data Layer Tests**:
   - Tests for `HeroesAPI` using a stubbed API client.
   - Tests for `HeroesRepository`.

2. **Domain Layer Tests**:
   - Validation of the business logic in `FetchHeroesUseCase`.

3. **View Layer Tests**:
   - Tests for `HeroesListFeature` reducer actions and state management.
   - UI tests for `HeroesListView` and `HeroesRowView`.

#### Example Test Case:
```swift
func testFetchHeroesSuccess() async throws {
    let mockAPI = HeroesAPIStub()
    let dataSource = RemoteHeroesDataSource(api: mockAPI)
    let repository = HeroesRepository(remoteDataSource: dataSource)
    let useCase = FetchHeroesUseCase(repository: repository)

    let heroes = try await useCase.execute(offset: 0, limit: 20)
    XCTAssertEqual(heroes.count, 20)
}
```

---

## **Installation**

To include the `HeroList` module in your project:

1. Add the package dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/your-repo/hero-list", from: "1.0.0")
```

2. Add `HeroList` as a dependency in your target:

```swift
.target(
    name: "YourFeatureModule",
    dependencies: ["HeroList"]
)
```

---

## **Future Improvements**

1. Add pull-to-refresh functionality in `HeroesListView`.
2. Optimize API error handling and display user-friendly error messages in the UI.

---
