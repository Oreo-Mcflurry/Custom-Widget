import ProjectDescription

public enum AppConfiguration {
    public static let appName = "CustomWidget"
    public static let displayName = "Custom Widget"
    public static let organizationName = "com.yoo"
    public static let bundleIdPrefix = "\(organizationName).\(appName.lowercased())"
    public static let version: String = "1.0.0"
    public static let build: String = "1"
    public static let platform: Platform = .iOS
    public static let deploymentTarget: String = "17.0"
    public static let swiftVersion: String = "6.0"
    
    public static let baseSettings: SettingsDictionary = [
        "DEVELOPMENT_TEAM": .string("\(PrivateConfiguration.developmentTeam)"),
        "CODE_SIGN_STYLE": .string("Automatic"),
        "SWIFT_VERSION": .string(swiftVersion),
        "CODE_SIGN_IDENTITY": .string("Apple Development"),
        "CURRENT_PROJECT_VERSION": .string(build),
        "MARKETING_VERSION": .string(version),
        "IPHONEOS_DEPLOYMENT_TARGET": .string(deploymentTarget),
        "INFOPLIST_KEY_CFBundleDisplayName": .string(displayName),
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": .string("YES"),
        "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": .string("AccentColor")
    ]
    
    public static func projectSettings() -> Settings {
        .settings(
            base: baseSettings,
            configurations: [
                .debug(name: "Debug"),
                .release(name: "Release")
            ]
        )
    }
    
    public static func bundleId(for target: AppTargets) -> String {
        switch target {
        case .app:
            return "\(bundleIdPrefix).app"
        case .widget:
            return "\(bundleIdPrefix).widget"
        case .features:
            return "\(bundleIdPrefix).features"
        case .core:
            return "\(bundleIdPrefix).core"
        case .domain:
            return "\(bundleIdPrefix).domain"
        case .shared:
            return "\(bundleIdPrefix).shared"
        case .thirdParty:
            return "\(bundleIdPrefix).thirdParty"
        }
    }
    
    public static func testBundleId(for target: AppTargets) -> String {
        "\(bundleId(for: target)).tests"
    }
    
    public static func projectPath(for target: AppTargets) -> Path {
        .relativeToRoot("Projects/\(target.name)")
    }
}
