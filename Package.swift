// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ui",
    products: [
        .library(
            name: "ui-swift",
            type: .dynamic,
            targets:["ui"]
        )
    ],
    targets: [
        .systemLibrary(
            name: "clibui",
            path: "Libraries/clibui"
        ),
        .target(name: "ui", dependencies: ["clibui"])
    ]
)
