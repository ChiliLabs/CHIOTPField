// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CHIOTPField",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "CHIOTPField",
            targets: ["CHIOTPField"]
        )
    ],
    targets: [
        .target(name: "CHIOTPField",
                dependencies: [],
                path: "Sources",
                exclude: [
                    "CHIOTPField.podspec",
                    "Example"
        ])
    ]
)
