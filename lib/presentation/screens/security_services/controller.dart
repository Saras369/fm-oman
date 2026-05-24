part of 'view.dart';

class _SecurityControllerParams extends Equatable {
  final int serviceId;
  final List<SubServices> subServicesList;

  const _SecurityControllerParams({
    required this.serviceId,
    required this.subServicesList,
  });

  @override
  List<Object?> get props => [serviceId, subServicesList];
}

final _securityProvider = StateNotifierProvider.autoDispose
    .family<_SecurityController, _SecurityViewState, _SecurityControllerParams>(
      (ref, params) => _SecurityController(params),
    );

enum _SecurityRequestType {
  employeeCard(
    slug: 'employee-card',
    title: 'Request for Employee Card',
    icon: Icons.badge_outlined,
  ),
  retiredCard(
    slug: 'retired-card',
    title: 'Request for Retired Card',
    icon: Icons.card_membership_outlined,
  ),
  gatePass(
    slug: 'gate-pass',
    title: 'Request for Gate Pass',
    icon: Icons.meeting_room_outlined,
  );

  final String slug;
  final String title;
  final IconData icon;

  const _SecurityRequestType({
    required this.slug,
    required this.title,
    required this.icon,
  });
}

String _normalizedSecurityName(String? name) {
  return name?.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim() ?? '';
}

_SecurityRequestType? _securityTypeFromName(String? name) {
  final normalized = _normalizedSecurityName(name);
  if (normalized.contains('employee') && normalized.contains('card')) {
    return _SecurityRequestType.employeeCard;
  }
  if (normalized.contains('retired') && normalized.contains('card')) {
    return _SecurityRequestType.retiredCard;
  }
  if (normalized.contains('gate') && normalized.contains('pass')) {
    return _SecurityRequestType.gatePass;
  }
  return null;
}

class _SecurityViewState {
  final bool isLoading;
  final bool isApproverView;
  final int selectedSubServiceIndex;
  final String selectedBreakdownValue;
  final int selectedTrendYear;
  final FinancialServicesStatsData statsData;
  final FinancialServicesTrendBreakdownData trendData;
  final FinancialStatusBreakdownData statusBreakdownData;
  final FinancialServicesStatsData approvalStatsData;
  final FinancialServicesTrendBreakdownData approvalTrendData;
  final FinancialStatusBreakdownData approvalStatusBreakdownData;
  final List<SecurityRequestItem> myRequests;
  final List<SecurityRequestItem> actionItems;

  _SecurityViewState({
    required this.isLoading,
    required this.isApproverView,
    required this.selectedSubServiceIndex,
    required this.selectedBreakdownValue,
    required this.selectedTrendYear,
    required this.statsData,
    required this.trendData,
    required this.statusBreakdownData,
    required this.approvalStatsData,
    required this.approvalTrendData,
    required this.approvalStatusBreakdownData,
    required this.myRequests,
    required this.actionItems,
  });

  factory _SecurityViewState.init() {
    return _SecurityViewState(
      isLoading: false,
      isApproverView: false,
      selectedSubServiceIndex: 0,
      selectedBreakdownValue: 'Yearly',
      selectedTrendYear: DateTime.now().year,
      statsData: FinancialServicesStatsData(),
      trendData: FinancialServicesTrendBreakdownData(),
      statusBreakdownData: FinancialStatusBreakdownData(),
      approvalStatsData: FinancialServicesStatsData(),
      approvalTrendData: FinancialServicesTrendBreakdownData(),
      approvalStatusBreakdownData: FinancialStatusBreakdownData(),
      myRequests: [],
      actionItems: [],
    );
  }

  _SecurityViewState copyWith({
    bool? isLoading,
    bool? isApproverView,
    int? selectedSubServiceIndex,
    String? selectedBreakdownValue,
    int? selectedTrendYear,
    FinancialServicesStatsData? statsData,
    FinancialServicesTrendBreakdownData? trendData,
    FinancialStatusBreakdownData? statusBreakdownData,
    FinancialServicesStatsData? approvalStatsData,
    FinancialServicesTrendBreakdownData? approvalTrendData,
    FinancialStatusBreakdownData? approvalStatusBreakdownData,
    List<SecurityRequestItem>? myRequests,
    List<SecurityRequestItem>? actionItems,
  }) {
    return _SecurityViewState(
      isLoading: isLoading ?? this.isLoading,
      isApproverView: isApproverView ?? this.isApproverView,
      selectedSubServiceIndex:
          selectedSubServiceIndex ?? this.selectedSubServiceIndex,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendYear: selectedTrendYear ?? this.selectedTrendYear,
      statsData: statsData ?? this.statsData,
      trendData: trendData ?? this.trendData,
      statusBreakdownData: statusBreakdownData ?? this.statusBreakdownData,
      approvalStatsData: approvalStatsData ?? this.approvalStatsData,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      approvalStatusBreakdownData:
          approvalStatusBreakdownData ?? this.approvalStatusBreakdownData,
      myRequests: myRequests ?? this.myRequests,
      actionItems: actionItems ?? this.actionItems,
    );
  }
}

class _SecurityController extends StateNotifier<_SecurityViewState> {
  final _SecurityControllerParams params;
  final securityServicesRepo = SecurityServicesRepo();

  _SecurityController(this.params) : super(_SecurityViewState.init()) {
    fetchStats();
    fetchStatusBreakDownData();
    fetchTrendData();
    fetchMyRequests();
  }

  List<SubServices> get drawerSubServices {
    final selected = <_SecurityRequestType, SubServices>{};
    for (final subService in params.subServicesList) {
      final type = _securityTypeFromName(subService.subServiceName);
      if (type != null) selected[type] = subService;
    }

    return _SecurityRequestType.values.map((type) {
      return selected[type] ??
          SubServices(serviceId: params.serviceId, subServiceName: type.title);
    }).toList();
  }

  SubServices get selectedSubService {
    final list = drawerSubServices;
    final index = state.selectedSubServiceIndex
        .clamp(0, list.length - 1)
        .toInt();
    return list[index];
  }

  _SecurityRequestType get selectedRequestType {
    final index = state.selectedSubServiceIndex
        .clamp(0, _SecurityRequestType.values.length - 1)
        .toInt();
    return _securityTypeFromName(selectedSubService.subServiceName) ??
        _SecurityRequestType.values[index];
  }

  String get selectedSubServiceTitle => selectedRequestType.title;

  int get selectedServiceId => selectedSubService.serviceId ?? params.serviceId;

  int get selectedSubServiceId => selectedSubService.id ?? 0;

  String get selectedSlug => selectedRequestType.slug;

  Map<String, dynamic> get selectedRequestIds => {
    'service_id': selectedServiceId,
    'sub_service_id': selectedSubServiceId,
  };

  List<int> get yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear - 1, currentYear, currentYear + 1];
  }

  void onSelectSubService(int index) {
    if (index == state.selectedSubServiceIndex) return;
    state = state.copyWith(
      selectedSubServiceIndex: index,
      isApproverView: false,
      statsData: FinancialServicesStatsData(),
      trendData: FinancialServicesTrendBreakdownData(),
      statusBreakdownData: FinancialStatusBreakdownData(),
      approvalStatsData: FinancialServicesStatsData(),
      approvalTrendData: FinancialServicesTrendBreakdownData(),
      approvalStatusBreakdownData: FinancialStatusBreakdownData(),
      myRequests: [],
      actionItems: [],
    );
    fetchStats();
    fetchStatusBreakDownData();
    fetchTrendData();
    fetchMyRequests();
  }

  void toggleViewMode(bool isApprover) {
    state = state.copyWith(isApproverView: isApprover);
    if (isApprover) {
      fetchApproverStats();
      fetchApproverStatusBreakDownData();
      fetchApproverTrendData();
      fetchApprovalRequests();
    } else {
      fetchStats();
      fetchStatusBreakDownData();
      fetchTrendData();
      fetchMyRequests();
    }
  }

  void onChangeStatusDropdownValue(String? value) {
    if (value == null) return;
    state = state.copyWith(selectedBreakdownValue: value);
    if (state.isApproverView) {
      fetchApproverStatusBreakDownData();
    } else {
      fetchStatusBreakDownData();
    }
  }

  void onChangedTrendYearValue(int? value) {
    if (value == null || value == state.selectedTrendYear) return;
    state = state.copyWith(selectedTrendYear: value);
    if (state.isApproverView) {
      fetchApproverTrendData();
    } else {
      fetchTrendData();
    }
  }

  void openCreateRequestForm() {
    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),
      builder: (_) => _SecurityRequestForm(stateController: this),
    );
  }

  void onPressRequestDetails(SecurityRequestItem request) {
    KAppX.router.push(
      SecurityServicesDetailsRoute(
        requestId: request.id ?? 0,
        slug: selectedSlug,
        title: request.requestName ?? selectedSubServiceTitle,
      ),
    );
  }

  Future<void> createRequest(Map<String, dynamic> data) async {
    try {
      state = state.copyWith(isLoading: true);
      await securityServicesRepo.createRequest(selectedSlug, data);
      KAppX.router.pop();
      fetchMyRequests();
      fetchStats();
      fetchStatusBreakDownData();
      fetchTrendData();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error submitting security request $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchStats() async {
    try {
      final statsData = await securityServicesRepo.fetchKPIStats(selectedSlug);
      if (statsData != null) state = state.copyWith(statsData: statsData);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security stats $e');
    }
  }

  Future<void> fetchApproverStats() async {
    try {
      final statsData = await securityServicesRepo.fetchApprovalKPIStats(
        selectedSlug,
      );
      if (statsData != null) {
        state = state.copyWith(approvalStatsData: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security approver stats $e');
    }
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusData = await securityServicesRepo.fetchStatusBreakdown(
        selectedSlug,
        {'time_period': state.selectedBreakdownValue.toLowerCase()},
      );
      if (statusData != null) {
        state = state.copyWith(statusBreakdownData: statusData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security status breakdown $e');
    }
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    try {
      final statusData = await securityServicesRepo
          .fetchApprovalStatusBreakdown(selectedSlug, {
            'time_period': state.selectedBreakdownValue.toLowerCase(),
          });
      if (statusData != null) {
        state = state.copyWith(approvalStatusBreakdownData: statusData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security approver status breakdown $e');
    }
  }

  Future<void> fetchTrendData() async {
    try {
      final trendData = await securityServicesRepo.fetchMonthlyTrend(
        selectedSlug,
        {'year': state.selectedTrendYear},
      );
      if (trendData != null) state = state.copyWith(trendData: trendData);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security trend $e');
    }
  }

  Future<void> fetchApproverTrendData() async {
    try {
      final trendData = await securityServicesRepo.fetchApprovalMonthlyTrend(
        selectedSlug,
        {'year': state.selectedTrendYear},
      );
      if (trendData != null) {
        state = state.copyWith(approvalTrendData: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security approver trend $e');
    }
  }

  Future<void> fetchMyRequests() async {
    try {
      final requests = await securityServicesRepo.fetchMyRequests(selectedSlug);
      if (requests != null) state = state.copyWith(myRequests: requests);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security my requests $e');
    }
  }

  Future<void> fetchApprovalRequests() async {
    try {
      final requests = await securityServicesRepo.fetchApprovalRequests(
        selectedSlug,
      );
      if (requests != null) state = state.copyWith(actionItems: requests);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching security approval requests $e');
    }
  }
}
