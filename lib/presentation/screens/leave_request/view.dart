import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/behalf_of_user_model.dart';
import 'package:code_setup/modules/data/models/get_user_by_id_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';
import 'package:code_setup/modules/data/models/leave_request/mourning_leave_relation_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_user_balance_model.dart';
import 'package:code_setup/modules/data/models/leave_request/my_leave_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/unpaid_leave_category_model.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/file_upload_widget.dart';
import 'package:code_setup/presentation/common_widgets/radio_group.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/common_widgets/tab_button.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              StatSummaryRow(
                stats: stateController.stats,
                counts: stateController.determineKPIStats(),
              ),

              RequestStatusBreakdownCard(
                data: stateController.returnStatusBreakdownData(),
                onChanged: stateController.onChangedStatusBreakDownValue,
              ),

              RequestTrendBreakdownCard(
                monthlyData: stateController.returnMonthlyTrendData(),
                selectedYear: state.selectedTrendYear,
                yearOptions: stateController.yearOptions,
                onYearChanged: stateController.onChangedTrendYearValue,
              ),

              LeaveRequestsCardMobile(
                myRequests: state.myLeaveRequests,
                actionItems: state.actionItems,
                params: params,
                state: state,
                stateController: stateController,
              ),
              // LeaveBalancesCard(
              //   balances: state.leaveBalances,
              //   year: state.selectedBalanceYear,
              //   yearOptions: stateController.yearOptions,
              //   onYearChanged: stateController.onChangedBalanceYearValue,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class LeaveRequestCreateScreen extends ConsumerWidget {
  final List<SubServices> subServicesList;
  final int serviceId;
  late final DynamicLeaveFormParams params;

  LeaveRequestCreateScreen({
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
    return KScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.toAutoScaledWidth),
          child: LeaveFormWidget(params: params),
        ),
      ),
    );
  }
}
