import 'package:flutter/material.dart';

/// Animation configuration for [SmoothBottomSheet].
@immutable
class SmoothBottomSheetAnimation {
  final Duration duration;
  final Curve curve;
  final Offset beginOffset;
  final double beginOpacity;

  const SmoothBottomSheetAnimation({
    this.duration = const Duration(milliseconds: 360),
    this.curve = Curves.easeOutCubic,
    this.beginOffset = const Offset(0, 0.08),
    this.beginOpacity = 0.0,
  });

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
