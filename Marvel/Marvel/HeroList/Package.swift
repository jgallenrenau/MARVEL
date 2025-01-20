// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "HeroList",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "HeroList",
            targets: ["HeroList"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.17.1"),
        .package(name: "Core", path: "../Core"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.11.0")
    ],
    targets: [
        .target(
            name: "HeroList",
            dependencies: [
                "Core",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "HeroListTests",
            dependencies: [
                "HeroList",
                "Core",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
