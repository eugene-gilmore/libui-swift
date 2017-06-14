import PackageDescription

let package = Package(
    name: "ui",
    dependencies: [
        .Package(url: "https://github.com/eugene-gilmore/clibui.git", majorVersion:1),
    ]
)
