import 'package:flutter/material.dart';

import 'config/smooth_bottom_sheet_animation.dart';
import 'config/smooth_bottom_sheet_layout.dart';
import 'config/smooth_bottom_sheet_theme.dart';
import 'controller/smooth_bottom_sheet_controller.dart';
import 'ui/smooth_bottom_sheet.dart';

/// Shows a reusable smooth bottom sheet.
Future<T?> showSmoothBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  String? subtitle,
  double? height,
  bool scrollable = false,
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

      return SmoothBottomSheet(
        title: title,
        subtitle: subtitle,
        height: height,
        scrollable: scrollable,
        leading: leading,
        trailing: trailing,
        showHandle: showHandle,
        showCloseButton: showCloseButton,
        theme: theme,
        layout: layout,
        animation: animation,
        child: child,
      );
    },
  ).whenComplete(() => controller?.unbind());
}
