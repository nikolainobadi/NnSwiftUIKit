---
name: NnSwiftUIKit
description: NnSwiftUIKit Swift API reference for reusable SwiftUI components, error handling, async actions, font customization, and view modifiers. USE WHEN implementing SwiftUI views using NnSwiftUIKit, adding error handling with NnErrorHandlingContext, using AsyncTryButton, configuring fonts with FontSizeProvider, applying NnSwiftUIKit view modifiers, using AccessibleItemInfo, SliderStepperView, or OptionalStepper.
user-invocable: true
---

# NnSwiftUIKit

Reusable SwiftUI components, view modifiers, and utilities for error handling, async operations, custom alerts, font customization, and UI utilities.

**Dependency:** `https://github.com/nikolainobadi/NnSwiftUIKit.git` from `4.2.1`
**Platforms:** iOS 17+ | macOS 13+ | watchOS 10+ | **Swift:** 6.0

This skill lives in the package repo it documents (`Skills/NnSwiftUIKit/`), so the API and its
reference change in the same PR. Source of truth is `Sources/NnSwiftUIKit/`.

## Context Files

| File | Purpose | Load When |
|------|---------|-----------|
| `ErrorHandlingApi.md` | Error handling system, async action modifiers, alerts, accessibility types | Working with NnErrorHandlingContext, AsyncTryButton, alert modifiers, async action modifiers, AccessibleItemInfo |
| `AppearanceApi.md` | Font system, styling modifiers, gradient backgrounds, visual transforms | Configuring fonts, applying gradients, styling rows, using ToggleCheckboxStyle, unfold animations |
| `NavigationApi.md` | Navigation bar modifiers, tab item configuration, reorderable tabs (macOS), conditional view modifiers, gestures, custom views | Adding nav bar buttons, dismiss buttons, discard changes, configuring tabs with NnTabItem, drag-and-drop tab reordering on macOS, conditional rendering, SliderStepperView, OptionalStepper |

## Quick Reference

- **Error handling entry point**: Apply `.withNnErrorHandling()` at root, then use `AsyncTryButton` or async modifiers anywhere — errors auto-surface as alerts
- **Font system**: Set `.fontConfiguration()` and `.fontSizeProvider()` at root, then use `.withFont()` on text — supports dynamic sizing by screen dimensions
- **Async action modifiers**: `.throwingTask()`, `.tappable()`, `.delayedOnAppear()`, `.asyncOnSubmit()`, `.asyncHandleURL()`, `.asyncTapGesture()` all delegate to `NnErrorHandlingContext`
- **Alert modifiers**: `.singleFieldAlert()`, `.doubleFieldAlert()`, `.asyncAlert()` provide async alert flows with `AccessibleItemInfo` for button labels
- **Navigation**: `.withNavBarButton()`, `.withNavBarDismissButton()`, `.withDiscardChangesNavBarDismissButton()` compose a nav bar button chain
- **Custom views**: `SliderStepperView` for combined slider+stepper, `OptionalStepper` for optional Int binding (iOS only)
- **Tab bar**: Conform a model to `NnTabItem` and apply `.asTabItem(_:)`; on macOS, use `.reorderableTab(...)` + `TabEndDropZone` for drag-and-drop reordering

## Examples

- "Add error handling to my SwiftUI view" -> Loads `ErrorHandlingApi.md`
- "Configure custom fonts for the app" -> Loads `AppearanceApi.md`
- "Add a save button to the navigation bar" -> Loads `NavigationApi.md`
