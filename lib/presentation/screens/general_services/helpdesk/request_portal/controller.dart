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
  final List<HelpDeskRequestItem> myRequests;
  final List<HelpDeskCategoryItem> categories;
  final HelpDeskCategoryItem selectedCategory;
  final List<HelpDeskSubCategoryItem> subCategories;
  final HelpDeskSubCategoryItem selectedSubCategories;
  final List<HelpDeskIssueTypeItem> issueTypes;
  final HelpDeskIssueTypeItem selectedIssueTypes;
  final ApprovalKpiStatsItem approvalKpiStats;
  final FinancialServicesTrendBreakdownData monthlyTrend;
  final FinancialServicesTrendBreakdownData approvalMonthlyTrend;
  final FinancialStatusBreakdownData statusBreakdown;
  final FinancialStatusBreakdownData approvalStatusBreakdown;
  final bool isValidate;
  final String selectedBreakdownValue;
  final String selectedTrendValue;

  _ViewState({
    required this.isLoading,
    required this.selectedMonth,
    required this.selectedYear,
    required this.isValidate,
    required this.myRequests,
    required this.selectedBreakdownValue,
    required this.selectedTrendValue,
    required this.categories,
    required this.subCategories,
    required this.issueTypes,
    required this.approvalKpiStats,
    required this.monthlyTrend,
    required this.approvalMonthlyTrend,
    required this.statusBreakdown,
    required this.approvalStatusBreakdown,
    required this.selectedCategory,
    required this.selectedSubCategories,
    required this.selectedIssueTypes,
    required this.isMyRequest,
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
        categories: [],
        subCategories: [],
        issueTypes: [],
        approvalKpiStats: ApprovalKpiStatsItem(),
        monthlyTrend: FinancialServicesTrendBreakdownData(),
        approvalMonthlyTrend: FinancialServicesTrendBreakdownData(),
        statusBreakdown: FinancialStatusBreakdownData(),
        approvalStatusBreakdown: FinancialStatusBreakdownData(),
        selectedCategory: HelpDeskCategoryItem(),
        selectedSubCategories: HelpDeskSubCategoryItem(),
        selectedIssueTypes: HelpDeskIssueTypeItem(),
      );

  _ViewState copyWith({
    bool? isLoading,
    bool? isMyRequest,
    String? selectedMonth,
    String? selectedYear,
    List<HelpDeskRequestItem>? myRequests,
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
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      issueTypes: issueTypes ?? this.issueTypes,
      approvalKpiStats: approvalKpiStats ?? this.approvalKpiStats,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      approvalMonthlyTrend: approvalMonthlyTrend ?? this.approvalMonthlyTrend,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubCategories:
          selectedSubCategories ?? this.selectedSubCategories,
      selectedIssueTypes: selectedIssueTypes ?? this.selectedIssueTypes,
      isMyRequest: isMyRequest ?? this.isMyRequest,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init()) {
    contactNumberController = TextEditingController();
    personNameController = TextEditingController();
    extensionNumberController = TextEditingController();
    problemController = TextEditingController();
    descriptionController = TextEditingController();

    fetchApproverKPIStats();
    fetchMyRequests();
    fetchCategories();
    fetchMonthlyTrendData();
    fetchApproverMonthlyTrendData();
    fetchStatusBreakDownData();
    fetchApproverStatusBreakDownData();
  }

  late TextEditingController personNameController;
  late TextEditingController contactNumberController;
  late TextEditingController extensionNumberController;
  late TextEditingController problemController;
  late TextEditingController descriptionController;

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

  final List<String> priorityType = ['High', 'Medium', 'Low'];

  void onPressRequestMenuActionItem(
    RequestAction action,
    _VSControllerParams params,
  ) {
    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),

      builder: (context) {
        return HelpDeskReuestFormWidget(params: params);
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

  final helpDeskRepo = HelpDeskRepo();

  Future<void> fetchApproverKPIStats() async {
    try {
      final statsData = await helpDeskRepo.fetchApproverKPIStats();

      if (statsData != null) {
        state = state.copyWith(approvalKpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusBrekdownData = await helpDeskRepo.fetchStatusBreakdown({
        'time_period': state.selectedBreakdownValue,
      }, true);

      if (statusBrekdownData != null) {
        state = state.copyWith(statusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    try {
      final statusBrekdownData = await helpDeskRepo.fetchStatusBreakdown({
        'time_period': state.selectedBreakdownValue,
      }, false);

      if (statusBrekdownData != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBrekdownData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchMonthlyTrendData() async {
    try {
      final trendData = await helpDeskRepo.fetchMonthlyTrend({
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
      final trendData = await helpDeskRepo.fetchMonthlyTrend({
        'year': 2025,
      }, false);

      if (trendData != null) {
        state = state.copyWith(approvalMonthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await helpDeskRepo.fetchHelpDeskCategory();

      if (categories != null) {
        state = state.copyWith(categories: categories);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSelectCategory(HelpDeskCategoryItem category) {
    state = state.copyWith(
      selectedCategory: category,
      selectedSubCategories: HelpDeskSubCategoryItem(),
      selectedIssueTypes: HelpDeskIssueTypeItem(),
    );
    fetchSubCategories();
  }

  Future<void> fetchSubCategories() async {
    final queryParam = {'category_id': state.selectedCategory.id};
    try {
      final subCategories = await helpDeskRepo.fetchHelpDeskSubCategory(
        queryParam,
      );

      if (subCategories != null) {
        state = state.copyWith(subCategories: subCategories);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSelectSubCategory(HelpDeskSubCategoryItem subCategory) {
    state = state.copyWith(
      selectedSubCategories: subCategory,
      selectedIssueTypes: HelpDeskIssueTypeItem(),
    );
    fetchIssueTypes();
  }

  Future<void> fetchIssueTypes() async {
    final queryParam = {
      'category_id': state.selectedCategory.id,
      'subcategory_id': state.selectedSubCategories.id,
    };
    try {
      final issueTypes = await helpDeskRepo.fetchHelpDeskIssueType(queryParam);

      if (issueTypes != null) {
        state = state.copyWith(issueTypes: issueTypes);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSelectIssueType(HelpDeskIssueTypeItem issueType) {
    state = state.copyWith(selectedIssueTypes: issueType);
  }

  Future<void> fetchMyRequests() async {
    try {
      final myRequests = await helpDeskRepo.fetchHelpDeskMyRequests();

      if (myRequests != null) {
        state = state.copyWith(myRequests: myRequests);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSwitchTabsInMyRequestCard(int index) {
    state = state.copyWith(isMyRequest: index == 0 ? true : false);
  }

  void onPressRequestDetails(int requestId) {
    KAppX.router.push(HelpDeskDetailsRoute(requestId: requestId));
  }

  @override
  void dispose() {
    contactNumberController.dispose();
    personNameController.dispose();
    problemController.dispose();
    descriptionController.dispose();
    extensionNumberController.dispose();

    super.dispose();
  }
}
