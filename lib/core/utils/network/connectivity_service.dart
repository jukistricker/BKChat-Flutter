import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  final _controller = StreamController<ConnectivityResult>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(result);
    });
  }

  Stream<ConnectivityResult> get connectivityStream => _controller.stream;

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() => _controller.close();
}
