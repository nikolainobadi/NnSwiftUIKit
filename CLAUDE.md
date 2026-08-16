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

## The NnSwiftUIKit Skill

The published API reference skill lives in this repo, at `Skills/NnSwiftUIKit/`. It used to live in
`~/NobadiScripts/NnSkills/` — that path is dead, do not look for it there.

It sits here so that **the API and its documentation change in the same PR.** When they lived in
separate repos they drifted apart for months at a time: the skill went on describing an API that had
since been renamed, and nothing anywhere reported it.

### The rule

**A PR that changes the public API must also touch `Skills/`.** `.github/workflows/skill-docs.yml`
enforces it: it counts added/removed `public`/`open`/`package` declaration lines under
`Sources/**/*.swift` and fails the PR if `Skills/` is untouched. Add the `skip-skill-check` label
when the PR genuinely changes no documented behavior — a rename, a reformat, a file move.

**The check has a real blind spot.** It only sees *declaration* lines. A behavior change inside a
public function body is invisible to it — the 4.2.1 watchOS keyboard-shortcut guard scored `api: 0`
and would have passed while making the skill wrong. Treat the check as a floor, not a guarantee: if
a PR changes what a documented modifier *does*, update `Skills/` whether or not CI insists.

### `plugin.json` deliberately has no `version`

`Skills/NnSwiftUIKit/.claude-plugin/plugin.json` intentionally carries **no `version` field.** The
marketplace installs this skill from a git source and keys its cache by commit sha, so a
hand-typed version number is a second thing to remember and the exact stale-number problem this
arrangement exists to remove. Do not reintroduce it. The pinned `ref` in the marketplace manifest is
the real version marker, and that one is bumped automatically.

## Releasing

The skill is published through the **`nn-swift-skills`** marketplace
(`nikolainobadi/nn-swift-skills`), whose entry uses a `git-subdir` source pinned to a **release
tag** of this repo.

Because it is pinned, **doc changes ship on release, not on merge.** Merging a correction to
`Skills/` changes nothing for anyone reading the skill until the next tag. That surprises people —
it is the intended trade (docs always match a shipped version), not a bug.

`.github/workflows/skill-ref-bump.yml` handles the bump: on any tag push it rewrites the entry's
`ref` in the marketplace manifest and opens a PR there. It can also be run manually with
`gh workflow run skill-ref-bump.yml -f tag=<tag>`.

**If that automation is ever removed, the bump becomes a manual cross-repo step**, and the failure
mode is silent: the marketplace keeps serving the previously pinned release's documentation
forever. Nothing errors and nothing warns — consumers simply read old docs.

### The `MARKETPLACE_TOKEN` secret

The bump workflow authenticates with the repo secret `MARKETPLACE_TOKEN` — a **fine-grained PAT
named `nn-swift-skills-ref-bump`**, granting `contents:write` and `pull-requests:write` on
`nikolainobadi/nn-swift-skills` and nothing else.

- It is **shared across every package repo** publishing to `nn-swift-skills` (SwiftPickerKit,
  NnArgumentParser, NnTestKit, this one). The grant is identical in each, so a per-repo token would
  buy no isolation and cost another expiry to track.
- **Expiry:** _record the expiry date here when the token is next rotated._ When it lapses, the bump
  fails in **every** repo holding it — so a failed run reads as "rotate the shared token", not "this
  repo's workflow is broken." Rotation means re-running `set-marketplace-token.sh` against every
  package repo.
- GitHub secrets are **write-only.** The value cannot be read back from a repo that already has it;
  adding a new repo needs the saved token file.
