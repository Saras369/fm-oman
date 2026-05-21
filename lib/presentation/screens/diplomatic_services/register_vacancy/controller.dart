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
  final List<StationeryMyRequestItem> myRequests;
  final List<StationeryMaterialItem> materials;
  final List<StationeryOfficeItem> officeList;
  final StationeryMaterialItem selectedMaterial;
  final StationeryOfficeItem selectedOffice;
  final ApprovalKpiStatsItem approvalKpiStats;
  final FinancialServicesStatsData kpiStats;
  final FinancialServicesTrendBreakdownData monthlyTrend;
  final FinancialServicesTrendBreakdownData approvalMonthlyTrend;
  final FinancialStatusBreakdownData statusBreakdown;
  final FinancialStatusBreakdownData approvalStatusBreakdown;
  final bool isValidate;
  final String selectedBreakdownValue;
  final String selectedTrendValue;
  final String requestPreparationDate;

  _ViewState({
    required this.isLoading,
    required this.selectedMonth,
    required this.selectedYear,
    required this.isValidate,
    required this.myRequests,
    required this.selectedBreakdownValue,
    required this.selectedTrendValue,
    required this.approvalKpiStats,
    required this.monthlyTrend,
    required this.approvalMonthlyTrend,
    required this.statusBreakdown,
    required this.approvalStatusBreakdown,
    required this.isMyRequest,
    required this.kpiStats,
    required this.materials,
    required this.selectedMaterial,
    required this.requestPreparationDate,
    required this.officeList,
    required this.selectedOffice,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isMyRequest: true,
        selectedMonth: '',
        selectedYear: '',
        isValidate: false,
        myRequests: [],
        selectedBreakdownValue: 'Yearly',
        selectedTrendValue: '2025',
        approvalKpiStats: ApprovalKpiStatsItem(),
        monthlyTrend: FinancialServicesTrendBreakdownData(),
        approvalMonthlyTrend: FinancialServicesTrendBreakdownData(),
        statusBreakdown: FinancialStatusBreakdownData(),
        approvalStatusBreakdown: FinancialStatusBreakdownData(),
        kpiStats: FinancialServicesStatsData(),
        materials: [],
        selectedMaterial: StationeryMaterialItem(),
        requestPreparationDate: '',
        officeList: [],
        selectedOffice: StationeryOfficeItem(),
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isMyRequest,
    String? selectedMonth,
    String? selectedYear,
    List<StationeryMyRequestItem>? myRequests,
    List<HelpDeskCategoryItem>? categories,
    List<HelpDeskSubCategoryItem>? subCategories,
    List<HelpDeskIssueTypeItem>? issueTypes,
    bool? isValidate,
    String? selectedBreakdownValue,
    String? selectedTrendValue,
    ApprovalKpiStatsItem? approvalKpiStats,
    FinancialServicesTrendBreakdownData? monthlyTrend,
    FinancialServicesTrendBreakdownData? approvalMonthlyTrend,
    FinancialStatusBreakdownData? statusBreakdown,
    FinancialStatusBreakdownData? approvalStatusBreakdown,
    HelpDeskCategoryItem? selectedCategory,
    HelpDeskSubCategoryItem? selectedSubCategories,
    HelpDeskIssueTypeItem? selectedIssueTypes,
    FinancialServicesStatsData? kpiStats,
    List<StationeryMaterialItem>? materials,
    StationeryMaterialItem? selectedMaterial,
    String? requestPreparationDate,
    List<StationeryOfficeItem>? officeList,
    StationeryOfficeItem? selectedOffice,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      isValidate: isValidate ?? this.isValidate,
      myRequests: myRequests ?? this.myRequests,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendValue: selectedTrendValue ?? this.selectedTrendValue,
      approvalKpiStats: approvalKpiStats ?? this.approvalKpiStats,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      approvalMonthlyTrend: approvalMonthlyTrend ?? this.approvalMonthlyTrend,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      isMyRequest: isMyRequest ?? this.isMyRequest,
      kpiStats: kpiStats ?? this.kpiStats,
      materials: materials ?? this.materials,
      selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      requestPreparationDate:
          requestPreparationDate ?? this.requestPreparationDate,
      officeList: officeList ?? this.officeList,
      selectedOffice: selectedOffice ?? this.selectedOffice,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init()) {
    materialNameController = TextEditingController();
    requestPrepationDateController = TextEditingController();

    fetchApproverKPIStats();
    fetchKPIStats();
    fetchMyRequests();
    fetchMonthlyTrendData();
    fetchApproverMonthlyTrendData();
    fetchStatusBreakDownData();
    fetchApproverStatusBreakDownData();
  }

  late TextEditingController requestPrepationDateController;
  late TextEditingController materialNameController;

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

  void onPressRequestMenuActionItem() {
    // KAppX.extendedRouter.dialog.showKDialog(
    //   insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),

    //   builder: (context) {
    //     return TransferToMissionRequestForm(params: params);
    //   },
    // );
    KAppX.router.push(
      CreateTransferToMissionRequestRoute(serviceId: 0, subServiceId: 0),
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

  final missionTransferRepo = TransferToMissionRepo();

  Future<void> fetchApproverKPIStats() async {
    try {
      final statsData = await missionTransferRepo.fetchApproverKPIStats();

      if (statsData != null) {
        state = state.copyWith(approvalKpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchKPIStats() async {
    try {
      final statsData = await missionTransferRepo.fetchMyKPIStats();

      if (statsData != null) {
        state = state.copyWith(kpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusBrekdownData = await missionTransferRepo.fetchStatusBreakdown(
        {'time_period': state.selectedBreakdownValue},
        true,
      );

      if (statusBrekdownData != null) {
        state = state.copyWith(statusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    try {
      final statusBrekdownData = await missionTransferRepo.fetchStatusBreakdown(
        {'time_period': state.selectedBreakdownValue},
        false,
      );

      if (statusBrekdownData != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchMonthlyTrendData() async {
    try {
      final trendData = await missionTransferRepo.fetchMonthlyTrend({
        'year': 2025,
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
      final trendData = await missionTransferRepo.fetchMonthlyTrend({
        'year': 2025,
      }, false);

      if (trendData != null) {
        state = state.copyWith(approvalMonthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchMyRequests() async {
    // try {
    //   final myRequests = await missionTransferRepo.fetchStationeryMyRequests();

    //   if (myRequests != null) {
    //     state = state.copyWith(myRequests: myRequests);
    //   }
    // } on ApiException catch (apiError) {
    //   Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    // } catch (e) {}
  }

  void onSwitchTabsInMyRequestCard(int index) {
    state = state.copyWith(isMyRequest: index == 0 ? true : false);
  }

  void onPressRequestDetails(int requestId) {
    KAppX.router.push(HelpDeskDetailsRoute(requestId: requestId));
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
      state = state.copyWith(
        requestPreparationDate: pickedDate.formattedDateAsYearMonthDate,
      );
      requestPrepationDateController.text =
          pickedDate.formattedDateAsYearMonthDate;
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
    materialNameController.dispose();
    requestPrepationDateController.dispose();
    super.dispose();
  }
}
