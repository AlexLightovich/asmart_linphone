import 'package:flutter/widgets.dart';

class AppLifecycleTracker with WidgetsBindingObserver {
  static final AppLifecycleTracker _instance = AppLifecycleTracker._internal();

  bool isInForeground = true;
  bool _hasCalledOnResume = false;
  VoidCallback? _onFirstResume;

  factory AppLifecycleTracker() => _instance;

  AppLifecycleTracker._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  void setOnFirstResume(VoidCallback callback) {
    _onFirstResume = callback;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isInForeground = (state == AppLifecycleState.resumed);

    if (state == AppLifecycleState.resumed &&
        !_hasCalledOnResume &&
        _onFirstResume != null) {
      _hasCalledOnResume = true;
      _onFirstResume!.call();
    }
  }
}
