// swift-tools-version:5.1

import PackageDescription

let package = Package(name: "ObjectMapper",
                      platforms: [.macOS(.v10_10),
                                  .iOS(.v13),
                                  .tvOS(.v9),
                                  .watchOS(.v2)],
                      products: [.library(name: "ObjectMapper",
                                          targets: ["ObjectMapper"])],
                      targets: [.target(name: "ObjectMapper",
                                        path: "Sources"),
                                .testTarget(name: "ObjectMapperTests",
                                            dependencies: ["ObjectMapper"],
                                            path: "Tests")],
                      swiftLanguageVersions: [.v5])
