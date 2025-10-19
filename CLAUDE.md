# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NnSwiftUIKit is a Swift Package offering reusable SwiftUI components, view modifiers, and utilities for iOS (17+) and macOS (13+). The package focuses on error handling, async operations, custom alerts, and UI utilities.

## Building and Testing

### Build Commands
```bash
# Build the package
swift build

# Build for release
swift build -c release

# Clean build artifacts
swift package clean
```

### Opening in Xcode
The package can be opened in Xcode using:
```bash
open .swiftpm/xcode/package.xcworkspace
```

## Architecture

### Core Error Handling System
The error handling architecture is built around three interconnected components:

1. **NnErrorHandlingContext** (`Sources/NnSwiftUIKit/ErrorHandling/NnErrorHandlingContext.swift`)
   - `@MainActor` observable object managing global error/loading state
   - Published properties: `isLoading`, `showingAlert`, `currentAlert`
   - Core method: `performAction(hideLoadingIndicator:action:)` wraps async throwing actions
   - Automatically converts thrown errors into `NnErrorAlert` instances

2. **AsyncTryButton** (`Sources/NnSwiftUIKit/ErrorHandling/AsyncTryButton.swift`)
   - SwiftUI button that expects `@EnvironmentObject` of type `NnErrorHandlingContext`
   - Delegates error handling and loading states to the context
   - Supports `hideLoadingIndicator` parameter to suppress spinner

3. **NnDisplayableError Protocol** (`Sources/NnSwiftUIKit/ErrorHandling/NnDisplayableError.swift`)
   - Errors conforming to this protocol provide `title` and `message` for alert display
   - `NnErrorAlert` automatically wraps any thrown error into displayable format

**Integration Pattern:**
- Apply `.withNnErrorHandling()` modifier at app/screen root level
- This injects `NnErrorHandlingContext` into the environment and overlays loading/alert UI
- Use `AsyncTryButton` anywhere in the hierarchy—it automatically accesses the context

### Directory Structure

```
Sources/NnSwiftUIKit/
├── Accessibility/           # AccessibleItemInfo, AccessibleLabelInfo
├── Environment/             # Custom environment keys (e.g., IsPreviewKey)
├── ErrorHandling/           # Core error/loading system (see above)
├── Extensions/
│   ├── Core/               # Array, Date, String extensions
│   ├── SwiftUI/            # View, Image extensions (screen dimensions, percentages)
│   └── UIKit/              # UIApplication, UIAlertController extensions
├── Helpers/                # Utility classes (e.g., NnAppVersionCache)
├── Showcase/               # Feature showcase system (mostly commented out)
│   ├── Model/
│   └── ViewModifiers/
├── ViewModifiers/
│   ├── Alerts/             # Alert-related modifiers (field alerts, async alerts, etc.)
│   ├── Animations/         # Animation modifiers (e.g., UnfoldAnimation)
│   ├── Conditionals/       # Conditional rendering/styling modifiers
│   ├── Designs/            # Styling modifiers (gradients, fonts, etc.)
│   ├── ErrorHandling/      # NnErrorHandlingContextModifier
│   ├── Navigation/         # Nav bar buttons, sheets, discard changes, etc.
│   └── Utility/            # Gesture handlers, async actions, accessibility, etc.
└── Views/                  # Custom SwiftUI views (NavStack, OptionalStepper)
```

### View Modifier Naming Convention

All public view modifiers follow a consistent pattern:
- **Internal struct**: `[Feature]ViewModifier` (e.g., `FieldAlertViewModifier`)
- **Public extension method**: Descriptive name without "nn" prefix by default
  - Example: `.singleFieldAlert(...)`, `.withNnErrorHandling(...)`
- The README mentions users can wrap these in their own extensions with "nn" prefix if desired

### Platform-Specific Code

Code uses conditional compilation for iOS/macOS:
```swift
#if canImport(UIKit)
// iOS-specific code
#elseif canImport(AppKit)
// macOS-specific code
#endif
```

Example: `View+Extensions.swift` provides `screenWidth`/`screenHeight` using `UIScreen` (iOS) or `NSScreen` (macOS).

## Code Standards

### File Headers
All Swift files include a header with:
```swift
//
//  FileName.swift
//  NnSwiftUIKit
//
//  Created by Nikolai Nobadi on [date]
//
```

### Access Control
- Public API uses `public` explicitly
- Internal types default to `internal` (no keyword)
- Extensions organizing private helpers use `private extension`

### Documentation
Public APIs include doc comments with:
- Brief description
- Parameter documentation
- Returns clause when applicable
- Usage examples in README.md

## Key Implementation Patterns

### ViewModifier Structure
Standard pattern for creating reusable view modifiers:

1. Create internal struct conforming to `ViewModifier`
2. Add `body(content:)` implementation
3. Provide public `View` extension with convenient method
4. Document parameters and behavior

### Async Error Handling
When creating async action modifiers:
- Accept `hideLoadingIndicator: Bool = false` parameter
- Use `@EnvironmentObject` to access `NnErrorHandlingContext` when applicable
- Let context handle error presentation via `performAction`

### Accessibility Support
Many components use `AccessibleItemInfo` for consistent accessibility:
- `prompt`: User-facing text
- `accessibilityId`: Optional identifier for UI testing
- Helper: `.setOptionalAccessibiltyId(_:)` applies ID only if non-nil
