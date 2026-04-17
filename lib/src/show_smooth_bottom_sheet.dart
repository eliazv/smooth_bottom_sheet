import 'package:flutter/material.dart';

import 'config/smooth_bottom_sheet_animation.dart';
import 'config/smooth_bottom_sheet_layout.dart';
import 'config/smooth_bottom_sheet_theme.dart';
import 'controller/smooth_bottom_sheet_controller.dart';
import 'ui/smooth_bottom_sheet.dart';

/// Shows a [SmoothBottomSheet].
///
/// [maxHeightFactor] limits the sheet height as a fraction of the screen
/// height (e.g. `0.8` = 80%). Useful for scrollable sheets that should not
/// cover the full screen. Defaults to `1.0` (no limit).
Future<T?> showSmoothBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  String? subtitle,
  double? height,
  double maxHeightFactor = 1.0,
  bool scrollable = false,
  bool gradientHeader = false,
  Widget? leading,
  Widget? trailing,
  bool showHandle = false,
  bool showCloseButton = true,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = false,
  Color barrierColor = const Color(0x99000000),
  SmoothBottomSheetTheme? theme,
  SmoothBottomSheetLayout layout = const SmoothBottomSheetLayout(),
  SmoothBottomSheetAnimation animation = const SmoothBottomSheetAnimation(),
  SmoothBottomSheetController? controller,
}) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (sheetContext) {
      controller?.bindCloseAction(() async {
        if (Navigator.of(sheetContext).canPop()) {
          Navigator.of(sheetContext).pop();
        }
      });

      Widget sheet = SmoothBottomSheet(
        title: title,
        subtitle: subtitle,
        height: height,
        scrollable: scrollable || gradientHeader,
        gradientHeader: gradientHeader,
        leading: leading,
        trailing: trailing,
        showHandle: showHandle,
        showCloseButton: showCloseButton,
        theme: theme,
        layout: layout,
        animation: animation,
        child: child,
      );

      if (maxHeightFactor < 1.0) {
        final maxH =
            MediaQuery.of(sheetContext).size.height * maxHeightFactor;
        sheet = ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: sheet,
        );
      }

      return sheet;
    },
  ).whenComplete(() => controller?.unbind());
}
