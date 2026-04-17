## 0.0.3

- Fixed README GIF previews for pub.dev by using absolute GitHub URLs.
- Removed legacy "Cashew" references from documentation.

## 0.0.2

- Fixed `SmoothBottomSheetTheme.light()` — now returns real light palette (white background, dark text).
- Fixed `SmoothBottomSheetTheme.adaptive()` — now correctly reads `Theme.of(context).brightness`.
- `dark()` theme now has proper box shadows for depth.

## 0.0.1

- First public release of `smooth_bottom_sheet`.
- Added `SmoothBottomSheet` with smooth entrance animations.
- Added `showSmoothBottomSheet(...)` helper API.
- Added theme, layout and animation configuration objects.
- Added `SmoothBottomSheetController` for programmatic close.
- Added example app and widget tests.
