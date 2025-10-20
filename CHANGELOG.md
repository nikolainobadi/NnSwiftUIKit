# Changelog

All notable changes to NnSwiftUIKit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2025-10-20
### Added
- Font customization system with FontSizeProvider protocol for dynamic font sizing
- FontConfiguration environment key for customizable font appearance defaults
- Environment keys for default colors: NavBarTextColor, RowItemTint, ShowingAlertButtonInfo
- UnfoldAnimation view modifier for animated content reveals
- ThrowingTask view modifier for async error handling
- OptionalStepper component for optional numeric value adjustments
- ActiveOnChanges navigation bar button modifier for state-driven navigation
- BindedNavigationDestination modifier for binding-based navigation
- ShowErrorAlert view modifier for displaying error messages
- AsyncConfirmationDialogue, AsyncOpenURL, and AsyncTryOnSubmit utility modifiers
- AccessibleLabelInfo helper for accessibility support

### Changed
- Refactored CustomFontModifier to use environment-based font configuration system
- Reorganized view modifiers into more logical directory structure
- Improved parameter formatting and inline documentation across all view modifiers
- Updated RowItem modifier parameter order for better consistency
- Replaced deprecated foregroundColor with foregroundStyle in navigation and row modifiers
- Moved alert-related modifiers to dedicated Alerts directory
- Moved async utility modifiers from ErrorHandling to Utility directory
- Updated DiscardChanges modifier with improved implementation
- Enhanced DeleteRow modifier with better accessibility support

### Removed
- EmptyOnDisappearField component (functionality integrated into field alert modifiers)
- NnSwiftUIKit+ViewExtensions.swift reference file
- Legacy error handling view modifiers replaced by new architecture
- Old NnAsyncTryButton and NnTryButton views (replaced by AsyncTryButton)
- Standalone error handler classes (NnLoadingHandler, NnSwiftUIErrorHandler)

### Fixed
- Accessibility identifier handling in DeleteRow modifier
- Memory leak in ShowcaseParent modifier when showcase finishes

## [2.0.1] - 2024-11-29
### Added
- Async navigation bar button modifier for error handling in navigation buttons
- Custom discard changes view modifier for form-based views
- NnAppVersionCache helper utility for displaying app version strings in applications

## [2.0.0] - 2024-10-29
### Added
- Item changed view modifier for observing item state changes
- Array extension helpers for common collection operations
- Inline documentation for all public view modifier extension methods
- Conditional optional view modifier
- Conditional view replacement modifier
- Async alert view modifier
- Showing alert view modifier (moved from Utility to Alerts)

### Changed
- Minimum iOS deployment target raised to iOS 16
- Reorganized public view modifiers for better discoverability
- Moved showing alert functionality from Utility to Alerts category

### Removed
- NnButtonRole (no longer needed)
- Custom alert view modifier (replaced by async alert modifier)
- Frame by screen percentage view modifier
- Unnecessary @available annotations after raising minimum iOS version

### Fixed
- Various typos in documentation and code comments

## [1.0.0] - 2024-08-10
### Added
- macOS 13 platform support
- AccessibleItemInfo for consistent accessibility across components
- Custom field alert view modifiers (single and double field variants)
- EmptyOnDisappearField for managing field state
- Async try on submit view modifier
- Device shake gesture view modifier
- Discard changes view modifier for unsaved changes handling
- Custom swipe action view modifier with accessibility support
- Pan gesture view modifier
- Accessibility identifier view modifier
- Gradient background view modifiers (linear and button gradients)
- Linear gradient text color view modifier
- Showing alert view modifier
- Date extension helpers
- String extension utilities
- Tint parameter to tappable and row item view modifiers
- Alignment options to row item and tappable view modifiers
- Cancel role to cancel button in custom alert
- Reference file (NnSwiftUIKit+ViewExtensions.swift) documenting all view extensions

### Changed
- Refactored custom font view modifier to support both iOS and macOS platforms
- NavStack modified to work on macOS
- Updated NavBarDismissButton and navigation bar view modifiers
- TextField behavior in EmptyOnDisappearField
- AccessibleLabelInfo renamed to AccessibleItemInfo
- DeleteRow view modifier now uses Label instead of Image for better UI testing support
- Refactored core extensions for better organization

### Removed
- AsyncTextFieldAlert view modifier (replaced by field alert modifiers)
- NnGradientType (superseded by new gradient system)

### Fixed
- Accessibility identifiers on field alerts
- Bug in custom view modifier implementation

## [0.9.4] - 2024-04-22
### Changed
- Tappable view modifier now includes tapIsActive parameter for conditional tap handling

## [0.9.3] - 2024-03-31
### Fixed
- ShowcaseParentViewModifier now properly resets currentHighlight when showcase finishes

## [0.9.2] - 2024-03-20
### Changed
- AsyncTextField view modifier now supports different keyboard types

## [0.9.1] - 2024-03-05
### Added
- isActive parameter to navigation bar button modifier for conditional button display

## [0.9.0] - 2024-02-27
### Added
- Showcase feature system for highlighting UI elements
- README documentation

## [0.8.0] - 2024-02-18
### Added
- Initial release of NnSwiftUIKit
- Core error handling system with NnErrorHandlingContext
- AsyncTryButton for async operations with error handling
- NnDisplayableError protocol for user-friendly error messages
- Loading view modifiers
- Basic navigation view modifiers
- Conditional display modifiers
- Custom font view modifier
- Row item styling
- Screen dimension extensions
- Core SwiftUI and UIKit extensions
