// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnSwiftUIKit",
    platforms: [
        .iOS(.v16), .macOS(.v13)
    ],
    products: [
        .library(
            name: "NnSwiftUIKit",
            type: .dynamic,
            targets: ["NnSwiftUIKit"]),
    ],
    targets: [
        .target(
            name: "NnSwiftUIKit"
        ),
    ]
)
