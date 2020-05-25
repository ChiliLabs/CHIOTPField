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
        ),
        .library(
            name: "CHIOTPFieldOne",
            targets: ["CHIOTPFieldOne"]
        ),
        .library(
            name: "CHIOTPFieldTwo",
            targets: ["CHIOTPFieldTwo"]
        ),
        .library(
            name: "CHIOTPFieldThree",
            targets: ["CHIOTPFieldThree"]
        ),
        .library(
            name: "CHIOTPFieldFour",
            targets: ["CHIOTPFieldFour"]
        )
    ],
    targets: [
        .target(name: "CHIOTPField"),
        .target(name: "Base", dependencies: [], path: "Sources/Base"),
        .target(name: "CHIOTPFieldOne", dependencies: ["Base"], path: "Sources/CHIOTPFieldOne"),
        .target(name: "CHIOTPFieldTwo", dependencies: ["Base"], path: "Sources/CHIOTPFieldTwo"),
        .target(name: "CHIOTPFieldThree", dependencies: ["Base"], path: "Sources/CHIOTPFieldThree"),
        .target(name: "CHIOTPFieldFour", dependencies: ["Base"], path: "Sources/CHIOTPFieldFour")
    ]
)
