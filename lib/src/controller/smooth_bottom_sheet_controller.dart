import 'package:flutter/foundation.dart';

/// Controller used to close a displayed smooth bottom sheet programmatically.
class SmoothBottomSheetController extends ChangeNotifier {
  Future<void> Function()? _closeAction;
  bool _isAttached = false;

  bool get isAttached => _isAttached;

  void bindCloseAction(Future<void> Function() closeAction) {
    _closeAction = closeAction;
    _isAttached = true;
    notifyListeners();
  }

  void unbind() {
    _closeAction = null;
    _isAttached = false;
    notifyListeners();
  }

  Future<void> close() async {
    final action = _closeAction;
    if (action != null) {
      await action();
    }
  }
}
