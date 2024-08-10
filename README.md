
# NnSwiftUIKit

NnSwiftUIKit is a dynamic library for iOS that offers a powerful collection of SwiftUI views, modifiers, and utility components designed to enhance your UI development experience. This library simplifies the management of error handling, asynchronous actions, loading states, and much more. NnSwiftUIKit is built with Swift 5.7 and supports iOS 14.0 and above, making it a versatile addition to any SwiftUI project.

Included in the Reference folder is a commented out file (NnSwiftUIKit+ViewExtensions) that contains references to all NnSwiftUIKit view modifiers (as well as the two error-handling buttons) without the 'nn' suffix. In my own code, I always prefer to wrap third-party libraries in my own local code. That file is a convenient way to isolate NnSwiftUIKit to a single import.

## Features
- **Error Handling**:
  - **NnErrorAlert**: A simple alert structure that helps you present errors consistently.
  - **NnSwiftUIErrorHandler**: A view model to handle and present errors across your app's views.
  - **Custom Alerts**: Easily create custom alert dialogues with `AsyncConfirmationDialogueViewModifier`, `FieldAlertViewModifier`, and more.

- **Asynchronous Actions**:
  - **NnAsyncTryButton**: A button that seamlessly handles async actions, showing loading indicators and managing errors.
  - **NnTryButton**: A synchronous counterpart to `NnAsyncTryButton` for regular actions.

- **Loading State Management**:
  - **NnLoadingHandler**: A centralized loading state manager, allowing easy integration of loading indicators across multiple views.
  - **Loading View Modifiers**: Apply loading indicators to your views with `LoadingViewModifier` and related utilities.

- **Custom View Modifiers**:
  - **Async and Error Handling**: Handle on-appear actions, form submissions, and URL openings asynchronously with built-in error management.
  - **Styling Modifiers**: Modify your views with custom fonts, gradients, and conditional layouts.

- **Utility Extensions**:
  - **String+Extensions**: String utilities like trimming extra whitespace and adding line breaks.
  - **Date+Extensions**: Simplified date creation.
  - **UIViewController+Extensions**: Retrieve the top-most view controller for presenting alerts.
  - **UIApplication+Extensions**: Find the top-most view controller from the app's root.

- **Gesture Handling**:
  - **DeviceShakeViewModifier**: Trigger actions on device shake events.
  - **PanGestureViewModifier**: Handle vertical pan gestures with custom actions.

## Installation

### Swift Packages
To integrate `NnSwiftUIKit` into your project, add it to your dependencies in your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/nikolainobadi/NnSwiftUIKit.git", from: "0.8.0")
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

Note: As this is a dynamic library, it will embedded in the Xcode project

## Usage
NnSwiftUIKit provides a robust toolkit for enhancing your SwiftUI apps. Below are examples of how to leverage some of its key components.

### Error Handling

Implement `NnDisplayableError` in your custom error types to take full advantage of NnSwiftUIKit's error handling capabilities:

```swift
struct MyError: NnDisplayableError {
    var title: String = "Error Title"
    var message: String = "Error message."
}
```

Then, use `NnSwiftUIErrorHandler` to manage error states across your app's views:

```swift
@StateObject private var errorHandler = NnSwiftUIErrorHandler()

MyView()
    .environmentObject(errorHandler)
    .nnWithNnErrorHandling()
```

### Asynchronous Buttons

Use `NnAsyncTryButton` to perform actions that require async operations:

```swift
NnAsyncTryButton(action: {
    // Perform async action
    // Example: try await someAsyncFunction()
}, label: {
    Text("Tap Me")
})
```

For synchronous actions, use `NnTryButton`:

```swift
NnTryButton(action: {
    // Perform sync action
}, label: {
    Text("Tap Me")
})
```

### Loading States

Manage loading states across your views with `NnLoadingHandler`:

```swift
@StateObject private var loadingHandler = NnLoadingHandler()

MyView()
    .environmentObject(loadingHandler)
    .nnWithNnLoadingView()
```

### Custom Alerts

Create alerts with fields or confirmations using provided view modifiers:

#### Double Field Alert
```swift
@State private var isAlertPresented = false

MyView()
    .modifier(DoubleFieldAlertViewModifier(
        isPresented: $isAlertPresented,
        message: "Enter your credentials",
        firstFieldInfo: .init(prompt: "Username"),
        secondFieldInfo: .init(prompt: "Password"),
        action: { username, password in
            // Handle inputs
        }
    ))
```

#### Confirmation Alert
```swift
@State private var isConfirmPresented = false

MyView()
    .modifier(AsyncConfirmationDialogueViewModifier(
        showingConfirmation: $isConfirmPresented,
        role: .destructive,
        buttonInfo: AccessibleItemInfo(prompt: "Delete"),
        message: "Are you sure you want to delete this?",
        action: {
            // Handle deletion
        }
    ))
```

### Custom View Modifiers

#### Apply Gradient Background
```swift
MyView()
    .modifier(GradientBackgroundViewModifier(
        gradient: LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom),
        opacity: 0.8
    ))
```

#### Custom Font Application
```swift
MyView()
    .modifier(CustomFontViewModifier(
        font: .custom("YourFontName", size: 18),
        textColor: .primary,
        autoSize: true
    ))
```

#### Device Shake Gesture
```swift
MyView()
    .modifier(DeviceShakeViewModifier(
        isActive: true,
        action: {
            print("Device shaken!")
        }
    ))
```

## License
NnSwiftUIKit is available under the MIT license. See the LICENSE file for more info.
