// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PhotoEditorIos",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "PhotoEditorIos",
            targets: ["PhotoEditorPluginPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "PhotoEditorPluginPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/PhotoEditorPluginPlugin"),
        .testTarget(
            name: "PhotoEditorPluginPluginTests",
            dependencies: ["PhotoEditorPluginPlugin"],
            path: "ios/Tests/PhotoEditorPluginPluginTests")
    ]
)