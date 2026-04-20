import 'package:flutter/material.dart';

import '../config/smooth_bottom_sheet_animation.dart';
import '../config/smooth_bottom_sheet_layout.dart';
import '../config/smooth_bottom_sheet_theme.dart';

/// A customizable, premium bottom sheet widget with support for scrollable content,
/// pinned headers, and smooth animations.
class SmoothBottomSheet extends StatefulWidget {
  /// The title displayed in the header.
  final String? title;

  /// The subtitle displayed below the title in the header.
  final String? subtitle;

  /// The main content of the bottom sheet.
  final Widget child;

  /// The explicit height of the bottom sheet. If null, it will shrink-wrap its content
  /// unless [scrollable] or [gradientHeader] is true.
  final double? height;

  /// Whether the content should be scrollable.
  final bool scrollable;

  /// A widget to display on the left side of the header.
  final Widget? leading;

  /// A widget to display on the right side of the header. If provided, it replaces
  /// the default close button.
  final Widget? trailing;

  /// Whether to show a pull handle at the top of the sheet.
  final bool showHandle;

  /// Whether to show the default close button.
  final bool showCloseButton;

  /// When true, the header is pinned with a gradient that fades to transparent
  /// at the bottom — content scrolls under it. Implicitly sets [scrollable].
  final bool gradientHeader;

  /// The theme configuration for colors and text styles.
  final SmoothBottomSheetTheme? theme;

  /// The layout configuration for padding and dimensions.
  final SmoothBottomSheetLayout layout;

  /// The animation configuration for the entrance transition.
  final SmoothBottomSheetAnimation animation;

  /// Creates a [SmoothBottomSheet].
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
    this.gradientHeader = false,
    this.theme,
    this.layout = const SmoothBottomSheetLayout(),
    this.animation = const SmoothBottomSheetAnimation(),
  });

  @override
  State<SmoothBottomSheet> createState() => _SmoothBottomSheetState();
}

class _SmoothBottomSheetState extends State<SmoothBottomSheet> {
  final _headerKey = GlobalKey();
  double _headerHeight = 0;

  @override
  void initState() {
    super.initState();
    if (widget.gradientHeader) {
      WidgetsBinding.instance.addPostFrameCallback(_measureHeader);
    }
  }

  void _measureHeader(_) {
    final box = _headerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && mounted) {
      final h = box.size.height;
      if (h != _headerHeight) setState(() => _headerHeight = h);
    }
  }

  bool get _needsScroll => widget.scrollable || widget.gradientHeader;

  bool get _hasHeader =>
      widget.title != null ||
      widget.subtitle != null ||
      widget.leading != null ||
      widget.showCloseButton ||
      widget.trailing != null;

  Widget _buildHeaderRow(SmoothBottomSheetTheme t) {
    final closeBtn =
        widget.trailing ??
        (widget.showCloseButton
            ? IconButton(
                key: const Key('smooth_bottom_sheet_close_button'),
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: t.closeButtonBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: t.closeButtonIconColor,
                    size: 18,
                  ),
                ),
              )
            : null);

    return Padding(
      padding: widget.layout.headerPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  Text(widget.title!, style: t.titleTextStyle),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(widget.subtitle!, style: t.subtitleTextStyle),
                ],
              ],
            ),
          ),
          ?closeBtn,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme ?? SmoothBottomSheetTheme.adaptive(context);
    final radius = widget.layout.borderRadius;

    // When scrollable/gradientHeader, fill the available constrained space.
    final containerHeight =
        widget.height ?? (_needsScroll ? double.infinity : null);

    final Widget inner = widget.gradientHeader
        ? _buildGradientLayout(t)
        : _buildStandardLayout(t);

    return TweenAnimationBuilder<double>(
      duration: widget.animation.duration,
      curve: widget.animation.curve,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        final cv = Curves.easeOut.transform(value);
        return Opacity(
          opacity:
              widget.animation.beginOpacity +
              (1 - widget.animation.beginOpacity) * cv,
          child: FractionalTranslation(
            translation: Offset(0, (1 - cv) * widget.animation.beginOffset.dy),
            child: child,
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.layout.maxWidth),
        child: Padding(
          padding: widget.layout.outerPadding,
          child: Container(
            height: containerHeight,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
              // No top border — shadows provide separation.
              // Left/right/bottom border retained for subtle definition.
              border: Border(
                left: BorderSide(color: t.borderColor),
                right: BorderSide(color: t.borderColor),
                bottom: BorderSide(color: t.borderColor),
              ),
              color: widget.gradientHeader ? t.startColor : null,
              gradient: widget.gradientHeader
                  ? null
                  : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [t.startColor, t.endColor],
                    ),
              boxShadow: t.shadows,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
              child: SafeArea(top: false, child: inner),
            ),
          ),
        ),
      ),
    );
  }

  // ── Standard layout ────────────────────────────────────────────────────────

  Widget _buildStandardLayout(SmoothBottomSheetTheme t) {
    return Column(
      // Min when static (shrink-wrap), max when scrollable (fill container).
      mainAxisSize: _needsScroll ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_hasHeader) _buildHeaderRow(t),
        if (_needsScroll)
          Expanded(
            child: SingleChildScrollView(
              padding: widget.layout.contentPadding,
              physics: const BouncingScrollPhysics(),
              child: widget.child,
            ),
          )
        else
          Padding(padding: widget.layout.contentPadding, child: widget.child),
      ],
    );
  }

  // ── Gradient-header layout ─────────────────────────────────────────────────

  Widget _buildGradientLayout(SmoothBottomSheetTheme t) {
    final cp = widget.layout.contentPadding.resolve(Directionality.of(context));

    final header = Container(
      key: _headerKey,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            t.startColor,
            t.startColor,
            t.startColor.withValues(alpha: 0.72),
            t.startColor.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.5, 0.75, 1.0],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [if (_hasHeader) _buildHeaderRow(t)],
      ),
    );

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              cp.left,
              _headerHeight + cp.top,
              cp.right,
              cp.bottom,
            ),
            child: widget.child,
          ),
        ),
        Positioned(top: 0, left: 0, right: 0, child: header),
      ],
    );
  }
}
