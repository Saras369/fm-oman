import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/security_services/security_request_model.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/drawer_item_widget.dart';
import 'package:code_setup/presentation/common_widgets/radio_group.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/common_widgets/tab_button.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request/view.dart';
import 'package:code_setup/presentation/screens/security_services/security_dashboard_refresh.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/security_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

part 'controller.dart';
part 'widgets/drawer_items.dart';
part 'widgets/security_request_card.dart';
part 'widgets/security_request_form.dart';

@RoutePage()
class SecurityServicesScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final List<SubServices> subServicesList;

  const SecurityServicesScreen({
    super.key,
    required this.serviceId,
    required this.subServicesList,
  });

  @override
  ConsumerState<SecurityServicesScreen> createState() =>
      _SecurityServicesScreenState();
}

class _SecurityServicesScreenState
    extends ConsumerState<SecurityServicesScreen> {
  late final _SecurityControllerParams params;

  @override
  void initState() {
    super.initState();
    params = _SecurityControllerParams(
      serviceId: widget.serviceId,
      subServicesList: widget.subServicesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_securityProvider(params));
    final controller = ref.read(_securityProvider(params).notifier);

    ref.listen<int>(securityDashboardRefreshTriggerProvider, (previous, next) {
      if (previous != next) {
        controller.switchToMyRequestsTabAndRefresh();
      }
    });

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final statsData = state.isApproverView
        ? state.approvalStatsData
        : state.statsData;
    final statusBreakdownData = state.isApproverView
        ? state.approvalStatusBreakdownData
        : state.statusBreakdownData;
    final trendData = state.isApproverView
        ? state.approvalTrendData
        : state.trendData;

    final trendList = List<int>.filled(12, 0);
    final monthlyTrend = trendData.monthlyTrend ?? [];
    for (var i = 0; i < monthlyTrend.length && i < trendList.length; i++) {
      trendList[i] = monthlyTrend[i].total ?? 0;
    }

    final statusData = {
      'opened': ChartData(
        label: 'Opened',
        value: statusBreakdownData.completed ?? 0,
        color: const Color(0xFF54A23B),
      ),
      'pending': ChartData(
        label: 'Pending',
        value: statusBreakdownData.pending ?? 0,
        color: const Color(0xFFF7B226),
      ),
      'closed': ChartData(
        label: 'Closed',
        value: statusBreakdownData.rejected ?? 0,
        color: const Color(0xFFD43E3E),
      ),
    };

    final summaryStats = [
      StatSummaryData(
        title: 'Total Requests',
        description: '',
        icon: Icons.assignment_outlined,
        iconBgColor: const Color(0xFFF3F6F8),
      ),
      StatSummaryData(
        title: 'Approved',
        description: '',
        icon: Icons.check_box_outlined,
        iconBgColor: const Color(0xFFE7F1FF),
      ),
      StatSummaryData(
        title: 'Pending',
        description: '',
        icon: Icons.timer_outlined,
        iconBgColor: const Color(0xFFFFF9E7),
      ),
      StatSummaryData(
        title: 'Rejected',
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
          controller.selectedSubServiceTitle,
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
        child: _SecurityDrawerMenu(
          currentTheme: currentTheme,
          subServices: controller.drawerSubServices,
          activeIndex: state.selectedSubServiceIndex,
          onItemTap: (index) {
            controller.onSelectSubService(index);
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
              onChanged: controller.onChangeStatusDropdownValue,
            ),
            RequestTrendBreakdownCard(
              monthlyData: trendList,
              selectedYear: state.selectedTrendYear,
              yearOptions: controller.yearOptions,
              onYearChanged: controller.onChangedTrendYearValue,
              barColor: const Color(0xFF0B7A3B),
            ),
            _SecurityRequestCard(
              key: ValueKey(state.selectedSubServiceIndex),
              myRequests: state.myRequests,
              actionItems: state.actionItems,
              state: state,
              stateController: controller,
            ),
          ],
        ),
      ),
    );
  }
}
