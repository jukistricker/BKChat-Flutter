import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityViewModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _subscription;
  bool _isOffline = false;

  bool get isOffline => _isOffline;

  ConnectivityViewModel() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      _isOffline = result == ConnectivityResult.none;
      notifyListeners();
    });
    _init();
  }

  Future<void> _init() async {
    final result = await _connectivity.checkConnectivity();
    _isOffline = result == ConnectivityResult.none;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
