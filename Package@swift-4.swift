// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ObjectMapper",
    products: [
        .library(name: "ObjectMapper", targets: ["ObjectMapper"]),
    ],
    targets: [
        .target(
            name: "ObjectMapper", 
            dependencies: []
        )
    ],
    swiftLanguageVersions = [3, 4]
)
