// swift-tools-version: 6.0
//
//  Package.swift
//
//  Copyright (c) 2024 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import PackageDescription

let package = Package(name: "Alamofire",
                      platforms: [.macOS(.v10_13),
                                  .iOS(.v12),
                                  .tvOS(.v12),
                                  .watchOS(.v4)],
                      products: [
                          .library(name: "MyAlamofireHidden", targets: ["MyAlamofireHidden"]),
                          .library(name: "AlamofireDynamic", type: .dynamic, targets: ["MyAlamofireHidden"])
                      ],
                      targets: [.target(name: "MyAlamofireHidden",
                                        path: "Source",
                                        exclude: ["Info.plist"],
                                        resources: [.process("PrivacyInfo.xcprivacy")],
                                        swiftSettings: [.enableUpcomingFeature("ExistentialAny")],
                                        linkerSettings: [.linkedFramework("CFNetwork",
                                                                          .when(platforms: [.iOS,
                                                                                            .macOS,
                                                                                            .tvOS,
                                                                                            .watchOS]))]),
                                .testTarget(name: "AlamofireTests",
                                            dependencies: ["MyAlamofireHidden"],
                                            path: "Tests",
                                            exclude: ["Info.plist", "Test Plans"],
                                            resources: [.process("Resources")])],
                      swiftLanguageModes: [.v5])
