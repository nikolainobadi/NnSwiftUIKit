
# NnSwiftUIKit

![Swift](https://badgen.net/badge/swift/6.0%2B/purple)
![Platform](https://badgen.net/badge/platform/iOS%2017+%20%7C%20macOS%2013+/blue)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

NnSwiftUIKit is a comprehensive Swift package offering reusable SwiftUI components, view modifiers, and utilities for iOS (17+) and macOS (13+). The package focuses on error handling, async operations, custom alerts, font customization, and UI utilities designed to enhance your SwiftUI development experience.

Included in the Reference folder is a commented out file (NnSwiftUIKit+ViewExtensions) that contains references to all NnSwiftUIKit view modifiers without the 'nn' prefix. In my own code, I always prefer to wrap third-party libraries in my own local code. That file is a convenient way to isolate NnSwiftUIKit to a single import.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Error Handling & Loading States](#error-handling--loading-states)
  - [Custom Alerts](#custom-alerts)
  - [Custom View Modifiers](#custom-view-modifiers)
- [License](#license)

## Features
- **Error Handling & Loading States**:
  - **NnErrorHandlingContext**: A centralized context managing both error presentation and loading states.
  - **AsyncTryButton**: A button that seamlessly handles async throwing actions with automatic error handling and loading indicators.
  - **NnErrorAlert**: A simple alert structure that helps you present errors consistently.
  - **NnDisplayableError Protocol**: Conform errors to this protocol to provide custom titles and messages for alerts.
  - **Integrated Loading UI**: Automatic loading spinner with dimmed background during async operations.
  - **Custom Alerts**: Easily create custom alert dialogues with `AsyncConfirmationDialogueViewModifier`, `FieldAlertViewModifier`, and more.

- **Font Customization System**:
  - **FontSizeProvider Protocol**: Define custom font sizing logic based on screen dimensions.
  - **FontConfiguration**: Set app-wide defaults for text colors and font names via environment.
  - **Flexible Font Modifiers**: Apply fonts with style-based or explicit sizing, with per-use overrides.
  - **Auto-sizing Support**: Automatic text scaling with configurable line limits and minimum scale factors.

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
.package(url: "https://github.com/nikolainobadi/NnSwiftUIKit.git", from: "3.0.0")
```

## Usage
NnSwiftUIKit provides a robust toolkit for enhancing your SwiftUI apps. Below are examples of how to leverage some of its key components.


### Error Handling & Loading States
Easily handle error presentation and loading states with `AsyncTryButton` and `NnErrorHandlingContext`.

First, implement `NnDisplayableError` in your custom error types for better error messages:

```swift
struct MyError: NnDisplayableError {
    var title: String = "Error Title"
    var message: String = "Error message."
}
```

Then, add the error handling context to your view hierarchy (typically at the app or screen level):

```swift
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withNnErrorHandling(
                    accentColor: .white,      // Optional: loading spinner color
                    alertButtonText: "Okay"   // Optional: alert button text
                )
        }
    }
}
```

Now use `AsyncTryButton` anywhere in your view hierarchy to perform async throwing actions. Errors are automatically caught and displayed, and a loading indicator appears during execution:

```swift
AsyncTryButton(action: {
    try await someAsyncFunction()
}) {
    Text("Tap Me")
}

// With role and hide loading indicator option
AsyncTryButton(
    action: { try await deleteItem() },
    role: .destructive,
    hideLoadingIndicator: true  // Suppress loading spinner
) {
    Text("Delete")
}
```

The `NnErrorHandlingContext` is automatically injected via environment and manages:
- Loading state with full-screen dimmed overlay and spinner
- Error presentation via native SwiftUI alerts
- Automatic error conversion from any thrown error to `NnErrorAlert`

### Custom Alerts
Create alerts with fields or confirmations using provided view modifiers:

#### Double Field Alert
```swift
@State private var isAlertPresented = false

MyView()
    .doubleFieldAlert(
        "Enter your credentials",
        isPresented: $isAlertPresented,
        firstFieldInfo: .init(prompt: "Username"),
        secondFieldInfo: .init(prompt: "Password"),
        action: { username, password in
            // Handle inputs
        }
    )
```

#### Confirmation Alert
```swift
@State private var isConfirmPresented = false

MyView()
    .asyncConfirmation(
        showingConfirmation: $isConfirmPresented,
        role: .destructive,
        buttonInfo: AccessibleItemInfo(prompt: "Delete"),
        message: "Are you sure you want to delete this?",
        action: {
            // Handle deletion
        }
    )
```

### Custom View Modifiers
#### Apply Gradient Background
```swift
MyView()
    .linearGradientBackground(
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom),
        opacity: 0.8
    )
```

#### Custom Font Application
Apply custom fonts with flexible sizing and appearance options:

```swift
// Basic usage with style-based sizing
Text("Hello")
    .withFont(.headline, textColor: .blue)

// Specify detail vs non-detail fonts
Text("Title")
    .withFont(.title, isDetail: false)  // Uses bold font

Text("Subtitle")
    .withFont(.caption, isDetail: true)  // Uses detail font

// With auto-sizing for multiple lines
Text("Long text that might wrap")
    .withFont(.body, autoSizeLineLimit: 2)

// Explicit font and size
Text("Custom")
    .setCustomFont(fontName: "Helvetica", size: 18)

// Set app-wide defaults via environment
ContentView()
    .fontConfiguration(FontConfiguration(
        textColor: .primary,
        detailFontName: "HelveticaNeue",
        nonDetailFontName: "HelveticaNeue-Bold"
    ))

// Custom font sizing logic
struct MyProvider: FontSizeProvider {
    func makeFontSize(_ style: Font.TextStyle, screenSize: CGSize) -> CGFloat {
        // Your custom logic here
        return screenSize.width * 0.05
    }
}

ContentView()
    .fontSizeProvider(MyProvider())
```

#### Device Shake Gesture
```swift
MyView()
    .onDeviceShake(
        isActive: true,
        action: {
            print("Device shaken!")
        }
    )
```

## License
NnSwiftUIKit is available under the MIT license. See the LICENSE file for more info.
