import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/page_status.dart';

/// Alias for ChangeNotifierProvider as every ViewModel is a ChangeNotifier
typedef ViewModelProvider<T extends ChangeNotifier?> = ChangeNotifierProvider<T>;

class ViewModel extends ChangeNotifier {
  var _disposed = false;
  LoadingStatus pageLoadingStatus = LoadingStatus.ready;

  var cancelationToken = CancelToken();

  @override
  void dispose() {
    super.dispose();
    cancelationToken.cancel();
    _disposed = true;
  }

  void setStatus(LoadingStatus status) {
    if (_disposed) {
      return;
    }

    pageLoadingStatus = status;
    notifyListeners();
  }

  void cancelableIfDisposed(Function() action) {
    if (cancelationToken.isCancelled) {
      return;
    }

    action();
  }
}