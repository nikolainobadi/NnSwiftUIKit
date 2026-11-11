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

### Font Customization System
The font system provides flexible, protocol-based font sizing with environment-level configuration:

1. **FontSizeProvider Protocol** (`Sources/NnSwiftUIKit/Environment/FontSizeProvider.swift`)
   - Protocol defining font size calculation logic based on screen dimensions
   - `makeFont(_:fontName:screenSize:)` creates fonts with proper sizing
   - `makeFontSize(_:screenSize:)` calculates appropriate size for text styles
   - `DefaultFontSizeProvider` uses percentage-based calculations relative to screen height

2. **FontConfiguration** (`Sources/NnSwiftUIKit/Environment/FontConfiguration.swift`)
   - Configurable defaults for text color and font names
   - Properties: `textColor`, `detailFontName`, `nonDetailFontName`
   - Can be set via environment to apply app-wide defaults
   - Individual modifiers can override on per-use basis

3. **CustomFontModifier** (`Sources/NnSwiftUIKit/ViewModifiers/Designs/CustomFontViewModifier.swift`)
   - Unified modifier supporting both dynamic (style-based) and explicit (size-based) fonts
   - Reads `FontSizeProvider` and `FontConfiguration` from environment
   - Supports optional line limits with automatic text scaling via `minimumScaleFactor`
   - All parameters optional - falls back to environment defaults when not specified

**Integration Pattern:**
```swift
// Set app-wide defaults
ContentView()
    .fontConfiguration(FontConfiguration(
        textColor: .blue,
        detailFontName: "CustomDetail",
        nonDetailFontName: "CustomBold"
    ))
    .fontSizeProvider(MyCustomProvider())

// Use defaults or override per-use
Text("Hello").withFont(.headline)  // Uses environment defaults
Text("World").withFont(.body, textColor: .red)  // Override color only
```

### Directory Structure

```
Sources/NnSwiftUIKit/
├── Accessibility/           # AccessibleItemInfo, AccessibleLabelInfo
├── Environment/             # Custom environment keys and protocols
│   ├── FontSizeProvider     # Protocol for custom font sizing logic
│   ├── FontConfiguration    # Default font appearance configuration
│   └── Other keys           # IsPreviewKey, RowItemTint, NavBarTextColor, etc.
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
Swift source files omit file header comments.

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

## The NnSwiftUIKit Skill

The published API reference skill lives in this repo, at `Skills/NnSwiftUIKit/`. It used to live in
`~/NobadiScripts/NnSkills/` — that path is dead, do not look for it there.

It sits here so that **the API and its documentation change in the same PR.** When they lived in
separate repos they drifted apart for months at a time: the skill went on describing an API that had
since been renamed, and nothing anywhere reported it.

### The rule

**A PR that changes the public API must also touch `Skills/`.** There is no CI workflow
enforcing this rule. If a PR changes what a documented modifier *does*, update `Skills/`
as well, including behavior changes inside a public function body.

### `plugin.json` deliberately has no `version`

`Skills/NnSwiftUIKit/.claude-plugin/plugin.json` intentionally carries **no `version` field.** The
marketplace installs this skill from a git source and keys its cache by commit sha, so a
hand-typed version number is a second thing to remember and the exact stale-number problem this
arrangement exists to remove. Do not reintroduce it. The pinned `ref` in the marketplace manifest is
the real version marker and must be updated in the marketplace manifest for each release.

## Releasing

The skill is published through the **`nn-swift-skills`** marketplace
(`nikolainobadi/nn-swift-skills`), whose entry uses a `git-subdir` source pinned to a **release
tag** of this repo.

Because it is pinned, **doc changes ship on release, not on merge.** Merging a correction to
`Skills/` changes nothing for anyone reading the skill until the next tag. That surprises people —
it is the intended trade (docs always match a shipped version), not a bug.

Updating the entry's `ref` in the marketplace manifest is a manual cross-repo release step.
There is no tag-triggered bump workflow in this repo. Until the marketplace ref is updated,
consumers continue to receive the previously pinned release's documentation.

Release preparation is configured in `.nnex/nnex.json`: the `NnSwiftUIKit` library target
uses the repository root (`.`) and includes `Skills/NnSwiftUIKit` as its reference skill.
