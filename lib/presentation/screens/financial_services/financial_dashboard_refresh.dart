import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Incremented after approve/reject on request details to refresh the dashboard.
final financialDashboardRefreshTriggerProvider = StateProvider<int>((ref) => 0);

void triggerFinancialDashboardMyRequestsRefresh() {
  final notifier = KAppX.globalProvider.read(
    financialDashboardRefreshTriggerProvider.notifier,
  );
  notifier.state = notifier.state + 1;
}
