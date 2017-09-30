// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthenticationService",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.9"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Credentials.git", from: "1.7.2"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", from: "1.8.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Crypto.git", from: "3.0.1")
    ],
    targets: [
        .target(
            name: "AuthenticationService",
            dependencies: ["AuthenticationServiceAPI"],
            path: "./Sources/AuthenticationService/"),
        .target(
            name: "AuthenticationServiceAPI",
            dependencies: ["Kitura",
                           "HeliumLogger",
                           "PerfectCrypto",
                           "Kitura-Credentials",
                           "Kitura-CredentialsHTTP"],
            path: "./Sources/AuthenticationServiceAPI/")
    ]
)
