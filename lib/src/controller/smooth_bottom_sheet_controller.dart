import 'package:flutter/foundation.dart';

/// Controller used to close a displayed smooth bottom sheet programmatically.
class SmoothBottomSheetController extends ChangeNotifier {
  Future<void> Function()? _closeAction;
  bool _isAttached = false;

  /// Whether the controller is currently attached to a bottom sheet.
  bool get isAttached => _isAttached;

  /// Binds a close action to this controller. This is called internally by the sheet.
  void bindCloseAction(Future<void> Function() closeAction) {
    _closeAction = closeAction;
    _isAttached = true;
    notifyListeners();
  }

  /// Removes the bound close action.
  void unbind() {
    _closeAction = null;
    _isAttached = false;
    notifyListeners();
  }

  /// Closes the attached bottom sheet.
  Future<void> close() async {
    final action = _closeAction;
    if (action != null) {
      await action();
    }
  }
}
