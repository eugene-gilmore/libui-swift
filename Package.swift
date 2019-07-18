// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ui",
    targets: [
        .systemLibrary(
            name: "clibui",
            path: "Libraries/clibui"
        ),
        .target(name: "libui-swift", dependencies: ["clibui"])
    ]
)
