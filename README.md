# OverFullScreenSheet
`OverFullScreenSheet` is a SwiftUI way to show cotnent over current context.
## Installation
[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build SnapKit using Swift Package Manager.

To integrate `OverFullScreenSheet` into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/anisim101/OverFullScreenSheet")
]
```
## Quick Start
Use `OverFullScreenSheet` like [.sheet(item)](https://developer.apple.com/documentation/swiftui/view/sheet(item:ondismiss:content:)/), [.sheet(isPresented)](https://developer.apple.com/documentation/swiftui/view/sheet(item:ondismiss:content:)/).
```swift
.overFullScreenSheet(item: selectedItem) { item in
       ZStack {
        Color.black
            .opacity(0.3)
        Text(item)
    }
}
```
```swift
.overFullScreenSheet(item: selectedItem) { item in
       ZStack {
        Color.black
            .opacity(0.3)
        Text(item)
    }
}
```
