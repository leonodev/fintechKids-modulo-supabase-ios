// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FHKSupabase",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FHKSupabase",
            targets: ["FHKSupabase"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/supabase/supabase-swift.git",
            .upToNextMajor(from: "2.5.1")),
        
        .package(url: "https://github.com/leonodev/fintechKids-modulo-utils-ios.git",
            branch: "main"),
        
        .package(url: "https://github.com/leonodev/fintechKids-modulo-domain-ios.git",
            branch: "main")
    ],
    targets: [
        .target(
            name: "FHKSupabase",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift"),
                // Modules FHK
                .product(name: "FHKUtils", package: "fintechKids-modulo-utils-ios"),
                .product(name: "FHKDomain", package: "fintechKids-modulo-domain-ios")
            ]
        ),
        .testTarget(
            name: "FHKSupabaseTests",
            dependencies: ["FHKSupabase"]
        ),
    ]
)
