import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/presentation/common_widgets/request_actions_menu.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/appointments/view.dart';
import 'package:code_setup/presentation/screens/leave_request/view.dart';
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/models/attendance_data_model.dart';
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/widgets/attendance_history.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/attendance_repository.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

part 'controller.dart';
part 'widgets/shift_info_card.dart';
part 'widgets/scrollable_month_bar.dart';
part 'widgets/attendance_requests_card.dart';
part 'widgets/update_attendance_request_form.dart';

@RoutePage()
class UpdateAttendanceRecordScreen extends ConsumerWidget {
  const UpdateAttendanceRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(_vsProvider);
    final stateController = ref.watch(_vsProvider.notifier);
    final l10n = AppLocalizations.of(context);

    final sessions = [
      SessionDetail(
        name: "Session 1",
        sessionTiming: "10:00 - 14:30",
        firstIn: "10:30 AM",
        lastOut: "-",
      ),
      SessionDetail(
        name: "Session 2",
        sessionTiming: "14:31 - 06:00",
        firstIn: "-",
        lastOut: "05:30",
      ),
    ];

    final attData = state.attendanceData;
    final counts = [
      '${attData.employeeAvgWorkingHours ?? 0}',
      '${attData.actualShiftWorkingHours ?? 0}',
      '${attData.lateCheckinCount ?? 0}',
      '${attData.earlyCheckoutCount ?? 0}',
    ];
    return KScaffold(
      // appBar: KAppBar(
      //   title: Text(
      //     '${AppLocalizations.of(context)!.updateAttendanceRecord}',
      //     style: TextStyle(
      //       fontWeight: currentTheme.fontWeights.wBold,
      //       fontSize: currentTheme.fontSizes.s18,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toAutoScaledWidth,
            vertical: 20.toAutoScaledHeight,
          ),
          child: Column(
            children: [
              StatSummaryRow(
                stats: stateController.stats,
                counts: counts,
                // itemWidth: 180.toAutoScaledWidth,
              ),
              10.toVerticalSizedBox,
              ScrollableMonthBar(initialDate: DateTime.now()),
              10.toVerticalSizedBox,

              // Legend panel below calendar
              LegendsPanel(),
              20.toVerticalSizedBox,
              AttendanceRequestsCard(
                myRequests: state.myAttendanceRequests,
                actionItems: [],
                state: state,
                stateController: stateController,
              ),
              20.toVerticalSizedBox,

              ShiftInfoCard(
                date: DateTime(2025, 9, 1),
                status: "Present",
                shiftTimings: "09: 00 AM - 06:00 PM",
                checkInTime: "10:30 AM",
                checkOutTime: "10:30 AM",
                totalWorkingHours: "08:32:17 Hrs",
                excessHours: "--",
              ),
              20.toVerticalSizedBox,
              SessionDetailSection(sessions: sessions),
            ],
          ),
        ),
      ),
    );
  }
}
