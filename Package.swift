// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ListPagination",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "ListPagination",
            targets: ["ListPagination"]),
    ],
    targets: [
        .target(
            name: "ListPagination",
            dependencies: []),
        .testTarget(
            name: "ListPaginationTests",
            dependencies: ["ListPagination"]),
    ]
)
