part of 'view.dart';

class _VSControllerParams {
  final int serviceId;
  final List<SubServices> subServicesList;

  const _VSControllerParams({
    required this.serviceId,
    required this.subServicesList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VSControllerParams &&
        other.serviceId == serviceId &&
        other.subServicesList == subServicesList;
  }

  @override
  int get hashCode => Object.hash(serviceId, subServicesList);
}

class _ViewState {
  final bool isLoading;
  final FinancialServicesStatsData statsData;
  final FinancialStatusBreakdownData statusBreakdownData;
  final FinancialServicesTrendBreakdownData trendData;
  final FinancialServicesStatsData approvalStatsData;
  final FinancialStatusBreakdownData approvalStatusBreakdownData;
  final FinancialServicesTrendBreakdownData approvalTrendData;
  final bool isApproverView;
  final String selectedBreakdownValue;
  final int selectedTrendYear;
  final List<StayAfterHoursRequestItem> myRequests;
  final List<StayAfterHoursRequestItem> actionItems;

  const _ViewState({
    required this.isLoading,
    required this.statsData,
    required this.statusBreakdownData,
    required this.trendData,
    required this.approvalStatsData,
    required this.approvalStatusBreakdownData,
    required this.approvalTrendData,
    required this.isApproverView,
    required this.selectedBreakdownValue,
    required this.selectedTrendYear,
    required this.myRequests,
    required this.actionItems,
  });

  factory _ViewState.init() => _ViewState(
    isLoading: false,
    statsData: FinancialServicesStatsData(),
    statusBreakdownData: FinancialStatusBreakdownData(),
    trendData: FinancialServicesTrendBreakdownData(),
    approvalStatsData: FinancialServicesStatsData(),
    approvalStatusBreakdownData: FinancialStatusBreakdownData(),
    approvalTrendData: FinancialServicesTrendBreakdownData(),
    isApproverView: false,
    selectedBreakdownValue: 'Yearly',
    selectedTrendYear: DateTime.now().year,
    myRequests: const [],
    actionItems: const [],
  );

  _ViewState copyWith({
    bool? isLoading,
    FinancialServicesStatsData? statsData,
    FinancialStatusBreakdownData? statusBreakdownData,
    FinancialServicesTrendBreakdownData? trendData,
    FinancialServicesStatsData? approvalStatsData,
    FinancialStatusBreakdownData? approvalStatusBreakdownData,
    FinancialServicesTrendBreakdownData? approvalTrendData,
    bool? isApproverView,
    String? selectedBreakdownValue,
    int? selectedTrendYear,
    List<StayAfterHoursRequestItem>? myRequests,
    List<StayAfterHoursRequestItem>? actionItems,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      statsData: statsData ?? this.statsData,
      statusBreakdownData: statusBreakdownData ?? this.statusBreakdownData,
      trendData: trendData ?? this.trendData,
      approvalStatsData: approvalStatsData ?? this.approvalStatsData,
      approvalStatusBreakdownData:
          approvalStatusBreakdownData ?? this.approvalStatusBreakdownData,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      isApproverView: isApproverView ?? this.isApproverView,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendYear: selectedTrendYear ?? this.selectedTrendYear,
      myRequests: myRequests ?? this.myRequests,
      actionItems: actionItems ?? this.actionItems,
    );
  }
}

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      return _VSController(params);
    });

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;
  final _repo = LeaveRepo();

  _VSController(this.params) : super(_ViewState.init()) {
    _loadMyRequestsBundle();
  }

  SubServices? get selectedSubService {
    for (final subService in params.subServicesList) {
      final name = subService.subServiceName?.toLowerCase() ?? '';
      if (name.contains('stay') ||
          name.contains('working hours') ||
          name.contains('after hours')) {
        return subService;
      }
    }
    return null;
  }

  int get selectedServiceId => selectedSubService?.serviceId ?? params.serviceId;
  int get selectedSubServiceId => selectedSubService?.id ?? 0;
  bool get hasSelectedService {
    final hasService = selectedServiceId > 0 && selectedSubServiceId > 0;
    if (!hasService) {
      ShowFlutterToast().showFlutterToastFailure(
        'Stay after working hours sub-service missing',
      );
    }
    return hasService;
  }

  Map<String, dynamic> get selectedServiceParams => {
    'service_id': selectedServiceId,
    'sub_service_id': selectedSubServiceId,
  };

  Map<String, dynamic> get selectedListParams => {
    'offset': 1,
    'limit': 10,
    ...selectedServiceParams,
  };

  Map<String, dynamic> get selectedBreakdownParams => {
    'time_period': state.selectedBreakdownValue.toLowerCase(),
    ...selectedServiceParams,
  };

  Map<String, dynamic> get selectedTrendParams => {
    'year': state.selectedTrendYear,
    ...selectedServiceParams,
  };

  List<int> get yearOptions {
    final y = DateTime.now().year;
    return [y - 1, y, y + 1];
  }

  Future<void> setRequestListTab(int index) async {
    final isApprover = index == 1;
    state = state.copyWith(isApproverView: isApprover);
    await refreshCurrentTab();
  }

  Future<void> refreshCurrentTab() async {
    if (state.isApproverView) {
      await _loadApproverBundle();
    } else {
      await _loadMyRequestsBundle();
    }
  }

  Future<void> _loadMyRequestsBundle() async {
    if (!hasSelectedService) return;
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _repo.fetchStayAfterHoursStats(selectedServiceParams),
        _repo.fetchStayAfterHoursStatusBreakdown(selectedBreakdownParams),
        _repo.fetchStayAfterHoursTrendBreakdown(selectedTrendParams),
        _repo.fetchStayAfterHoursRequests(selectedListParams),
      ]);

      state = state.copyWith(
        statsData: results[0] as FinancialServicesStatsData? ?? state.statsData,
        statusBreakdownData:
            results[1] as FinancialStatusBreakdownData? ??
            state.statusBreakdownData,
        trendData:
            results[2] as FinancialServicesTrendBreakdownData? ?? state.trendData,
        myRequests:
            results[3] as List<StayAfterHoursRequestItem>? ?? state.myRequests,
      );
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching stay after hours my bundle $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _loadApproverBundle() async {
    if (!hasSelectedService) return;
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _repo.fetchStayAfterHoursStats(selectedServiceParams, isApprover: true),
        _repo.fetchStayAfterHoursStatusBreakdown(
          selectedBreakdownParams,
          isApprover: true,
        ),
        _repo.fetchStayAfterHoursTrendBreakdown(
          selectedTrendParams,
          isApprover: true,
        ),
        _repo.fetchStayAfterHoursRequests(selectedListParams, isApprover: true),
      ]);

      state = state.copyWith(
        approvalStatsData:
            results[0] as FinancialServicesStatsData? ?? state.approvalStatsData,
        approvalStatusBreakdownData:
            results[1] as FinancialStatusBreakdownData? ??
            state.approvalStatusBreakdownData,
        approvalTrendData:
            results[2] as FinancialServicesTrendBreakdownData? ??
            state.approvalTrendData,
        actionItems:
            results[3] as List<StayAfterHoursRequestItem>? ?? state.actionItems,
      );
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching stay after hours approver bundle $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void onChangeStatusDropdownValue(String? value) {
    if (value == null || value == state.selectedBreakdownValue) return;
    state = state.copyWith(selectedBreakdownValue: value);
    refreshCurrentTab();
  }

  void onChangedTrendYearValue(int? year) {
    if (year == null || year == state.selectedTrendYear) return;
    state = state.copyWith(selectedTrendYear: year);
    refreshCurrentTab();
  }
}
