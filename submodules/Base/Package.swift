// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Base",
	defaultLocalization: "en",
	platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Base",
            targets: ["Base"]),
		
    ],
    dependencies: [
		.package(url: "https://github.com/pkluz/PKHUD.git", .upToNextMinor(from: "5.4.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Base",
            dependencies: ["PKHUD"],
			resources: [.process("Resources/Assets"), .process("Resources/Localization")]
		),
        .testTarget(
            name: "BaseTests",
            dependencies: ["Base"]),
    ]
)
