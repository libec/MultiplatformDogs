// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dogs",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(
            name: "Dogs",
            targets: ["Dogs"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .upToNextMajor(from: "2.8.0")),
    ],
    targets: [
        .target(
            name: "Dogs",
            dependencies: [
                "Swinject",
                "SwinjectAutoregistration"
            ]
        ),
        .testTarget(
            name: "DogsTests",
            dependencies: ["Dogs"]
        ),
        .testTarget(
            name: "DogsIntegrationTests",
            dependencies: ["Dogs"]
        ),
    ]
)
