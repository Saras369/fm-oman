part of 'view.dart';
// {  "service_id": 2,
//   "sub_service_id": 8,
//   "certificate_purpose": "For visa application"
// }

class _VSControllerParams extends Equatable {
  final int serviceId;
  final List<SubServices> subServiceList;

  const _VSControllerParams({
    required this.serviceId,
    required this.subServiceList,
  });

  @override
  List<Object?> get props => [serviceId, subServiceList];
}

final _paramProvider = Provider<_VSControllerParams>((ref) {
  throw UnimplementedError();
});

String _normalizedFinancialSubServiceName(String? name) {
  return name?.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim() ?? '';
}

int? _financialSubServiceRank(SubServices subService) {
  final name = _normalizedFinancialSubServiceName(subService.subServiceName);
  final compactName = name.replaceAll(' ', '');

  if (compactName.contains('payslip')) return 0;
  if (name.contains('salary') && name.contains('certificate')) return 1;
  if (name.contains('allowance')) return 2;
  if (name.contains('reimbursement')) return 3;
  if (name.contains('bank account') &&
      name.contains('change') &&
      !name.contains('mission') &&
      !name.contains('open/close') &&
      !name.contains('special')) {
    return 4;
  }

  return null;
}

List<int> _visibleFinancialSubServiceIndexes(List<SubServices> subServices) {
  final entries = <MapEntry<int, int>>[];

  for (var i = 0; i < subServices.length; i++) {
    final rank = _financialSubServiceRank(subServices[i]);
    if (rank != null) {
      entries.add(MapEntry(i, rank));
    }
  }

  entries.sort((a, b) {
    final rankCompare = a.value.compareTo(b.value);
    return rankCompare == 0 ? a.key.compareTo(b.key) : rankCompare;
  });

  return entries.map((entry) => entry.key).toList();
}

const _payslipEligibleMonthCount = 6;

List<DateTime> _eligiblePayslipPeriods([DateTime? referenceDate]) {
  final now = referenceDate ?? DateTime.now();
  final periods = <DateTime>[];
  var year = now.year;
  var month = now.month - 1;
  if (month < 1) {
    month = 12;
    year -= 1;
  }

  for (var i = 0; i < _payslipEligibleMonthCount; i++) {
    periods.add(DateTime(year, month));
    month -= 1;
    if (month < 1) {
      month = 12;
      year -= 1;
    }
  }

  return periods;
}

List<int> _eligiblePayslipYears(List<DateTime> periods) {
  final years = periods.map((period) => period.year).toSet()
    ..add(DateTime.now().year);
  final sortedYears = years.toList()..sort((a, b) => b.compareTo(a));
  return sortedYears;
}

List<int> _eligiblePayslipMonthsForYear(int year, List<DateTime> periods) {
  final months = periods
      .where((period) => period.year == year)
      .map((period) => period.month)
      .toList();
  months.sort((a, b) => b.compareTo(a));
  return months;
}

String _payslipMonthName(int month) {
  return DateFormat('MMMM').format(DateTime(2000, month));
}

String _financialSubServiceDrawerLabel(SubServices subService) {
  switch (_financialSubServiceRank(subService)) {
    case 0:
      return 'Request for Pay slip';
    case 1:
      return 'Request for Salary Certificate';
    case 2:
      return 'Request for Allowance';
    case 3:
      return 'Request for Reimbursement';
    case 4:
      return 'Request for change of Bank Account';
    default:
      return subService.subServiceName ?? 'Financial Services';
  }
}

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      final stateController = _VSController(params);

      // stateController.initState();

      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String selectedMonth;
  final String selectedYear;
  final FinancialServicesStatsData statsData;
  final FinancialServicesTrendBreakdownData trendData;
  final FinancialStatusBreakdownData statusBreakdownData;
  final FinancialServicesStatsData approvalStatsData;
  final FinancialServicesTrendBreakdownData approvalTrendData;
  final FinancialStatusBreakdownData approvalStatusBreakdownData;
  final bool isApproverView;
  final List<BankNameItem> bankNames;
  final List<CurrencyItem> currencyList;
  final CurrencyItem selectedCurrency;
  final List<AllowanceTypeItem> allownceTypeList;
  final List<FinancialServiceRequestItem> myRequests;
  final List<FinancialServiceRequestItem> actionItems;
  final BankNameItem existingBankName;
  final BankNameItem newBankName;
  final AllowanceTypeItem selectedAllowanceType;
  final bool isValidate;
  final String selectedBreakdownValue;
  final String selectedTrendValue;
  final int selectedTrendYear;
  final int selectedSubServiceIndex;
  final int requestListTabIndex;

  _ViewState({
    required this.isLoading,
    required this.selectedMonth,
    required this.selectedYear,
    required this.statsData,
    required this.trendData,
    required this.statusBreakdownData,
    required this.approvalStatsData,
    required this.approvalTrendData,
    required this.approvalStatusBreakdownData,
    required this.isApproverView,
    required this.bankNames,
    required this.currencyList,
    required this.allownceTypeList,
    required this.existingBankName,
    required this.newBankName,
    required this.selectedCurrency,
    required this.selectedAllowanceType,
    required this.isValidate,
    required this.myRequests,
    required this.actionItems,
    required this.selectedBreakdownValue,
    required this.selectedTrendValue,
    required this.selectedTrendYear,
    required this.selectedSubServiceIndex,
    required this.requestListTabIndex,
  });

  factory _ViewState.init() {
    return _ViewState(
      isLoading: false,
      selectedMonth: '',
      selectedYear: DateTime.now().year.toString(),
      statsData: FinancialServicesStatsData(),
      trendData: FinancialServicesTrendBreakdownData(),
      statusBreakdownData: FinancialStatusBreakdownData(),
      approvalStatsData: FinancialServicesStatsData(),
      approvalTrendData: FinancialServicesTrendBreakdownData(),
      approvalStatusBreakdownData: FinancialStatusBreakdownData(),
      isApproverView: false,
      bankNames: [],
      myRequests: [],
      actionItems: [],
      currencyList: [],
      allownceTypeList: [],
      selectedCurrency: CurrencyItem(),
      existingBankName: BankNameItem(),
      newBankName: BankNameItem(),
      selectedAllowanceType: AllowanceTypeItem(),
      isValidate: false,
      selectedBreakdownValue: 'Yearly',
      selectedTrendValue: 'Yearly',
      selectedTrendYear: DateTime.now().year,
      selectedSubServiceIndex: 0,
      requestListTabIndex: 0,
    );
  }

  _ViewState copyWith({
    bool? isLoading,
    String? selectedMonth,
    String? selectedYear,
    FinancialServicesStatsData? statsData,
    FinancialServicesTrendBreakdownData? trendData,
    FinancialStatusBreakdownData? statusBreakdownData,
    FinancialServicesStatsData? approvalStatsData,
    FinancialServicesTrendBreakdownData? approvalTrendData,
    FinancialStatusBreakdownData? approvalStatusBreakdownData,
    bool? isApproverView,
    List<BankNameItem>? bankNames,
    List<CurrencyItem>? currencyList,
    CurrencyItem? selectedCurrency,
    List<AllowanceTypeItem>? allownceTypeList,
    List<FinancialServiceRequestItem>? myRequests,
    List<FinancialServiceRequestItem>? actionItems,
    BankNameItem? existingBankName,
    BankNameItem? newBankName,
    AllowanceTypeItem? selectedAllowanceType,
    bool? isValidate,
    String? selectedBreakdownValue,
    String? selectedTrendValue,
    int? selectedTrendYear,
    int? selectedSubServiceIndex,
    int? requestListTabIndex,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      statsData: statsData ?? this.statsData,
      trendData: trendData ?? this.trendData,
      statusBreakdownData: statusBreakdownData ?? this.statusBreakdownData,
      approvalStatsData: approvalStatsData ?? this.approvalStatsData,
      approvalTrendData: approvalTrendData ?? this.approvalTrendData,
      approvalStatusBreakdownData:
          approvalStatusBreakdownData ?? this.approvalStatusBreakdownData,
      isApproverView: isApproverView ?? this.isApproverView,
      bankNames: bankNames ?? this.bankNames,
      myRequests: myRequests ?? this.myRequests,
      actionItems: actionItems ?? this.actionItems,
      currencyList: currencyList ?? this.currencyList,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      allownceTypeList: allownceTypeList ?? this.allownceTypeList,
      existingBankName: existingBankName ?? this.existingBankName,
      newBankName: newBankName ?? this.newBankName,
      selectedAllowanceType:
          selectedAllowanceType ?? this.selectedAllowanceType,
      isValidate: isValidate ?? this.isValidate,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendValue: selectedTrendValue ?? this.selectedTrendValue,
      selectedTrendYear: selectedTrendYear ?? this.selectedTrendYear,
      selectedSubServiceIndex:
          selectedSubServiceIndex ?? this.selectedSubServiceIndex,
      requestListTabIndex: requestListTabIndex ?? this.requestListTabIndex,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init()) {
    yearController = TextEditingController();
    monthController = TextEditingController();
    reasonController = TextEditingController();
    existingAccountNumController = TextEditingController();
    newAccountNumController = TextEditingController();
    ifscController = TextEditingController();
    accountNameController = TextEditingController();
    effectiveFromController = TextEditingController();
    alllownceAmountController = TextEditingController();
    contactNumberController = TextEditingController();

    final visibleSubServices = _visibleFinancialSubServiceIndexes(
      params.subServiceList,
    );
    if (visibleSubServices.isNotEmpty) {
      state = state.copyWith(selectedSubServiceIndex: visibleSubServices.first);
    }

    fetchStats();
    fetchStatusBreakDownData();
    fetchTrendData();
    fetchBankNames();
    fetchCurrencyList();
    fetchAllowanceTypeList();
    fetchFinancialServiceMyRequest();
  }

  late TextEditingController monthController;
  late TextEditingController yearController;
  late TextEditingController reasonController;
  late TextEditingController existingAccountNumController;
  late TextEditingController newAccountNumController;
  late TextEditingController ifscController;
  late TextEditingController accountNameController;
  late TextEditingController effectiveFromController;
  late TextEditingController alllownceAmountController;
  late TextEditingController contactNumberController;

  final formKey = GlobalKey<FormState>();

  // void initState() {
  //   yearController = TextEditingController();
  //   monthController = TextEditingController();
  //   reasonController = TextEditingController();

  //   fetchStats();
  //   // fetchStatusBreakDownData();
  //   // fetchTrendData();
  // }

  final requestActions = [
    RequestAction(
      label: 'Request for Payslip',
      bgColor: Color(0xFFFFF3E1),
      iconColor: Color(0xFFD78D24),
      textColor: Color(0xFFD78D24),
      // Add your onTap logic
    ),
    RequestAction(
      label: 'Request for Salary Certificate',
      bgColor: Color(0xFFFFF5EF),
      iconColor: Color(0xFFF06C44),
      textColor: Color(0xFFF06C44),
    ),
    RequestAction(
      label: 'Request for Allowance',
      bgColor: Color(0xFFF3F6FF),
      iconColor: Color(0xFF6578CE),
      textColor: Color(0xFF6578CE),
    ),
    RequestAction(
      label: 'Request for Reimbursement',
      bgColor: Color(0xFFE8F8F5),
      iconColor: Color(0xFF25A79C),
      textColor: Color(0xFF25A79C),
    ),
    RequestAction(
      label: 'Request for Change of Bank Account',
      bgColor: Color(0xFFFFF0F5),
      iconColor: Color(0xFFE15191),
      textColor: Color(0xFFE15191),
    ),
  ];

  SubServices get selectedSubService {
    if (params.subServiceList.isEmpty) return SubServices();
    final index = state.selectedSubServiceIndex
        .clamp(0, params.subServiceList.length - 1)
        .toInt();
    return params.subServiceList[index];
  }

  int get selectedSubServiceId => selectedSubService.id ?? 0;

  String get selectedPayslipMonth {
    final month = int.tryParse(state.selectedMonth);
    final paddedMonth = month != null
        ? month.toString().padLeft(2, '0')
        : state.selectedMonth.padLeft(2, '0');
    return '${state.selectedYear}-$paddedMonth';
  }

  String get selectedSubServiceTitle {
    final name = selectedSubService.subServiceName;
    if (name == null || name.isEmpty) return 'Financial Services';
    return name;
  }

  Map<String, dynamic> get selectedServiceParams => {
    'service_id': params.serviceId,
    'sub_service_id': selectedSubServiceId,
  };

  Map<String, dynamic> get selectedListParams => {
    'offset': 1,
    'limit': 10,
    ...selectedServiceParams,
  };

  RequestAction get selectedRequestAction {
    final selectedName = selectedSubServiceTitle.toLowerCase();

    bool matches(String label) {
      final normalizedLabel = label.toLowerCase();
      if (selectedName.contains('payslip')) {
        return normalizedLabel.contains('payslip');
      }
      if (selectedName.contains('salary')) {
        return normalizedLabel.contains('salary');
      }
      if (selectedName.contains('allowance')) {
        return normalizedLabel.contains('allowance');
      }
      if (selectedName.contains('reimbursement')) {
        return normalizedLabel.contains('reimbursement');
      }
      if (selectedName.contains('bank')) {
        return normalizedLabel.contains('bank');
      }
      return normalizedLabel.contains(selectedName);
    }

    return requestActions.firstWhere(
      (action) => matches(action.label),
      orElse: () => requestActions[0],
    );
  }

  List<DateTime> get eligiblePayslipPeriods => _eligiblePayslipPeriods();

  List<int> get eligiblePayslipYears =>
      _eligiblePayslipYears(eligiblePayslipPeriods);

  List<int> get eligiblePayslipMonthsForSelectedYear {
    final selectedYear = int.tryParse(state.selectedYear);
    if (selectedYear == null) return [];
    return _eligiblePayslipMonthsForYear(selectedYear, eligiblePayslipPeriods);
  }

  String payslipMonthLabel(int month) => _payslipMonthName(month);

  int? get selectedPayslipMonthValue {
    final month = int.tryParse(state.selectedMonth);
    if (month == null) return null;
    if (!eligiblePayslipMonthsForSelectedYear.contains(month)) return null;
    return month;
  }

  int? get selectedPayslipYearValue {
    final year = int.tryParse(state.selectedYear);
    if (year == null) return null;
    if (!eligiblePayslipYears.contains(year)) return null;
    return year;
  }

  void resetPayslipSelection() {
    state = state.copyWith(
      selectedYear: DateTime.now().year.toString(),
      selectedMonth: '',
      isValidate: false,
    );
    reasonController.clear();
  }

  void onSelectPayslipYear(int? year) {
    if (year == null) return;

    final validMonths = _eligiblePayslipMonthsForYear(
      year,
      eligiblePayslipPeriods,
    );
    final selectedMonth = int.tryParse(state.selectedMonth);
    final monthStillValid =
        selectedMonth != null && validMonths.contains(selectedMonth);

    state = state.copyWith(
      selectedYear: year.toString(),
      selectedMonth: monthStillValid ? state.selectedMonth : '',
      isValidate: false,
    );
  }

  void onSelectPayslipMonth(int? month) {
    if (month == null) return;

    state = state.copyWith(selectedMonth: month.toString(), isValidate: false);
  }

  Future<void> onSelectEffectiveFrom() async {
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      effectiveFromController.text = pickedDate.formattedDate;
    }
  }

  void onPressRequestMenuActionItem(
    RequestAction action,
    _ViewState state,
    _VSController stateController,
  ) {
    if (action.label == 'Request for Payslip') {
      resetPayslipSelection();
    }

    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),
      builder: (context) {
        return PayslipRequestForm(
          title: action.label,
          params: params,
          stateController: stateController,
        );
      },
    );
  }

  void closeRequestFormDialog() {
    KAppX.extendedRouter.dialog.closeKDialog();
  }

  void onPressCurrentSubServiceRequest(_ViewState state) {
    if (_financialSubServiceRank(selectedSubService) == 3) {
      KAppX.router.push(
        ReimbursementRequestRoute(
          serviceId: params.serviceId,
          subServiceId: selectedSubServiceId,
        ),
      );
      return;
    }

    onPressRequestMenuActionItem(selectedRequestAction, state, this);
  }

  void onPressSubmit(String title) {
    if (title == 'Request for Payslip') {
      final hasValidYear = int.tryParse(state.selectedYear) != null;
      final hasValidMonth = eligiblePayslipMonthsForSelectedYear.contains(
        int.tryParse(state.selectedMonth),
      );
      if (!hasValidYear || !hasValidMonth) {
        state = state.copyWith(isValidate: true);
        return;
      }
    }

    if (formKey.currentState?.validate() == true) {
      if (title == 'Request for Payslip') {
        createPaySlipRequest();
      }
      if (title == 'Request for Salary Certificate') {
        createSalaryCertificateRequest();
      }
      if (title == 'Request for Change of Bank Account') {
        createChangeBaankAccountRequest();
      }
      if (title == 'Request for Allowance') {
        requestForAllowance();
      }
    }
  }

  final financialServiceRepo = FinancialServicesRepo();

  int determineSubServiceId(String subServiceName) {
    final normalizedName = subServiceName.toLowerCase();
    for (var subService in params.subServiceList) {
      if (subService.subServiceName?.toLowerCase() == normalizedName) {
        return subService.id ?? 0;
      }
    }
    return selectedSubServiceId;
  }

  Future<void> onFinancialRequestCreated() async {
    state = state.copyWith(isApproverView: false, requestListTabIndex: 0);
    await _refreshMyRequestsDashboardData();
    closeRequestFormDialog();
  }

  void clearPayslipRequestForm() {
    resetPayslipSelection();
  }

  void clearSalaryCertificateRequestForm() {
    reasonController.clear();
  }

  void clearBankAccountChangeRequestForm() {
    reasonController.clear();
    existingAccountNumController.clear();
    newAccountNumController.clear();
    ifscController.clear();
    accountNameController.clear();
    effectiveFromController.clear();

    // These dropdowns use internal state for submission; reset them too.
    state = state.copyWith(
      existingBankName: BankNameItem(),
      newBankName: BankNameItem(),
    );
  }

  void clearAllowanceRequestForm() {
    reasonController.clear();
    alllownceAmountController.clear();
    contactNumberController.clear();

    state = state.copyWith(
      selectedCurrency: CurrencyItem(),
      selectedAllowanceType: AllowanceTypeItem(),
    );
  }

  Future<void> createPaySlipRequest() async {
    final data = {
      "service_id": params.serviceId,
      "sub_service_id": determineSubServiceId('Payslip Request'),
      "payslip_month": selectedPayslipMonth,
      "payslip_year": state.selectedYear,
      "remarks": reasonController.text,
    };

    try {
      await financialServiceRepo.createPaySlipRequest(data);
      clearPayslipRequestForm();
      await onFinancialRequestCreated();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      ShowFlutterToast().showFlutterToastFailure('Failed to submit request');
    }
  }

  Future<void> createSalaryCertificateRequest() async {
    final data = {
      "service_id": params.serviceId,
      "sub_service_id": determineSubServiceId('Salary Certificate'),
      "certificate_purpose": reasonController.text,
    };

    try {
      await financialServiceRepo.createSalaryCertificateRequest(data);
      clearSalaryCertificateRequestForm();
      await onFinancialRequestCreated();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      ShowFlutterToast().showFlutterToastFailure('Failed to submit request');
    }
  }

  Future<void> createChangeBaankAccountRequest() async {
    final data = {
      "service_id": params.serviceId,
      "sub_service_id": selectedSubServiceId,
      "old_bank_name": state.existingBankName.bankName,
      "old_account_number": existingAccountNumController.text,
      "new_bank_name": state.newBankName.bankName,
      "new_account_number": newAccountNumController.text,
      "new_account_name": accountNameController.text,
      "new_branch_ifsc_code": ifscController.text,
      // "reason_for_change": reasonController.text,
      "remarks": reasonController.text,
      "effective_from_date": effectiveFromController.text,
      // "remarks":
      //     "Please process this request urgently as I need to update my payroll details",
    };

    try {
      await financialServiceRepo.createBankAccountChangeRequest(data);
      clearBankAccountChangeRequestForm();
      await onFinancialRequestCreated();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      ShowFlutterToast().showFlutterToastFailure('Failed to submit request');
    }
  }

  Future<void> requestForAllowance() async {
    final data = {
      "service_id": params.serviceId,
      "sub_service_id": determineSubServiceId('Allowance Request'),
      "allowance_type_id": state.selectedAllowanceType.id,
      "allowance_amount": alllownceAmountController.text,
      "currency": state.selectedCurrency.code,
      "contact_number": contactNumberController.text,
      "description": reasonController.text,
      // "remarks": "Required for international calls"
    };

    try {
      await financialServiceRepo.createAllownaceRequest(data);
      clearAllowanceRequestForm();
      await onFinancialRequestCreated();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      ShowFlutterToast().showFlutterToastFailure('Failed to submit request');
    }
  }

  void setRequestListTab(int index) {
    toggleViewMode(index == 1);
  }

  Future<void> _refreshMyRequestsDashboardData() async {
    final breakdownParams = {
      'time_period': state.selectedBreakdownValue.toLowerCase(),
      ...selectedServiceParams,
    };
    final trendParams = {
      'year': state.selectedTrendYear,
      ...selectedServiceParams,
    };

    FinancialServicesStatsData? statsData;
    FinancialStatusBreakdownData? statusBreakdownData;
    FinancialServicesTrendBreakdownData? trendData;
    List<FinancialServiceRequestItem>? myRequests;

    try {
      statsData = await financialServiceRepo.fetchFinancialServicesStats(
        selectedServiceParams,
      );
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error refreshing financial stats: $e');
    }

    try {
      statusBreakdownData = await financialServiceRepo
          .fetchFinancialServicesStatusBreakdown(breakdownParams);
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error refreshing financial status breakdown: $e');
    }

    try {
      trendData = await financialServiceRepo.fetchFinancialServicesTrendBreakdown(
        trendParams,
      );
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error refreshing financial trend breakdown: $e');
    }

    try {
      myRequests = await financialServiceRepo.fetchFinancialServiceMyRequests(
        selectedListParams,
      );
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error refreshing financial my requests: $e');
    }

    state = state.copyWith(
      statsData: statsData ?? state.statsData,
      statusBreakdownData: statusBreakdownData ?? state.statusBreakdownData,
      trendData: trendData ?? state.trendData,
      myRequests: myRequests ?? state.myRequests,
    );
  }

  Future<void> switchToMyRequestsTabAndRefresh() async {
    state = state.copyWith(isApproverView: false, requestListTabIndex: 0);

    try {
      await _refreshMyRequestsDashboardData();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error refreshing financial dashboard: $e');
    }
  }

  void toggleViewMode(bool isApprover) {
    state = state.copyWith(
      isApproverView: isApprover,
      requestListTabIndex: isApprover ? 1 : 0,
    );
    if (isApprover) {
      fetchApproverStats();
      fetchApproverStatusBreakDownData();
      fetchApproverTrendData();
      fetchFinancialServiceApprovalRequests();
    } else {
      fetchStats();
      fetchStatusBreakDownData();
      fetchTrendData();
      fetchFinancialServiceMyRequest();
    }
  }

  Future<void> fetchApproverStats() async {
    try {
      final statsData = await financialServiceRepo
          .fetchFinancialServicesApproverStats(selectedServiceParams);

      if (statsData != null) {
        state = state.copyWith(approvalStatsData: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    try {
      final statusBreakdownData = await financialServiceRepo
          .fetchFinancialServicesApproverStatusBreakdown({
            'time_period': state.selectedBreakdownValue.toLowerCase(),
            ...selectedServiceParams,
          });

      if (statusBreakdownData != null) {
        state = state.copyWith(
          approvalStatusBreakdownData: statusBreakdownData,
        );
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchApproverTrendData() async {
    try {
      final trendData = await financialServiceRepo
          .fetchFinancialServicesApproverTrendBreakdown({
            'year': state.selectedTrendYear,
            ...selectedServiceParams,
          });

      if (trendData != null) {
        state = state.copyWith(approvalTrendData: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchStats() async {
    try {
      final statsData = await financialServiceRepo.fetchFinancialServicesStats(
        selectedServiceParams,
      );

      if (statsData != null) {
        state = state.copyWith(statsData: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusBrekdownData = await financialServiceRepo
          .fetchFinancialServicesStatusBreakdown({
            'time_period': state.selectedBreakdownValue.toLowerCase(),
            ...selectedServiceParams,
          });

      if (statusBrekdownData != null) {
        state = state.copyWith(statusBreakdownData: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchTrendData() async {
    try {
      final trendData = await financialServiceRepo
          .fetchFinancialServicesTrendBreakdown({
            'year': state.selectedTrendYear,
            ...selectedServiceParams,
          });

      if (trendData != null) {
        state = state.copyWith(trendData: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchBankNames() async {
    try {
      final bankNames = await financialServiceRepo.fetchBankNames();

      if (bankNames != null) {
        state = state.copyWith(bankNames: bankNames);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchCurrencyList() async {
    try {
      final currencyList = await financialServiceRepo.fetchCurrrencyList();

      if (currencyList != null) {
        state = state.copyWith(currencyList: currencyList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchAllowanceTypeList() async {
    try {
      final allowanceTypeList = await financialServiceRepo
          .fetchAllowanceTypes();

      if (allowanceTypeList != null) {
        state = state.copyWith(allownceTypeList: allowanceTypeList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchFinancialServiceMyRequest() async {
    try {
      final myRequests = await financialServiceRepo
          .fetchFinancialServiceMyRequests(selectedListParams);

      if (myRequests != null) {
        state = state.copyWith(myRequests: myRequests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchFinancialServiceApprovalRequests() async {
    try {
      final actionItems = await financialServiceRepo
          .fetchFinancialServiceApprovalRequests(selectedListParams);

      if (actionItems != null) {
        state = state.copyWith(actionItems: actionItems);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSelctExistingBankName(BankNameItem bankName) {
    state = state.copyWith(existingBankName: bankName);
  }

  void onSelectNewBankName(BankNameItem bankName) {
    state = state.copyWith(newBankName: bankName);
  }

  void onSelectCurrency(CurrencyItem currency) {
    state = state.copyWith(selectedCurrency: currency);
    log('${state.selectedCurrency.name}');
  }

  void onSelectAllowanceType(AllowanceTypeItem allowanceType) {
    state = state.copyWith(selectedAllowanceType: allowanceType);
  }

  void onChangeStatusDropdownValue(String? value) {
    state = state.copyWith(selectedBreakdownValue: value);
    if (value != null) {
      if (state.isApproverView) {
        fetchApproverStatusBreakDownData();
      } else {
        fetchStatusBreakDownData();
      }
    }
  }

  List<int> get yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear - 1, currentYear, currentYear + 1];
  }

  void onChangedTrendYearValue(int? val) {
    if (val != null && state.selectedTrendYear != val) {
      state = state.copyWith(selectedTrendYear: val);
      if (state.isApproverView) {
        fetchApproverTrendData();
      } else {
        fetchTrendData();
      }
    }
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
    fetchFinancialServiceMyRequest();
  }

  void onPressRequestDetails(int requestId) {
    KAppX.router.push(FinancialServicesDetailsRoute(requestId: requestId));
  }

  @override
  void dispose() {
    monthController.dispose();
    yearController.dispose();
    reasonController.dispose();
    contactNumberController.dispose();
    existingAccountNumController.dispose();
    ifscController.dispose();
    accountNameController.dispose();
    effectiveFromController.dispose();
    alllownceAmountController.dispose();
    newAccountNumController.dispose();

    super.dispose();
  }
}
