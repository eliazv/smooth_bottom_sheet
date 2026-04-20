import 'package:flutter/material.dart';

/// Layout configuration for [SmoothBottomSheet], defining dimensions and padding.
@immutable
class SmoothBottomSheetLayout {
  /// The radius of the top corners of the bottom sheet.
  final double borderRadius;

  /// The maximum width of the bottom sheet.
  final double maxWidth;

  /// The padding around the outside of the bottom sheet container.
  final EdgeInsetsGeometry outerPadding;

  /// The padding for the header section (title, subtitle, etc.).
  final EdgeInsetsGeometry headerPadding;

  /// The padding for the main content section.
  final EdgeInsetsGeometry contentPadding;

  /// The width of the drag handle (if shown).
  final double handleWidth;

  /// The height of the drag handle (if shown).
  final double handleHeight;

  /// Creates a [SmoothBottomSheetLayout] with optional default values.
  const SmoothBottomSheetLayout({
    this.borderRadius = 32,
    this.maxWidth = 720,
    this.outerPadding = EdgeInsets.zero,
    this.headerPadding = const EdgeInsets.fromLTRB(24, 24, 24, 16),
    this.contentPadding = const EdgeInsets.fromLTRB(24, 0, 24, 24),
    this.handleWidth = 40,
    this.handleHeight = 4,
  });

  /// Creates a copy of this layout configuration with the given fields replaced.
  SmoothBottomSheetLayout copyWith({
    double? borderRadius,
    double? maxWidth,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    double? handleWidth,
    double? handleHeight,
  }) {
    return SmoothBottomSheetLayout(
      borderRadius: borderRadius ?? this.borderRadius,
      maxWidth: maxWidth ?? this.maxWidth,
      outerPadding: outerPadding ?? this.outerPadding,
      headerPadding: headerPadding ?? this.headerPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      handleWidth: handleWidth ?? this.handleWidth,
      handleHeight: handleHeight ?? this.handleHeight,
    );
  }
}
