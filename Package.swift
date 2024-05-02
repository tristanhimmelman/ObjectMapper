// swift-tools-version:5.5

import PackageDescription

let package = Package(name: "ObjectMapper",
                      platforms: [.macOS(.v12),
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
