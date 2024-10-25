// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spm",
    platforms: [
        .macOS(.v12) // 指定最低 macOS 版本为 12.0
    ],
    dependencies: [
//        .package(url: "https://github.com/tuist/XcodeProj.git", .upToNextMajor(from: "8.23.6")),
//        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/tadija/AEXML.git", .upToNextMinor(from: "4.6.1")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMinor(from: "1.0.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "spm",
            dependencies: ["XcodeProj"],
            path: "Sources/Main"
        ),
        .target(
            name: "XcodeProj",
            dependencies: [
                .product(name: "PathKit", package: "PathKit"),
                .product(name: "AEXML", package: "AEXML"),
                //            "XcodeProj",
                //            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources/XcodeProj",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        )
    ]
)
/*
 .product(name: "PathKit", package: "PathKit"),
 .product(name: "AEXML", package: "AEXML"),
 swiftSettings: [
     .enableExperimentalFeature("StrictConcurrency"),
 ]
 */
