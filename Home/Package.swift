// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
        .package(url: "https://github.com/enricoirawan/Weabopedia-IOS-Core.git", from: Version(stringLiteral: "1.0.0")),
        .package(path: "Shared"),
        .package(path: "Detail")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Core", package: "Weabopedia-IOS-Core"),
                "Shared",
                "Detail",
                "Alamofire",
                "SDWebImage",
                "Swinject",
                "SkeletonView"
            ]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"])
    ]
)
