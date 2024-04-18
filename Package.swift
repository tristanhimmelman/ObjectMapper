// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "ObjectMapper",
                      platforms: [.macOS(.v12),
                                  .iOS(.v17),
                                  .tvOS(.v17),
                                  .watchOS(.v10)],
                      products: [.library(name: "ObjectMapper",
                                          targets: ["ObjectMapper"])],
                      targets: [.target(name: "ObjectMapper",
                                        path: "Sources"),
                                .testTarget(name: "ObjectMapperTests",
                                            dependencies: ["ObjectMapper"],
                                            path: "Tests")],
                      swiftLanguageVersions: [.v5])
