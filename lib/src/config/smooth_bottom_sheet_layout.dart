import 'package:flutter/material.dart';

/// Layout configuration for [SmoothBottomSheet].
@immutable
class SmoothBottomSheetLayout {
  final double borderRadius;
  final double maxWidth;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry contentPadding;
  final double handleWidth;
  final double handleHeight;

  const SmoothBottomSheetLayout({
    this.borderRadius = 32,
    this.maxWidth = 720,
    this.outerPadding = EdgeInsets.zero,
    this.headerPadding = const EdgeInsets.fromLTRB(24, 24, 24, 16),
    this.contentPadding = const EdgeInsets.fromLTRB(24, 0, 24, 24),
    this.handleWidth = 40,
    this.handleHeight = 4,
  });

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
