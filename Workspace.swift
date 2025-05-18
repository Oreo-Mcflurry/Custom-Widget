import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: AppConfiguration.appName,
    projects: [
        "Projects/App",
        "Projects/Features",
        "Projects/Core",
        "Projects/Domain",
        "Projects/Shared",
        "Projects/ThirdParty",
        "Projects/Widget"
    ]
)
