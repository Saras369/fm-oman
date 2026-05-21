import '../../../data/core/connectivity/connectivity.dart';

enum ConnectivityStatus { connected, disconnected }

abstract class KConnectivity {
  static final KConnectivity instance = KConnectivityImpl();

  // ADD THIS LINE:
  void onBootUp();

  Future<ConnectivityStatus> get currentConnectivityStatus;
  Stream<ConnectivityStatus> get onConnectivityStatusChanged;

  // Also add bootDown if you plan to use it
  void bootDown();
}
