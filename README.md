# Marvel Heroes App

<p align="center">
    <img src="ReadmeFiles/Marvel_Logo.png?raw=true" alt="Alt text" title="Title project">
</p>

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-16.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)


## Overview
The Marvel Heroes App is a Swift-based iOS application that showcases a list of Marvel superheroes with detailed information for each hero, leveraging the [Marvel API](https://developer.marvel.com/docs). This project was created as part of a technical assessment and demonstrates modern iOS development practices, including The Composable Architecture (TCA), modular architecture, and advanced testing strategies.

## Why SOLID Principles?
The app adheres to SOLID principles as a foundation for creating maintainable, scalable, and robust software:

- **Single Responsibility Principle (SRP)**: Each component, module, and class is designed to focus on a single responsibility, reducing coupling and making code easier to read and modify.
- **Open/Closed Principle (OCP)**: The architecture is designed to be extendable without modifying existing code, leveraging protocols and abstractions to introduce new features or layers seamlessly.
- **Liskov Substitution Principle (LSP)**: Interfaces and base classes are structured so that derived types can be substituted without unexpected behavior.
- **Interface Segregation Principle (ISP)**: Modules expose minimal and specific interfaces, ensuring that classes depend only on what they actually use.
- **Dependency Inversion Principle (DIP)**: High-level modules do not depend on low-level modules but rather on abstractions, enabling flexibility and easier testing.



![Alt text](ReadmeFiles/principle_solid.png?raw=true "Clean Architecture Layers")



### How SOLID Principles Are Applied
- **View Layer**: The UI components in SwiftUI are kept declarative and only focus on rendering the data provided by the state.
- **State Management**: TCA reducers encapsulate state mutations and side effects, ensuring predictable and testable behavior.
- **Business Logic**: Use cases encapsulate domain-specific rules, isolating business logic from the UI.
- **Repositories**: Abstractions for data sources allow easy swapping of network or local storage implementations without impacting higher-level modules.


![Alt text](ReadmeFiles/clean-architecture.png?raw=true "Clean Architecture Layers")


This adherence ensures the app is highly modular and supports continuous integration and scaling as new features are added.

## Features
- **Hero List**: Displays a paginated list of Marvel heroes fetched from the Marvel API.
- **Hero Detail**: Provides detailed information about a selected hero, including comics and other related data.
- **Dynamic UI**: Built with SwiftUI for a reactive and declarative user interface.


## Architecture
This project uses The Composable Architecture (TCA) to ensure consistency, scalability, and testability. It adheres to the SOLID principles and is structured into Swift Package Manager (SPM) modules for better separation of concerns and maintainability.

### Why TCA?
TCA is chosen for its ability to:
- **Centralize State Management**: Ensures predictable state updates and clear flow of data.
- **Simplify Testing**: By isolating side effects and using a pure-functional approach.
- **Scalability**: Makes it easy to add new features while keeping the codebase maintainable.



![Alt text](ReadmeFiles/TCE_Scheme.png?raw=true "TCA Architecture")



### Why Modular Architecture?
The app is split into the following modules, and each module includes a dedicated `README.md` file to ensure proper documentation and maintainability. These files provide clear guidance on the module's purpose, structure, and any specific details needed for development or integration:

- **Core**:  
  Contains shared utilities, network logic, and base models used across the application.  
  The `README.md` in this module includes:
  - A description of the shared utilities and their use cases.
  - Information about the network layer and its configuration.
  - Details about the base models and their role in the app's architecture.

- **HeroList**:  
  Manages the hero list screen and related business logic.  
  The `README.md` for this module documents:
  - The structure of the hero list feature.
  - The interaction between the UI, state management, and business logic.
  - Guidelines for extending or modifying the hero list functionality.

- **HeroDetail**:  
  Handles the hero detail screen and its specific functionality.  
  The `README.md` in this module provides:
  - An overview of the hero detail screen's purpose.
  - The flow of data between the view, state management, and use cases.
  - Instructions for adding new data or features to the detail view.


#### Advantages:
1. **Scalability**: Teams can work on individual modules independently.
2. **Encapsulation**: Prevents unnecessary dependencies and ensures a clear separation of concerns.
3. **Reusability**: Common components in the Core module can be reused across multiple features.

![Alt text](ReadmeFiles/Modular_App.png.png?raw=true "TCA Architecture")


Each module respects SOLID principles:
- **Single Responsibility Principle**: Each module and layer focuses on a single responsibility.
- **Dependency Inversion**: Layers interact through clearly defined interfaces.

### Layered Structure
Each module follows a layered architecture:
1. **View**: Built with SwiftUI, handles the user interface.
2. **State and Action**: Defines state and user interactions using TCA’s reducer pattern.
3. **Business Logic**: Encapsulated in Use Cases.
4. **Repository**: Interfaces for data access, whether local or remote.

The View layer interacts with Redux-like state management provided by TCA reducers. These reducers communicate with use cases and repositories, ensuring clean separation of UI, business logic, and data access.

## Testing
The app employs a robust testing strategy, ensuring high code quality and reliability.

### Types of Tests
- **Unit Tests**: Validate individual components, such as reducers and use cases.
- **Integration Tests**: Ensure that different components interact correctly.
- **Snapshot Tests**: Verify the UI by capturing and comparing visual output over time.

### Modular Testing Advantages:
1. **Isolation**: Tests are scoped to specific modules, ensuring faster feedback loops.
2. **Focus**: Each module is responsible for its own tests, making it easier to debug issues.
3. **Reusability**: Shared test utilities can be placed in the Core module for consistency across tests.


![Alt text](ReadmeFiles/graph_testing.png?raw=true "Graph Testing")


<!-- 
## Visual examples of the App

### Search and Detail -  Hero List and  Hero Detail

<center><img src=""https://github.com/jgallenrenau/MarvelExample.gif" align="center" /></center>

### DarkMode - Hero List and  Hero Detail

<center><img src=""https://github.com/jgallenrenau/MarvelExample.gif" align="center" /></center>
-->

## Getting Started

### Prerequisites
- Xcode 16.0
- Swift 6.0
- CocoaPods or Swift Package Manager
- Marvel API Key ([Register here](https://developer.marvel.com/))


### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/jgallenrenau/Marvel.git
   ```
2. Open the project in Xcode:
   ```bash
   cd Marvel
   open Marvel.xcodeproj
   ```
3. Set up your Marvel API Key in the project:
   - Navigate to `Info` tab, from your main project
   - And replace `"YOUR_PRIVATE_API_KEY"`and `"YOUR_PUBLIC_API_KEY"` with your NEW Marvel API keys ( I am currently using the ones offered by the test )

4. Build and run the project:
   - Select a simulator or connected device and press `Cmd + R`.


## Dependencies
The app relies on the following third-party libraries:
- **Composable Architecture**: State management and app architecture.
- **SnapshotTesting**: For UI snapshot tests.


## Future Improvements
- **Offline Mode**: Add local caching to improve user experience without an internet connection.
- **Hero Search**: Implement a search feature to filter heroes.
- **Comics Showcase**: Extend the hero detail view to display comics in a carousel format.


## License
This project is licensed under the MIT License. See the LICENSE file for details.


## Acknowledgments
- [Marvel API](https://developer.marvel.com/) for providing the data.
- [Point-Free](https://www.pointfree.co/) for their work on The Composable Architecture.

---
