// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "HeroDetail",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "HeroDetail",
            targets: ["HeroDetail"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.17.1"),
        .package(name: "Core", path: "../Core"),
            .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.11.0")
    ],
    targets: [
        .target(
            name: "HeroDetail",
            dependencies: [
                "Core",
                "DesignSystem",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "HeroDetailTests",
            dependencies: [
                "HeroDetail",
                "Core",
                "DesignSystem",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
