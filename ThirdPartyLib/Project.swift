import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .RxFlow,
        .Moya,
        .Then,
        .SnapKit,
        .Kingfisher
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Kingfisher
    ]
)
