import ProjectDescription

let packages = [
    Package.remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: Version(2, 8, 0))),
    Package.remote(url: "https://github.com/Swinject/SwinjectAutoregistration.git", requirement: .upToNextMajor(from: Version(2, 8, 1)))
]

let dogsTarget = Target(
    name: "Dogs",
    platform: .iOS,
    product: .framework,
    productName: "Dogs",
    bundleId: "com.example.dogs",
    infoPlist: .default,
    sources: "Dogs/**",
    dependencies: [
        .package(product: "Swinject"),
        .package(product: "SwinjectAutoregistration"),
    ]
)

let dogsTests = Target(
    name: "DogsTests",
    platform: .iOS,
    product: .unitTests,
    productName: "DogsTests",
    bundleId: "com.example.dogs.tests",
    infoPlist: .default,
    sources: "DogsTests/**",
    dependencies: [.target(name: "Dogs")]
)

let integrationTests = Target(
    name: "IntegrationTests",
    platform: .iOS,
    product: .unitTests,
    productName: "IntegrationTests",
    bundleId: "com.example.dogs.integrationTests",
    infoPlist: .default,
    sources: "IntegrationTests/**",
    dependencies: [.target(name: "Dogs")]
)

let uikitApp = Target(
    name: "UIKitApp",
    platform: .iOS,
    product: .app,
    productName: "UIKitApp",
    bundleId: "com.example.dogs.uikit",
    infoPlist: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen"]),
    sources: "UIKitApp/**",
    resources: "UIKitApp/App/Assets/**",
    dependencies: [
        .target(name: "Dogs"),
        .package(product: "Swinject"),
        .package(product: "SwinjectAutoregistration"),
    ]
)

let project = Project(
    name: "DogsApp",
    organizationName: "Cleverlance",
    options: [],
    packages: packages,
    settings: nil,
    targets: [dogsTarget, dogsTests, integrationTests, uikitApp],
    schemes: [
        Scheme(
            name: "Dogs",
            shared: true,
            buildAction: BuildAction(targets: [TargetReference(stringLiteral: "Dogs")]),
            testAction: TestAction.targets([TestableTarget(stringLiteral: "DogsTests")])
        ),
        Scheme(
            name: "IntegrationTests",
            shared: true,
            buildAction: BuildAction(targets: [TargetReference(stringLiteral: "Dogs")]),
            testAction: TestAction.targets([TestableTarget(stringLiteral: "IntegrationTests")])
        ),
        Scheme(
            name: "UIKitApp",
            shared: true,
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: "Dogs"),
                TargetReference(stringLiteral: "UIKitApp")
            ]),
            testAction: TestAction.targets([
                TestableTarget(stringLiteral: "DogsTests"),
                TestableTarget(stringLiteral: "IntegrationTests")
            ]),
            runAction: RunAction.runAction(
                configuration: .debug,
                executable: TargetReference(stringLiteral: "UIKitApp")
            )
        )
    ]
)
