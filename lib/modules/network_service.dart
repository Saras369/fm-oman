import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty && results.first == ConnectivityResult.none) {
        // ShowFlutterToast().showFlutterToastFailure(
        //   'No Internet, Please check your internet connection.',
        // );
      }
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
  }
}
