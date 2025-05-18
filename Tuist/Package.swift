// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        productTypes: [
            "ComposableArchitecture": .framework,
            "FirebaseAnalytics": .framework,
            "FirebaseCrashlytics": .framework
        ]
    )
#endif

let package = Package(
    name: "CustomWidget",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "ProjectDescriptionHelpers", type: .dynamic, targets: ["ProjectDescriptionHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/tuist", from: "4.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.7.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.19.0")
    ],
    targets: [
        .target(
            name: "ProjectDescriptionHelpers",
            dependencies: [
                .product(name: "ProjectDescription", package: "tuist")
            ]
        )
    ]
)
