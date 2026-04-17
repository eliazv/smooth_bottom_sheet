import 'package:flutter/material.dart';

import '../config/smooth_bottom_sheet_animation.dart';
import '../config/smooth_bottom_sheet_layout.dart';
import '../config/smooth_bottom_sheet_theme.dart';

/// Main bottom sheet widget.
class SmoothBottomSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget child;
  final double? height;
  final bool scrollable;
  final Widget? leading;
  final Widget? trailing;
  final bool showHandle;
  final bool showCloseButton;
  final SmoothBottomSheetTheme? theme;
  final SmoothBottomSheetLayout layout;
  final SmoothBottomSheetAnimation animation;

  const SmoothBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.height,
    this.scrollable = false,
    this.leading,
    this.trailing,
    this.showHandle = false,
    this.showCloseButton = true,
    this.theme,
    this.layout = const SmoothBottomSheetLayout(),
    this.animation = const SmoothBottomSheetAnimation(),
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = theme ?? SmoothBottomSheetTheme.adaptive(context);
    final closeButton =
        trailing ??
        (showCloseButton
            ? IconButton(
                key: const Key('smooth_bottom_sheet_close_button'),
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: resolvedTheme.closeButtonBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: resolvedTheme.closeButtonIconColor,
                    size: 18,
                  ),
                ),
              )
            : null);
    final trailingActions = <Widget>[];
    if (closeButton != null) {
      trailingActions.add(closeButton);
    }

    final content = Column(
      mainAxisSize: height == null ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHandle)
          Container(
            key: const Key('smooth_bottom_sheet_handle'),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Container(
              width: layout.handleWidth,
              height: layout.handleHeight,
              decoration: BoxDecoration(
                color: resolvedTheme.handleColor,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        if (title != null ||
            subtitle != null ||
            leading != null ||
            closeButton != null)
          Padding(
            padding: layout.headerPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 12)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(title!, style: resolvedTheme.titleTextStyle),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(subtitle!, style: resolvedTheme.subtitleTextStyle),
                      ],
                    ],
                  ),
                ),
                ...trailingActions,
              ],
            ),
          ),
        if (scrollable && height != null)
          Expanded(
            child: SingleChildScrollView(
              padding: layout.contentPadding,
              physics: const BouncingScrollPhysics(),
              child: child,
            ),
          )
        else if (scrollable)
          Flexible(
            child: SingleChildScrollView(
              padding: layout.contentPadding,
              physics: const BouncingScrollPhysics(),
              child: child,
            ),
          )
        else
          Padding(padding: layout.contentPadding, child: child),
      ],
    );

    return TweenAnimationBuilder<double>(
      duration: animation.duration,
      curve: animation.curve,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, childWidget) {
        final curvedValue = Curves.easeOut.transform(value);
        final dy = (1 - curvedValue) * animation.beginOffset.dy;
        final opacity =
            animation.beginOpacity + (1 - animation.beginOpacity) * curvedValue;

        return Opacity(
          opacity: opacity,
          child: FractionalTranslation(
            translation: Offset(0, dy),
            child: childWidget,
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: layout.maxWidth),
        child: Padding(
          padding: layout.outerPadding,
          child: Container(
            height: height,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(layout.borderRadius),
              ),
              border: Border.all(color: resolvedTheme.borderColor),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [resolvedTheme.startColor, resolvedTheme.endColor],
              ),
              boxShadow: resolvedTheme.shadows,
            ),
            child: SafeArea(top: false, child: content),
          ),
        ),
      ),
    );
  }
}
