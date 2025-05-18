import ProjectDescription

public enum AppTargets {
    case app
    case widget
    case features
    case core
    case domain
    case shared
    case thirdParty
    
    public var name: String {
        switch self {
        case .app: return "App"
        case .widget: return "Widget"
        case .features: return "Features"
        case .core: return "Core"
        case .domain: return "Domain"
        case .shared: return "Shared"
        case .thirdParty: return "ThirdParty"
        }
    }
    
    public var product: Product {
        switch self {
        case .app: return .app
        case .widget: return .appExtension
        default: return .framework
        }
    }
    
    public var sources: SourceFilesList {
        .paths(["Sources/**"])
    }
    
    public var resources: ResourceFileElements? {
        switch self {
        case .app, .shared, .widget:
            return ["../App/Resources/**"]
        default:
            return nil
        }
    }
    
    public var projectDependencies: [TargetDependency] {
        switch self {
        case .app:
            return [
                .project(target: AppTargets.features.name, path: AppConfiguration.projectPath(for: .features))
            ]
        case .widget:
            return []
        case .features:
            return [
                .project(target: AppTargets.domain.name, path: AppConfiguration.projectPath(for: .domain))
            ]
        case .domain:
            return [
                .project(target: AppTargets.shared.name, path: AppConfiguration.projectPath(for: .shared))
            ]
        case .core:
            return [
                .project(target: AppTargets.domain.name, path: AppConfiguration.projectPath(for: .domain))
            ]
        case .shared:
            return [
                .project(target: AppTargets.thirdParty.name, path: AppConfiguration.projectPath(for: .thirdParty))
            ]
        case .thirdParty:
            return ThirdPartyDependency.allCases.map { .external(name: $0.rawValue) }
        }
    }
    
    public var target: ProjectDescription.Target {
        .target(
            name: name,
            destinations: [.iPhone],
            product: product,
            bundleId: AppConfiguration.bundleId(for: self),
            deploymentTargets: .iOS(AppConfiguration.deploymentTarget),
            infoPlist: self == .app ? .extendingDefault(
                with: [
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ]
                            ]
                        ]
                    ],
                    "CFBundleDisplayName": "\(AppConfiguration.displayName)",
                    "CFBundleShortVersionString": "\(AppConfiguration.version)",
                    "CFBundleVersion": "\(AppConfiguration.build)"
                ]
            ) : self == .widget ? .extendingDefault(
                with: [
                    "NSExtension": [
                        "NSExtensionAttributes": [
                            "WidgetFamily": ["systemSmall", "systemMedium", "systemLarge"]
                        ],
                        "NSExtensionPointIdentifier": "com.apple.widget-extension",
                        "NSExtensionPrincipalClass": "WidgetKit.WKWidgetPrincipalClass"
                    ]
                ]
            ) : .default,
            sources: sources,
            resources: resources,
            dependencies: projectDependencies
        )
    }
    
    public var testTarget: ProjectDescription.Target? {
        switch self {
        case .thirdParty, .widget:
            return nil
        default:
            return .target(
                name: "\(name)Tests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: AppConfiguration.testBundleId(for: self),
                deploymentTargets: .iOS(AppConfiguration.deploymentTarget),
                infoPlist: .default,
                sources: ["Tests/**"],
                dependencies: [.target(name: name)]
            )
        }
    }
    
    public var project: Project {
        let targets: [Target] = {
            if self == .app {
                return [target]
            } else {
                return [target] + (testTarget.map { [$0] } ?? [])
            }
        }()
        
        return Project(
            name: name,
            organizationName: AppConfiguration.organizationName,
            packages: [],
            settings: AppConfiguration.projectSettings(),
            targets: targets
        )
    }
    
    // MARK: - ThirdParty Dependencies
    private enum ThirdPartyDependency: String, CaseIterable {
        case composableArchitecture = "ComposableArchitecture"
        case firebaseAnalytics = "FirebaseAnalytics"
//        case firebaseCrashlytics = "FirebaseCrashlytics"
    }
} 
