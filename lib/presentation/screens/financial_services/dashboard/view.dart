import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/financial_services/allownace_type_model.dart';
import 'package:code_setup/modules/data/models/financial_services/bank_name_model.dart';
import 'package:code_setup/modules/data/models/financial_services/currency_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_service_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/drawer_item_widget.dart';
import 'package:code_setup/presentation/common_widgets/radio_group.dart';
import 'package:code_setup/presentation/common_widgets/request_actions_menu.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/common_widgets/tab_button.dart';
import 'package:code_setup/presentation/screens/leave_request/view.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/financial_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

part 'controller.dart';
part 'widgets/finance_approval_card.dart';
part 'widgets/payslip_request_form.dart';
part 'widgets/salary_certificate_form.dart';
part 'widgets/change_bank_account_request.dart';
part 'widgets/allownace_request_form.dart';
part 'widgets/drawer_items.dart';

@RoutePage()
class FinancialServicesDashboardPage extends ConsumerStatefulWidget {
  final int serviceId;
  final List<SubServices> subServiceList;
  const FinancialServicesDashboardPage({
    super.key,
    required this.serviceId,
    required this.subServiceList,
  });

  @override
  ConsumerState<FinancialServicesDashboardPage> createState() =>
      _FinancialServicesDashboardPageState();
}

class _FinancialServicesDashboardPageState
    extends ConsumerState<FinancialServicesDashboardPage> {
  late final _VSControllerParams params;

  @override
  void initState() {
    super.initState();
    params = _VSControllerParams(
      serviceId: widget.serviceId,
      subServiceList: widget.subServiceList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(_vsProvider(params));
    final stateController = ref.read(_vsProvider(params).notifier);
    final statsData = state.isApproverView
        ? state.approvalStatsData
        : state.statsData;
    final statusBreakdownData = state.isApproverView
        ? state.approvalStatusBreakdownData
        : state.statusBreakdownData;

    final statusData = {
      "opened": ChartData(
        label: l10n.statusOpened,
        value: statusBreakdownData.completed ?? 0,
        color: Color(0xFF54A23B),
      ),
      "pending": ChartData(
        label: l10n.statusPending,
        value: statusBreakdownData.pending ?? 0,
        color: Color(0xFFF7B226),
      ),
      "closed": ChartData(
        label: l10n.statusClosed,
        value: statusBreakdownData.rejected ?? 0,
        color: Color(0xFFD43E3E),
      ),
    };

    final trendData = state.isApproverView
        ? state.approvalTrendData
        : state.trendData;

    List<int> trendList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if (trendData.monthlyTrend?.isNotEmpty == true) {
      for (var i = 0; i < trendData.monthlyTrend!.length; i++) {
        trendList[i] = trendData.monthlyTrend![i].total ?? 0;
      }
    }
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final summaryStats = [
      StatSummaryData(
        title: l10n.statTotalRequests,
        description: '',
        icon: Icons.assignment_outlined,
        iconBgColor: const Color(0xFFF3F6F8),
      ),
      StatSummaryData(
        title: l10n.statApproved,
        description: '',
        icon: Icons.check_box_outlined,
        iconBgColor: const Color(0xFFE7F1FF),
      ),
      StatSummaryData(
        title: l10n.statPending,
        description: '',
        icon: Icons.timer_outlined,
        iconBgColor: const Color(0xFFFFF9E7),
      ),
      StatSummaryData(
        title: l10n.statRejected,
        description: '',
        icon: Icons.cancel_outlined,
        iconBgColor: const Color(0xFFFFE9EA),
      ),
    ];

    return KScaffold(
      appBar: KAppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Text(
          stateController.selectedSubServiceTitle,
          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => KAppX.router.pop(),
          ),
        ],
      ),
      drawer: KDrawer(
        child: _FinancialDrawerMenu(
          currentTheme: currentTheme,
          subServices: widget.subServiceList,
          activeIndex: state.selectedSubServiceIndex,
          onItemTap: (index) {
            stateController.onSelectSubService(index);
            KAppX.router.pop();
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            StatSummaryRow(
              stats: summaryStats,
              counts: [
                '${statsData.total ?? 0}',
                '${statsData.completed ?? 0}',
                '${statsData.pending ?? 0}',
                '${statsData.rejected ?? 0}',
              ],
            ),

            RequestStatusBreakdownCard(
              data: statusData,
              filterLabelSelected: state.selectedBreakdownValue,
              onChanged: (String? val) {
                stateController.onChangeStatusDropdownValue(val);
              },
            ),

            RequestTrendBreakdownCard(
              monthlyData: trendList,
              selectedYear: state.selectedTrendYear,
              yearOptions: stateController.yearOptions,
              onYearChanged: stateController.onChangedTrendYearValue,
              barColor: const Color(0xFFBD8A52),
            ),

            FinanceApprovalCard(
              key: ValueKey(state.selectedSubServiceIndex),
              myRequests: state.myRequests,
              actionItems: state.actionItems,
              state: state,
              stateController: stateController,
            ),
          ],
        ),
      ),
    );
  }
}
