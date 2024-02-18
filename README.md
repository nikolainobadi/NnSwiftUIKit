
# NnSwiftUIKit

NnSwiftUIKit is a dynamic library for iOS, providing a collection of SwiftUI views, modifiers, and utilities designed to make UI development more efficient and error handling smoother. This package leverages Swift 5.7 and supports iOS 14.0 and above.

## Features

- **Error Handling**: Easily manage UI alerts and error messages with `NnErrorAlert`, `NnSwiftUIErrorHandler`, and more.
- **Async Actions**: Integrate asynchronous actions within your SwiftUI views with `NnAsyncTryButton` and `NnTryButton`.
- **Loading State Management**: Utilize `NnLoadingHandler` to manage loading states across your UI components.
- **View Modifiers**: A suite of view modifiers for common tasks, such as handling onAppear asynchronously, managing text field alerts, and more.

## Installation

To install NnSwiftUIKit, add it to the dependencies of your package in your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/YourGitHub/NnSwiftUIKit.git", from: "0.8.0")
    ],
    ...
    targets: [
        .target(
            name: "YourTarget",
            dependencies: ["NnSwiftUIKit"]
        ),
        ...
    ]
)
```

## Usage

Here's how you can use NnSwiftUIKit components in your SwiftUI application:

### Error Handling

Implement `NnDisplayableError` in your error types to customize error alerts:

```swift
struct MyError: NnDisplayableError {
    var title: String = "Error Title"
    var message: String = "Error message."
}
```

### Async Button

Use `NnAsyncTryButton` to handle asynchronous actions with loading and error handling:

```swift
NnAsyncTryButton(action: {
    // Perform async action
    // will require loading & errorHandling view modifers (see 'Custom View Modifiers' in next section)
}, label: {
    Text("Tap Me")
})
```

### Custom View Modifiers

Apply `NnWithNnLoadingView` and `NnWithNnErrorHandling` to your views to automatically handle loading and error states.

```swift
MyView()
.nnWithNnLoadingView()
.nnWithNnErrorHandling()
```

## License

NnSwiftUIKit is available under the MIT license. See the LICENSE file for more info.
