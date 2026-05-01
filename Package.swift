// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Mhoush",
  platforms: [.macOS(.v14)],
  dependencies: [
    .package(url: "https://github.com/loopwerk/Saga", from: "3.0.0"),
    .package(url: "https://github.com/loopwerk/SagaParsleyMarkdownReader", from: "1.0.0"),
    .package(url: "https://github.com/loopwerk/SagaSwimRenderer", from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "Mhoush",
      dependencies: [
        .product(name: "Saga", package: "Saga"),
        .product(name: "SagaParsleyMarkdownReader", package: "SagaParsleyMarkdownReader"),
        .product(name: "SagaSwimRenderer", package: "SagaSwimRenderer"),
      ]
    )
  ]
)
