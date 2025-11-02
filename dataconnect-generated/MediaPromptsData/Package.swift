// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MediaPromptsData",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "MediaPromptsData",
            targets: ["MediaPromptsData"]),
    ],
    dependencies: [
      
        .package(path: "/Users/aashishpatil/dev/data-connect-ios-sdk"),
      
    ],
    targets: [
        .target(
            name: "MediaPromptsData",
            dependencies: [
              .product(name:"FirebaseDataConnect", package:"data-connect-ios-sdk")
            ],
            path: "Sources"
        )
    ]
)

