import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Incremented after approve/reject on security request details.
final securityDashboardRefreshTriggerProvider = StateProvider<int>((ref) => 0);

void triggerSecurityDashboardMyRequestsRefresh() {
  final notifier = KAppX.globalProvider.read(
    securityDashboardRefreshTriggerProvider.notifier,
  );
  notifier.state = notifier.state + 1;
}
