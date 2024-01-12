// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnSwiftUIKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "NnSwiftUIKit",
            targets: ["NnSwiftUIKit"]),
    ],
    targets: [
        .target(
            name: "NnSwiftUIKit"
        ),
    ]
)
