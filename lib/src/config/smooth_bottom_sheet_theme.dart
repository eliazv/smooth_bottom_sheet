import 'package:flutter/material.dart';

/// Visual configuration for [SmoothBottomSheet], defining colors, styles, and shadows.
@immutable
class SmoothBottomSheetTheme {
  /// The starting color of the background gradient.
  final Color startColor;

  /// The ending color of the background gradient.
  final Color endColor;

  /// The color of the sheet's border.
  final Color borderColor;

  /// The color of the drag handle (if shown).
  final Color handleColor;

  /// The background color of the default close button.
  final Color closeButtonBackgroundColor;

  /// The icon color of the default close button.
  final Color closeButtonIconColor;

  /// The shadows applied to the bottom sheet.
  final List<BoxShadow> shadows;

  /// The text style for the title in the header.
  final TextStyle titleTextStyle;

  /// The text style for the subtitle in the header.
  final TextStyle subtitleTextStyle;

  /// Creates a [SmoothBottomSheetTheme] with all required properties.
  const SmoothBottomSheetTheme({
    required this.startColor,
    required this.endColor,
    required this.borderColor,
    required this.handleColor,
    required this.closeButtonBackgroundColor,
    required this.closeButtonIconColor,
    required this.shadows,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
  });

  /// Default light theme configuration.
  factory SmoothBottomSheetTheme.light() {
    return SmoothBottomSheetTheme(
      startColor: const Color(0xFFFFFFFF),
      endColor: const Color(0xFFF5F5F7),
      borderColor: const Color(0x1A000000),
      handleColor: const Color(0x4D000000),
      closeButtonBackgroundColor: const Color(0x0F000000),
      closeButtonIconColor: const Color(0xFF1C1C1E),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, -4),
        ),
      ],
      titleTextStyle: const TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        color: Color(0x993C3C43),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Default dark theme configuration.
  factory SmoothBottomSheetTheme.dark() {
    return SmoothBottomSheetTheme(
      startColor: const Color(0xFF1C1C1C),
      endColor: const Color(0xFF0A0A0A),
      borderColor: const Color(0x1AFFFFFF),
      handleColor: const Color(0x66FFFFFF),
      closeButtonBackgroundColor: const Color(0x1AFFFFFF),
      closeButtonIconColor: const Color(0xFFFFFFFF),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, -4),
        ),
      ],
      titleTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        color: Color(0xB3FFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Returns a themes based on the current [BuildContext] brightness.
  factory SmoothBottomSheetTheme.adaptive(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? SmoothBottomSheetTheme.dark()
        : SmoothBottomSheetTheme.light();
  }

  /// Creates a copy of this theme with the given fields replaced.
  SmoothBottomSheetTheme copyWith({
    Color? startColor,
    Color? endColor,
    Color? borderColor,
    Color? handleColor,
    Color? closeButtonBackgroundColor,
    Color? closeButtonIconColor,
    List<BoxShadow>? shadows,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) {
    return SmoothBottomSheetTheme(
      startColor: startColor ?? this.startColor,
      endColor: endColor ?? this.endColor,
      borderColor: borderColor ?? this.borderColor,
      handleColor: handleColor ?? this.handleColor,
      closeButtonBackgroundColor:
          closeButtonBackgroundColor ?? this.closeButtonBackgroundColor,
      closeButtonIconColor: closeButtonIconColor ?? this.closeButtonIconColor,
      shadows: shadows ?? this.shadows,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    );
  }
}
