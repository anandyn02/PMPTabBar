// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMPTabBar",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PMPTabBar",
            targets: ["PMPTabBar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/freshOS/Stevia", exact: "5.1.2")
    ],
    targets: [
        .target(
            name: "PMPTabBar",
            dependencies: ["Stevia"],
        path: "Sources"),
        .testTarget(
            name: "PMPTabBarTests",
            dependencies: ["PMPTabBar"]),
    ]
)
