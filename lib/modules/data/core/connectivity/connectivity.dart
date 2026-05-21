import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:code_setup/modules/domain/core/connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class KConnectivityImpl implements KConnectivity {
  // 1. Correct the type to match the new List-based API
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  final StreamController<ConnectivityStatus> _controller =
      StreamController<ConnectivityStatus>.broadcast();

  @override
  void onBootUp() {
    log('[KConnectivity] Starting listener...');

    // Listen to the stream and update our controller
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      // If the list contains 'none', we are definitely disconnected
      if (results.contains(ConnectivityResult.none)) {
        _controller.add(ConnectivityStatus.disconnected);
      } else {
        // Even if WiFi is on, we check if we can actually reach the web
        _checkActualData();
      }
    });
  }

  Future<void> _checkActualData() async {
    final status = await currentConnectivityStatus;
    _controller.add(status);
  }

  @override
  void bootDown() {
    _subscription?.cancel();
    _controller.close();
  }

  @override
  Future<ConnectivityStatus> get currentConnectivityStatus async {
    try {
      // Standard check for actual internet reachability
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return ConnectivityStatus.connected;
      }
    } catch (_) {
      return ConnectivityStatus.disconnected;
    }
    return ConnectivityStatus.disconnected;
  }

  @override
  Stream<ConnectivityStatus> get onConnectivityStatusChanged =>
      _controller.stream;
}
