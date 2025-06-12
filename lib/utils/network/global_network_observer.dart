import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/network/view_models/connectivity_view_model.dart';

import 'network_error_popup.dart';

class GlobalNetworkObserver extends StatefulWidget {
  final Widget child;
  const GlobalNetworkObserver({super.key, required this.child});

  @override
  State<GlobalNetworkObserver> createState() => _GlobalNetworkObserverState();
}

class _GlobalNetworkObserverState extends State<GlobalNetworkObserver> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _popupEntry;
  bool _manuallyDismissed = false;
  Timer? _retryTimer;


  @override
  void initState() {
    super.initState();
    _startConnectivityMonitor();
  }

  void _startConnectivityMonitor() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final connectivityViewModel = Provider.of<ConnectivityViewModel>(context, listen: false);
      final isOffline = connectivityViewModel.isOffline;

      if (isOffline) {
        if (_popupEntry == null && !_manuallyDismissed) {
          _showPopup();
        } else if (_popupEntry == null && _manuallyDismissed && _retryTimer == null) {
          _retryTimer = Timer(Duration(seconds: 60), () {
            final currentStatus = Provider.of<ConnectivityViewModel>(context, listen: false).isOffline;
            print('[DEBUG] Retrying popup after 5s, isOffline=$currentStatus');
            if (currentStatus) {
              _manuallyDismissed = false;
              _showPopup();
            }
            _retryTimer = null;
          });
        }
      } else {
        // Có mạng lại → reset
        _popupEntry?.remove();
        _popupEntry = null;
        _manuallyDismissed = false;
        _retryTimer?.cancel();
        _retryTimer = null;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }

  void _showPopup() {
    _popupEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(
          ignoring: false,
          child: Material(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: NetworkErrorPopup(
                onClose: () {
                  _popupEntry?.remove();
                  _popupEntry = null;
                  _manuallyDismissed = true;
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_popupEntry!);
  }

  @override
  void dispose() {
    _popupEntry?.remove();
    _retryTimer?.cancel();
    super.dispose();
  }


}
