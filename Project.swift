import ProjectDescription

let packages = [
    Package.remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: Version(2, 8, 0))),
    Package.remote(url: "https://github.com/Swinject/SwinjectAutoregistration.git", requirement: .upToNextMajor(from: Version(2, 8, 1))),
    Package.local(path: "Dogs")
]

let uikitApp = Target(
    name: "UIKitApp",
    platform: .iOS,
    product: .app,
    productName: "UIKitApp",
    bundleId: "com.example.dogs.uikit",
    infoPlist: .extendingDefault(with: ["UILaunchScreen": [:]]),
    sources: "UIKitApp/**",
    resources: "UIKitApp/App/Assets/**",
    dependencies: [
        .package(product: "Dogs"),
        .package(product: "Swinject"),
        .package(product: "SwinjectAutoregistration"),
    ]
)

let swiftUIApp = Target(
    name: "SwiftUIApp",
    platform: .iOS,
    product: .app,
    productName: "SwiftUIApp",
    bundleId: "com.example.dogs.swiftui",
    infoPlist: .extendingDefault(with: ["UILaunchScreen": [:]]),
    sources: "SwiftUIApp/**",
    resources: "SwiftUIApp/App/Assets/**",
    dependencies: [
        .package(product: "Dogs"),
        .package(product: "Swinject"),
        .package(product: "SwinjectAutoregistration"),
    ]
)

let macOSApp = Target(
    name: "macOSApp",
    platform: .macOS,
    product: .app,
    productName: "macOSApp",
    bundleId: "com.example.dogs.macOS",
    infoPlist: .default,
    sources: "macOSApp/**",
    resources: "macOSApp/App/Assets/**",
    dependencies: [
        .package(product: "Dogs"),
        .package(product: "Swinject"),
        .package(product: "SwinjectAutoregistration"),
    ]
)


let project = Project(
    name: "DogsApp",
    organizationName: "Example",
    packages: packages,
    settings: nil,
    targets: [uikitApp, swiftUIApp, macOSApp],
    schemes: [
        Scheme(
            name: "UIKitApp",
            shared: true,
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: "UIKitApp")
            ]),
            runAction: RunAction.runAction(
                configuration: .debug,
                executable: TargetReference(stringLiteral: "UIKitApp")
            )
        ),
        Scheme(
            name: "SwiftUIApp",
            shared: true,
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: "SwiftUIApp")
            ]),
            runAction: RunAction.runAction(
                configuration: .debug,
                executable: TargetReference(stringLiteral: "SwiftUIApp")
            )
        ),
        Scheme(
            name: "macOSApp",
            shared: true,
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: "macOSApp")
            ]),
            runAction: RunAction.runAction(
                configuration: .debug,
                executable: TargetReference(stringLiteral: "macOSApp")
            )
        )

    ]
)
