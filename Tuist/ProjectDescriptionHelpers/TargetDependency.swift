import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxFlow = TargetDependency.package(product: "RxFlow")
    static let RealmSwift = TargetDependency.package(product: "RealmSwift")
    static let RxMoya = TargetDependency.package(product: "RxMoya")
    static let Then = TargetDependency.package(product: "Then")
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
}

public extension Package {
    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.2.0")
    )
    static let RxFlow = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxFlow.git",
        requirement: .upToNextMajor(from: "2.10.0")
    )
    static let Moya = Package.remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .upToNextMajor(from: "15.0.0")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then.git",
        requirement: .upToNextMajor(from: "2.7.0")
    )
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.0.1")
    )
    static let Kingfisher = Package.remote(
        url: "https://github.com/onevcat/Kingfisher",
        requirement: .upToNextMajor(from: "7.2.4")
    )
}
