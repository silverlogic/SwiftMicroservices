// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductService",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.9"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
    ],
    targets: [
        .target(
            name: "ProductService",
            dependencies: ["ProductServiceAPI"],
            path: "./Sources/ProductService/"),
        .target(
            name: "ProductServiceAPI",
            dependencies: [
                "Kitura",
                "HeliumLogger"
            ],
            path: "./Sources/ProductServiceAPI/"
        )
    ]
)
