import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Incremented after approve/reject on attendance request details.
final attendanceDashboardRefreshTriggerProvider = StateProvider<int>((ref) => 0);

void triggerAttendanceDashboardMyRequestsRefresh() {
  final notifier = KAppX.globalProvider.read(
    attendanceDashboardRefreshTriggerProvider.notifier,
  );
  notifier.state = notifier.state + 1;
}
