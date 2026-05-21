import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_category_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_issue_type_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_sub_category_model.dart';
import 'package:code_setup/modules/data/models/stationery/sationery_material_model.dart';
import 'package:code_setup/modules/data/models/stationery/stationery_my_request_model.dart';
import 'package:code_setup/modules/data/models/stationery/stationery_office_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/file_upload_widget.dart';
import 'package:code_setup/presentation/common_widgets/request_actions_menu.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/appointments/view.dart';
import 'package:code_setup/presentation/screens/home/view.dart';
import 'package:code_setup/presentation/screens/leave_request/view.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/stationery_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
part 'widgets/stationery_request_card.dart';
part 'widgets/stationery_request_form.dart';

@RoutePage()
class StationeryRequestScreen extends ConsumerWidget {
  final List<SubServices> subServicesList;
  final int serviceId;
  late final _VSControllerParams params;

  StationeryRequestScreen({
    super.key,
    required this.subServicesList,
    required this.serviceId,
  }) {
    params = _VSControllerParams(
      subServicesList: subServicesList,
      serviceId: serviceId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

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

    final state = ref.watch(_vsProvider(params));
    final stateController = ref.read(_vsProvider(params).notifier);
    // final statsData = state.statsData;

    final statusBreakdown = state.isMyRequest
        ? state.statusBreakdown
        : state.approvalStatusBreakdown;
    final monthlyTrend = state.isMyRequest
        ? state.monthlyTrend.monthlyTrend
        : state.approvalMonthlyTrend.monthlyTrend;

    final statusData = {
      "opened": ChartData(
        label: "Opened",
        value: statusBreakdown.completed ?? 0,
        color: Color(0xFF54A23B),
      ),
      "pending": ChartData(
        label: "Pending",
        value: statusBreakdown.pending ?? 0,
        color: Color(0xFFF7B226),
      ),
      "closed": ChartData(
        label: "Closed",
        value: statusBreakdown.rejected ?? 0,
        color: Color(0xFFD43E3E),
      ),
    };

    // final trendData = state.trendData;

    final trendData = [];

    List<int> trendList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if (monthlyTrend?.isNotEmpty == true) {
      for (var i = 0; i < monthlyTrend!.length; i++) {
        trendList[i] = monthlyTrend[i].total ?? 0;
      }
    }
    return KScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StatSummaryRow(
              stats: stats,
              counts: stateController.determineKPIStats(),
            ),

            RequestStatusBreakdownCard(
              data: statusData,
              onChanged: (String? val) {
                // stateController.onChangeStatusDropdownValue(val);
              }, // Or localized string
            ),

            RequestTrendBreakdownCard(
              monthlyData: trendList,
              selectedYear: 2025,
              barColor: const Color(0xFFBD8A52),
              onYearChanged: (int? value) {},
            ),

            StationeryRequestCard(
              myRequests: state.myRequests,
              actionItems: state.myRequests,
              state: state,
              stateController: stateController,
              params: params,
            ),
          ],
        ),
      ),
    );
  }
}
