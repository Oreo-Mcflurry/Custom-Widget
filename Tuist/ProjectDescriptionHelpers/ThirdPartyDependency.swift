import ProjectDescription

public enum ThirdPartyDependency: String, CaseIterable {
    case composableArchitecture = "ComposableArchitecture"
    case firebaseAnalytics = "FirebaseAnalytics"
    case firebaseCrashlytics = "FirebaseCrashlytics"
    
    public var package: TargetDependency {
        .package(product: rawValue)
    }
} 