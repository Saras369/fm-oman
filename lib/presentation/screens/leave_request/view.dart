import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/behalf_of_user_model.dart';
import 'package:code_setup/modules/data/models/get_user_by_id_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';
import 'package:code_setup/modules/data/models/leave_request/mourning_leave_relation_model.dart';
import 'package:code_setup/modules/data/models/leave_request/my_leave_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/unpaid_leave_category_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/file_upload_widget.dart';
import 'package:code_setup/presentation/common_widgets/radio_group.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/common_widgets/tab_button.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request_details/view.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// part 'widgets/dynamic_leave_form.dart';
part '../../common_widgets/analytics/request_status_breakdown_card.dart';
part '../../common_widgets/analytics/request_trend_breakdown_card.dart';
part 'widgets/leave_request_card.dart';
part '../../common_widgets/analytics/stat_summary_card.dart';
part 'widgets/leave_balance_card.dart';
part 'models/chart_data.dart';
part 'controller.dart';
part 'widgets/leave_form_widget.dart';
// part 'models/leave_form_definitions.dart';

@RoutePage()
class LeaveRequestScreen extends ConsumerWidget {
  final List<SubServices> subServicesList;
  final int serviceId;
  late final DynamicLeaveFormParams params;

  LeaveRequestScreen({
    super.key,
    required this.subServicesList,
    required this.serviceId,
  }) {
    params = DynamicLeaveFormParams(
      subServicesList: subServicesList,
      serviceId: serviceId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var sub in subServicesList) {
      log(sub.toJson().toString());
    }
    final stateController = ref.read(
      dynamicLeaveFormControllerProvider(params).notifier,
    );
    final state = ref.watch(dynamicLeaveFormControllerProvider(params));

    final statusData = {
      "opened": ChartData(label: "Opened", value: 84, color: Color(0xFF54A23B)),
      "pending": ChartData(
        label: "Pending",
        value: 43,
        color: Color(0xFFF7B226),
      ),
      "closed": ChartData(label: "Closed", value: 24, color: Color(0xFFD43E3E)),
    };
    final List<int> ticketCounts = [
      90,
      72,
      60,
      32,
      62,
      41,
      59,
      68,
      64,
      13,
      7,
      5,
    ];

    final stats = [
      StatSummaryData(
        title: "Total Requests",
        description: "This Month",
        icon: Icons.assignment_outlined,
        iconBgColor: const Color(0xFFF3F6F8),
      ),
      StatSummaryData(
        title: "Approved",
        description: "This Month",
        icon: Icons.check_box_outlined,
        iconBgColor: const Color(0xFFE7F1FF),
      ),
      StatSummaryData(
        title: "Pending",
        description: "This Month",
        icon: Icons.timer_outlined,
        iconBgColor: const Color(0xFFFFF9E7),
      ),
      StatSummaryData(
        title: "Rejected",
        description: "This Month",
        icon: Icons.cancel_outlined,
        iconBgColor: const Color(0xFFFFE9EA),
      ),
    ];
    final balances = [
      LeaveBalanceData(
        title: "Casual Leaves",
        used: 8,
        total: 12,
        color: const Color(0xFF6677C6),
      ),
      LeaveBalanceData(
        title: "Sick Leaves",
        used: 1,
        total: 4,
        color: const Color(0xFF2EC5CE),
      ),
      LeaveBalanceData(
        title: "Annual Leaves",
        used: 3,
        total: 24,
        color: const Color(0xFFE8547F),
      ),
      LeaveBalanceData(
        title: "Emergency Leaves",
        used: 2,
        total: 3,
        color: const Color(0xFFA347CF),
      ),
      LeaveBalanceData(
        title: "Others Leaves",
        used: 2,
        total: 14,
        color: const Color(0xFFF96636),
      ),
    ];

    return KScaffold(
      // appBar: KAppBar(
      //   title: Text(
      //     'Leave Request',
      //     style: TextStyle(
      //       fontWeight: currentTheme.fontWeights.wBold,
      //       fontSize: currentTheme.fontSizes.s18,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(10.toAutoScaledWidth),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatSummaryRow(stats: stats, counts: ['13', '2', '3', '4']),

              RequestStatusBreakdownCard(
                data: statusData,
                onChanged: (String? val) {}, // Or localized string
              ),

              RequestTrendBreakdownCard(
                monthlyData: ticketCounts,
                selectedYear: 2025,
                onYearChanged: (int? value) {},
              ),

              LeaveRequestsCardMobile(
                myRequests: state.myLeaveRequests,
                actionItems: [],
                params: params,
                state: state,
                stateController: stateController,
              ),
              LeaveBalancesCard(balances: balances, year: 2025),
            ],
          ),
        ),
      ),
    );
  }
}
