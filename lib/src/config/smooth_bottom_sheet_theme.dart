import 'package:flutter/material.dart';

/// Visual configuration for [SmoothBottomSheet].
@immutable
class SmoothBottomSheetTheme {
  final Color startColor;
  final Color endColor;
  final Color borderColor;
  final Color handleColor;
  final Color closeButtonBackgroundColor;
  final Color closeButtonIconColor;
  final List<BoxShadow> shadows;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

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

  factory SmoothBottomSheetTheme.light() {
    return const SmoothBottomSheetTheme(
      startColor: Color(0xFF1C1C1C),
      endColor: Color(0xFF0A0A0A),
      borderColor: Color(0x1AFFFFFF),
      handleColor: Color(0x66FFFFFF),
      closeButtonBackgroundColor: Color(0x1AFFFFFF),
      closeButtonIconColor: Color(0xFFFFFFFF),
      shadows: [],
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: TextStyle(
        color: Color(0xB3FFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  factory SmoothBottomSheetTheme.dark() {
    return SmoothBottomSheetTheme.light();
  }

  factory SmoothBottomSheetTheme.adaptive(BuildContext context) {
    return SmoothBottomSheetTheme.dark();
  }

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
