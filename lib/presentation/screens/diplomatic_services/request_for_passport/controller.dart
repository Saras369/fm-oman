part of 'view.dart';

class _VSControllerParams extends Equatable {
  final int serviceId;
  final List<SubServices> subServicesList;

  _VSControllerParams({required this.serviceId, required this.subServicesList});

  @override
  List<Object?> get props => [serviceId, subServicesList];
}

final _paramProvider = Provider<_VSControllerParams>((ref) {
  throw UnimplementedError();
});

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      final stateController = _VSController(params);

      // stateController.initState();

      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final bool isMyRequest;
  final String selectedMonth;
  final String selectedYear;
  final List<PassportMyRequestItem> myRequests;
  final List<PassportMyRequestItem> actionItems;
  final ApprovalKpiStatsItem approvalKpiStats;
  final FinancialServicesStatsData kpiStats;
  final FinancialServicesTrendBreakdownData monthlyTrend;
  final FinancialServicesTrendBreakdownData approvalMonthlyTrend;
  final FinancialStatusBreakdownData statusBreakdown;
  final FinancialStatusBreakdownData approvalStatusBreakdown;
  final bool isValidate;
  final String selectedBreakdownValue;
  final int selectedTrendYear;

  _ViewState({
    required this.isLoading,
    required this.selectedMonth,
    required this.selectedYear,
    required this.isValidate,
    required this.myRequests,
    required this.actionItems,
    required this.selectedBreakdownValue,
    required this.selectedTrendYear,
    required this.approvalKpiStats,
    required this.monthlyTrend,
    required this.approvalMonthlyTrend,
    required this.statusBreakdown,
    required this.approvalStatusBreakdown,
    required this.isMyRequest,
    required this.kpiStats,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isMyRequest: true,
        selectedMonth: '',
        selectedYear: '',
        isValidate: false,
        myRequests: [],
        actionItems: [],
        selectedBreakdownValue: 'Yearly',
        selectedTrendYear: DateTime.now().year,
        approvalKpiStats: ApprovalKpiStatsItem(),
        monthlyTrend: FinancialServicesTrendBreakdownData(),
        approvalMonthlyTrend: FinancialServicesTrendBreakdownData(),
        statusBreakdown: FinancialStatusBreakdownData(),
        approvalStatusBreakdown: FinancialStatusBreakdownData(),
        kpiStats: FinancialServicesStatsData(),
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isMyRequest,
    String? selectedMonth,
    String? selectedYear,
    List<PassportMyRequestItem>? myRequests,
    List<PassportMyRequestItem>? actionItems,
    List<HelpDeskCategoryItem>? categories,
    List<HelpDeskSubCategoryItem>? subCategories,
    List<HelpDeskIssueTypeItem>? issueTypes,
    bool? isValidate,
    String? selectedBreakdownValue,
    int? selectedTrendYear,
    ApprovalKpiStatsItem? approvalKpiStats,
    FinancialServicesTrendBreakdownData? monthlyTrend,
    FinancialServicesTrendBreakdownData? approvalMonthlyTrend,
    FinancialStatusBreakdownData? statusBreakdown,
    FinancialStatusBreakdownData? approvalStatusBreakdown,
    HelpDeskCategoryItem? selectedCategory,
    HelpDeskSubCategoryItem? selectedSubCategories,
    HelpDeskIssueTypeItem? selectedIssueTypes,
    FinancialServicesStatsData? kpiStats,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      isValidate: isValidate ?? this.isValidate,
      myRequests: myRequests ?? this.myRequests,
      actionItems: actionItems ?? this.actionItems,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendYear: selectedTrendYear ?? this.selectedTrendYear,
      approvalKpiStats: approvalKpiStats ?? this.approvalKpiStats,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      approvalMonthlyTrend: approvalMonthlyTrend ?? this.approvalMonthlyTrend,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      isMyRequest: isMyRequest ?? this.isMyRequest,
      kpiStats: kpiStats ?? this.kpiStats,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init()) {
    officialUseNumberController = TextEditingController();
    passportTypeController = TextEditingController();
    applicantCivilIdController = TextEditingController();
    applicantNameController = TextEditingController();
    applicantPassportNumberController = TextEditingController();
    applicantTypeController = TextEditingController();
    occupationController = TextEditingController();
    purposeOfApplicationController = TextEditingController();
    approvedMissionTravellerIDController = TextEditingController();

    fetchKPIStats();
    fetchMyRequests();
    fetchMonthlyTrendData();
    fetchStatusBreakDownData();
  }

  late TextEditingController officialUseNumberController;
  late TextEditingController passportTypeController;
  late TextEditingController applicantCivilIdController;
  late TextEditingController applicantNameController;
  late TextEditingController applicantPassportNumberController;
  late TextEditingController applicantTypeController;
  late TextEditingController occupationController;
  late TextEditingController purposeOfApplicationController;
  late TextEditingController approvedMissionTravellerIDController;

  final formKey = GlobalKey<FormState>();

  // void initState() {
  //   yearController = TextEditingController();
  //   monthController = TextEditingController();
  //   reasonController = TextEditingController();

  //   fetchStats();
  //   // fetchStatusBreakDownData();
  //   // fetchTrendData();
  // }

  final List<String> priorityType = ['High', 'Medium', 'Low'];

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

  Map<String, ChartData> returnStatusBreakdownData() {
    final statusBreakdown = state.isMyRequest
        ? state.statusBreakdown
        : state.approvalStatusBreakdown;

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

    return statusData;
  }

  List<int> returnMonthlyTrendData() {
    final monthlyTrend = state.isMyRequest
        ? state.monthlyTrend.monthlyTrend
        : state.approvalMonthlyTrend.monthlyTrend;

    List<int> trendList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if (monthlyTrend?.isNotEmpty == true) {
      for (var i = 0; i < monthlyTrend!.length; i++) {
        trendList[i] = monthlyTrend[i].total ?? 0;
      }
    }
    return trendList;
  }

  void onPressRequestMenuActionItem() {
    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),

      builder: (context) {
        return PassportRequestForm(params: params);
      },
    );
  }

  // void onPressSubmit(String title) {
  //   if (formKey.currentState?.validate() == true) {
  //     if (title == 'Request for Payslip') {
  //       createPaySlipRequest();
  //     }
  // }

  // void createPaySlipRequest() {
  //   final data = {
  //     "service_id": params.serviceId,
  //     "sub_service_id": determineSubServiceId('Payslip Request'),
  //     "payslip_month": "${state.selectedYear}-${state.selectedMonth}",
  //     "payslip_year": state.selectedYear,
  //     "remarks": reasonController.text,
  //   };

  //   financialServiceRepo.createPaySlipRequest(data).then((value) {
  //     KAppX.router.pop();
  //     KAppX.router.pop();
  //   });
  // }

  final requestForPassportRepo = RequestForPassportRepo();

  Future<void> fetchApproverKPIStats() async {
    try {
      final statsData = await requestForPassportRepo.fetchApproverKPIStats();

      if (statsData != null) {
        state = state.copyWith(approvalKpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchKPIStats() async {
    try {
      final statsData = await requestForPassportRepo.fetchMyKPIStats();

      if (statsData != null) {
        state = state.copyWith(kpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusBrekdownData = await requestForPassportRepo
          .fetchStatusBreakdown({
            'time_period': state.selectedBreakdownValue.toLowerCase(),
          }, true);

      if (statusBrekdownData != null) {
        state = state.copyWith(statusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  onChangedStatusBreakDownValue(String? val) {
    if (val != null && state.selectedBreakdownValue != val) {
      state = state.copyWith(selectedBreakdownValue: val);
      if (state.isMyRequest) {
        fetchStatusBreakDownData();
      } else {
        fetchApproverStatusBreakDownData();
      }
    }
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    final data = {'time_period': state.selectedBreakdownValue.toLowerCase()};
    try {
      final statusBrekdownData = await requestForPassportRepo
          .fetchStatusBreakdown(data, false);

      if (statusBrekdownData != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchMonthlyTrendData() async {
    try {
      final trendData = await requestForPassportRepo.fetchMonthlyTrend({
        'year': state.selectedTrendYear,
      }, true);

      if (trendData != null) {
        state = state.copyWith(monthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchApproverMonthlyTrendData() async {
    try {
      final trendData = await requestForPassportRepo.fetchMonthlyTrend({
        'year': state.selectedTrendYear,
      }, false);

      if (trendData != null) {
        state = state.copyWith(approvalMonthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  List<int> get yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear - 1, currentYear, currentYear + 1];
  }

  void onChangedTrendYearValue(int? val) {
    if (val != null && state.selectedTrendYear != val) {
      state = state.copyWith(selectedTrendYear: val);
      state.isMyRequest
          ? fetchMonthlyTrendData()
          : fetchApproverMonthlyTrendData();
    }
  }

  Future<void> fetchMyRequests() async {
    try {
      final myRequests = await requestForPassportRepo.fetchPassportMyRequests(
        0,
        100,
      );

      if (myRequests != null) {
        state = state.copyWith(myRequests: myRequests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchPassportApprovalRequests() async {
    try {
      final actionItems = await requestForPassportRepo
          .fetchPassportApprovalRequests(0, 100);

      if (actionItems != null) {
        state = state.copyWith(actionItems: actionItems);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSwitchTabsInMyRequestCard(int index) {
    state = state.copyWith(isMyRequest: index == 0 ? true : false);
    if (index == 0) {
      fetchKPIStats();
      fetchMonthlyTrendData();
      fetchStatusBreakDownData();
      fetchMyRequests();
    } else {
      fetchApproverKPIStats();
      fetchApproverMonthlyTrendData();
      fetchApproverStatusBreakDownData();
      fetchPassportApprovalRequests();
    }
  }

  void onPressRequestDetails(int requestId) {
    KAppX.router.push(PassportServiceDetailsRoute(requestId: requestId));
  }

  Future<void> onPressRequestPreparationDate() async {
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: DateTime(DateTime.now().year),
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (pickedDate != null) {
      state = state.copyWith();
    }
  }

  List<String> determineKPIStats() {
    final kpi = state.kpiStats;
    final approverKPI = state.approvalKpiStats;
    final isMyRequest = state.isMyRequest;
    List<String> kpiList = [];
    if (isMyRequest) {
      kpiList = [
        '${kpi.total ?? 0}',
        '${kpi.completed ?? 0}',
        '${kpi.pending ?? 0}',
        '${kpi.rejected ?? 0}',
      ];
    } else {
      kpiList = [
        '${approverKPI.totalAssignedToMe ?? 0}',
        '${approverKPI.approvedByMe ?? 0}',
        '${approverKPI.pendingMyApproval ?? 0}',
        '${approverKPI.rejectedByMe ?? 0}',
      ];
    }
    return kpiList;
  }

  @override
  void dispose() {
    officialUseNumberController.dispose();
    passportTypeController.dispose();
    applicantCivilIdController.dispose();
    applicantNameController.dispose();
    applicantPassportNumberController.dispose();
    applicantTypeController.dispose();
    occupationController.dispose();
    purposeOfApplicationController.dispose();
    approvedMissionTravellerIDController.dispose();

    super.dispose();
  }
}
