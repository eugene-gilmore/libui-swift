// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ui",
    dependencies: [
        .package(url: "/Users/eugene/src/clibui", .branch("master")),
        //.package(url: "https://github.com/eugene-gilmore/clibui.git", from : "1.0.0"),
    ]
)
