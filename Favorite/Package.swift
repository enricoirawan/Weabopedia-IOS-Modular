// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: Version(stringLiteral: "10.33.0"))),
        .package(url: "https://github.com/enricoirawan/Weabopedia-IOS-Core.git", from: Version(stringLiteral: "1.0.0")),
        .package(path: "Shared"),
        .package(path: "Detail")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Favorite",
            dependencies: [
                .product(name: "Core", package: "Weabopedia-IOS-Core"),
                "Shared",
                "Detail",
                .product(name: "RealmSwift", package: "realm-swift")
            ]),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite"])
    ]
)
