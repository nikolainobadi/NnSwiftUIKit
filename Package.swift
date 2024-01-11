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
            name: "NnSwiftUIHelpers",
            type: .dynamic,
            targets: ["NnSwiftUIHelpers"]),
        .library(
            name: "NnSwiftUIErrorHandling",
            type: .dynamic,
            targets: ["NnSwiftUIErrorHandling"]),
    ],
    targets: [
        .target(
            name: "NnSwiftUIHelpers"),
        .target(
            name: "NnSwiftUIErrorHandling"),
    ]
)
