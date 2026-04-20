import 'package:flutter/material.dart';

/// Animation configuration for [SmoothBottomSheet].
@immutable
class SmoothBottomSheetAnimation {
  /// The duration of the entrance animation.
  final Duration duration;

  /// The curve used for the entrance animation.
  final Curve curve;

  /// The starting offset of the content animation.
  final Offset beginOffset;

  /// The starting opacity of the content animation.
  final double beginOpacity;

  /// Creates a [SmoothBottomSheetAnimation] with optional default values.
  const SmoothBottomSheetAnimation({
    this.duration = const Duration(milliseconds: 360),
    this.curve = Curves.easeOutCubic,
    this.beginOffset = const Offset(0, 0.08),
    this.beginOpacity = 0.0,
  });

  /// Creates a copy of this animation configuration with the given fields replaced.
  SmoothBottomSheetAnimation copyWith({
    Duration? duration,
    Curve? curve,
    Offset? beginOffset,
    double? beginOpacity,
  }) {
    return SmoothBottomSheetAnimation(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      beginOffset: beginOffset ?? this.beginOffset,
      beginOpacity: beginOpacity ?? this.beginOpacity,
    );
  }
}
