import ProjectDescription

extension Project{
    public static func excutable(
        name: String,
        platform: Platform,
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: [.iphone, .iphone]),
        dependencies: [TargetDependency]
    ) -> Project {
        return Project(
            name: name,
            organizationName: hackathon24OrganizationName,
            targets: [
                
                Target(
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(hackathon24OrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    scripts: [.swiftLintScript],
                    dependencies: [
                        .project(target: "ThirdPartyLib", path: "../ThirdPartyLib")
                    ] + dependencies
                )
            ]
        )
    }
}
