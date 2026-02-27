// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreToolkit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "CoreToolkit", targets: ["CoreToolkit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", exact: Version("2.8.1"))
    ],
    targets: [
        .target(
            name: "CoreToolkit",
            dependencies: ["Swinject"],
            path: "Sources"),
        .testTarget(
            name: "CoreToolkitTests",
            dependencies: ["CoreToolkit"],
            path: "Tests")
    ]
)
