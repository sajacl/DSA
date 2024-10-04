// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DSA",
    products: [
        .library(
            name: "DSA",
            targets: ["DSA"]
        ),
    ],
    targets: [
        .target(name: "DSA"),
        .testTarget(
            name: "DSATests",
            dependencies: ["DSA"]
        ),
    ]
)
