
# NnSwiftUIKit

![Swift](https://badgen.net/badge/swift/6.0%2B/purple)
![Platform](https://badgen.net/badge/platform/iOS%2017+%20%7C%20macOS%2013+%20%7C%20watchOS%2010+/blue)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

NnSwiftUIKit is a comprehensive Swift package offering reusable SwiftUI components, view modifiers, and utilities for iOS (17+), macOS (13+), and watchOS (10+). The package focuses on error handling, async operations, custom alerts, font customization, and UI utilities designed to enhance your SwiftUI development experience.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Error Handling & Loading States](#error-handling--loading-states)
  - [Custom Alerts](#custom-alerts)
  - [Custom View Modifiers](#custom-view-modifiers)
  - [Navigation & Toolbar](#navigation--toolbar)
  - [List & Row Utilities](#list--row-utilities)
  - [Async Task Helpers](#async-task-helpers)
- [License](#license)

## Features
- **Error Handling & Loading States**:
  - **NnErrorHandlingContext**: A centralized context managing both error presentation and loading states.
  - **AsyncTryButton**: A button that seamlessly handles async throwing actions with automatic error handling, loading indicators, and optional haptic feedback.
  - **NnErrorAlert**: A simple alert structure that helps you present errors consistently.
  - **NnDisplayableError Protocol**: Conform errors to this protocol to provide custom titles and messages for alerts.
  - **Integrated Loading UI**: Automatic loading spinner with dimmed background during async operations.
  - **Custom Alerts**: Easily create custom alert dialogues with `AsyncConfirmationDialogueViewModifier`, `FieldAlertViewModifier`, and more.

- **Font Customization System**:
  - **NnTextLayout Enum**: Unified text layout control (unlimited, multiline with auto-sizing, or single-line auto-size).
  - **FontSizeProvider Protocol**: Define custom font sizing logic based on screen dimensions, with watchOS-specific optimizations.
  - **FontConfiguration**: Set app-wide defaults for text colors and font names via environment.
  - **Flexible Font Modifiers**: Apply fonts with style-based or explicit sizing, with per-use overrides.
  - **Auto-sizing Support**: Automatic text scaling with configurable line limits and minimum scale factors via `NnTextLayout`.

- **Custom View Modifiers**:
  - **Async and Error Handling**: Handle on-appear actions, form submissions, and URL openings asynchronously with built-in error management.
  - **Styling Modifiers**: Modify your views with custom fonts, gradients, conditional layouts, and consistent disabled button states.
  - **List Utilities**: Empty state messages for lists, swipe-to-delete actions, and interactive row items.
  - **Navigation Enhancements**: Custom view navigation bar buttons, discard changes confirmations, and flexible toolbar button placement.

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
.package(url: "https://github.com/nikolainobadi/NnSwiftUIKit.git", from: "4.0.0")
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

Now use `AsyncTryButton` anywhere in your view hierarchy to perform async throwing actions. Errors are automatically caught and displayed, a loading indicator appears during execution, and you can optionally trigger haptic feedback when the button is tapped:

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

// Trigger haptic feedback before the async action begins
AsyncTryButton(
    action: { try await archiveItem() },
    hapticFeedback: .impact(style: .medium)  // Available: .selection, .impact(style:), .notification(type:)
) {
    Text("Archive")
}

// Using notification-style haptics for success/error feedback
AsyncTryButton(
    action: { try await saveImportantData() },
    hapticFeedback: .notification(type: .success)
) {
    Text("Save")
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

#### Disable Button Styling
Apply consistent disabled state styling to buttons:

```swift
Button("Submit") {
    submitForm()
}
.disableButton(isDisabled: !isFormValid, disabledOpacity: 0.5)

// With custom opacity
Button("Continue") {
    proceed()
}
.disableButton(isDisabled: !canProceed, disabledOpacity: 0.3)
```

#### Custom Font Application
Apply custom fonts with flexible sizing and appearance options using the unified `NnTextLayout` enum:

```swift
// Basic usage with style-based sizing (unlimited lines by default)
Text("Hello")
    .withFont(.headline, textColor: .blue)

// Specify detail vs non-detail fonts
Text("Title")
    .withFont(.title, isDetail: false)  // Uses bold font

Text("Subtitle")
    .withFont(.caption, isDetail: true)  // Uses detail font

// Multi-line text with auto-sizing using NnTextLayout
Text("Long text that might wrap")
    .withFont(.body, layout: .multiline(2))  // 2 lines with auto-scaling

// Single line with auto-sizing
Text("This will shrink to fit")
    .withFont(.headline, layout: .singleLineAutoSize)

// Unlimited lines (default behavior)
Text("This can be as many lines as needed")
    .withFont(.body, layout: .unlimited)

// Explicit font and size
Text("Custom")
    .setCustomFont(fontName: "Helvetica", size: 18, layout: .multiline(3))

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

### Navigation & Toolbar
Add navigation bar buttons and handle dismissal with change detection:

```swift
// Add a navigation bar button
MyView()
    .withNavBarButton(
        placement: .trailing,
        buttonContent: .text("Save"),
        textColor: .blue,
        action: {
            try await saveChanges()
        }
    )

// Add a dismiss button with discard changes confirmation
struct EditView: View {
    @State private var item = Item()
    let originalItem: Item

    var body: some View {
        Form {
            // ... editing fields
        }
        .withDiscardChangesNavBarDismissButton(
            "Discard Changes?",
            message: "You have unsaved changes. Are you sure you want to discard them?",
            itemToModify: item,
            placement: .leading,
            dismissType: .cancel
        )
    }
}

// Using button content with images
MyView()
    .withNavBarButton(
        placement: .topBarTrailing,
        buttonContent: .image(.system("plus")),
        action: {
            try await addNewItem()
        }
    )

// Add custom views to navigation bar (e.g., complex button layouts, badges)
MyView()
    .withCustomViewNavBarButton(placement: .topBarTrailing) {
        HStack {
            Image(systemName: "bell")
            if hasNotifications {
                Circle()
                    .fill(.red)
                    .frame(width: 8, height: 8)
            }
        }
    } action: {
        try await openNotifications()
    }
```

### List & Row Utilities
Create interactive list rows with tappable actions, swipe-to-delete, and empty state handling:

```swift
// Display empty state message when list is empty
List {
    ForEach(items) { item in
        ItemRow(item: item)
    }
}
.emptyListMessage("No items found", isEmpty: items.isEmpty)

// Basic row item with chevron
Text("Settings")
    .asRowItem(
        withChevron: true,
        maxWidth: .infinity,
        alignment: .leading,
        tint: .blue
    )

// Tappable row with async action
Text("Account Details")
    .tappable(
        tapIsActive: true,
        withChevron: true,
        tint: .blue,
        onTapGesture: {
            try await loadAccountDetails()
        }
    )

// Swipe to delete with confirmation
ForEach(items) { item in
    ItemRow(item: item)
        .withSwipeDelete(
            message: "Delete this item?",
            swipeButtonTint: .red,
            swipeButtonRole: .destructive,
            delete: {
                try await deleteItem(item)
            }
        )
}

// Skip confirmation for immediate delete
ItemRow(item: item)
    .withSwipeDelete(
        skipConfirmation: true,
        delete: {
            try await deleteItem(item)
        }
    )
```

### Async Task Helpers
Execute async tasks on view lifecycle events:

```swift
// Run async task when view appears
MyView()
    .throwingTask {
        try await loadInitialData()
    }

// Run task only once (persists across view reappears)
MyView()
    .throwingTask(onlyPerformOnce: true) {
        try await performOneTimeSetup()
    }

// Hide loading indicator during task
MyView()
    .throwingTask(hideLoadingIndicator: true) {
        try await refreshData()
    }

// Async action on value change
MyView()
    .asyncOnChange(of: selectedCategory) {
        try await loadItemsForCategory(selectedCategory)
    }

// Async form submission
Form {
    // ... form fields
}
.asyncTryOnSubmit {
    try await submitForm()
}
```

## License
NnSwiftUIKit is available under the MIT license. See the LICENSE file for more info.
