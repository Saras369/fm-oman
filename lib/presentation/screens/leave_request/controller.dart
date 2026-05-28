part of 'view.dart';

final relationshipOptionsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    {"id": 1, "name": "Parent"},
    {"id": 2, "name": "Sibling"},
    {"id": 3, "name": "Spouse"},
    {"id": 4, "name": "Child"},
  ];
});

class DynamicLeaveFormParams {
  final List<SubServices> subServicesList;
  final int serviceId;

  DynamicLeaveFormParams({
    required this.subServicesList,
    required this.serviceId,
  });
}

class DynamicLeaveFormState {
  final LeaveTypeItem selectedLeaveType;
  final Map<String, String?> errors;
  final bool isLoading;
  final UserData userData;
  final List<LeaveTypeItem> leaveTypeList;
  final String startDate, endDate;
  final List<String> selectedFileUrl;
  final List<MyLeaveRequestItem> myLeaveRequests;
  final List<MyLeaveRequestItem> approvedLeaveRequests;
  final List<MyLeaveRequestItem> actionItems;
  final String leaveFor;
  final List<UnpaidLeaveCategoryItem> unpaidLeaveCategories;
  final List<MourningLeaveRelationItem> mourningLeaveRelations;
  final List<BehalfOfUserItem> behalfOfUsers;
  final UnpaidLeaveCategoryItem selectedUnpaidLeaveCategory;
  final MourningLeaveRelationItem selectedMourningLeaveRelation;
  final BehalfOfUserItem selectedBehalfOfUser;
  final bool isMyRequest;
  final FinancialServicesStatsData kpiStats;
  final ApprovalKpiStatsItem approvalKpiStats;
  final FinancialStatusBreakdownData statusBreakdown;
  final FinancialStatusBreakdownData approvalStatusBreakdown;
  final FinancialServicesTrendBreakdownData monthlyTrend;
  final FinancialServicesTrendBreakdownData approvalMonthlyTrend;
  final String selectedBreakdownValue;
  final int selectedTrendYear;
  final int selectedBalanceYear;
  final List<LeaveBalanceData> leaveBalances;
  final int availableLeaveBalance;
  final MyLeaveRequestItem selectedApprovedLeave;

  DynamicLeaveFormState({
    required this.selectedLeaveType,
    required this.errors,
    required this.isLoading,
    required this.userData,
    required this.leaveTypeList,
    required this.startDate,
    required this.endDate,
    required this.selectedFileUrl,
    required this.myLeaveRequests,
    required this.approvedLeaveRequests,
    required this.actionItems,
    required this.leaveFor,
    required this.unpaidLeaveCategories,
    required this.mourningLeaveRelations,
    required this.behalfOfUsers,
    required this.selectedUnpaidLeaveCategory,
    required this.selectedMourningLeaveRelation,
    required this.selectedBehalfOfUser,
    required this.isMyRequest,
    required this.kpiStats,
    required this.approvalKpiStats,
    required this.statusBreakdown,
    required this.approvalStatusBreakdown,
    required this.monthlyTrend,
    required this.approvalMonthlyTrend,
    required this.selectedBreakdownValue,
    required this.selectedTrendYear,
    required this.selectedBalanceYear,
    required this.leaveBalances,
    required this.availableLeaveBalance,
    required this.selectedApprovedLeave,
  });

  DynamicLeaveFormState copyWith({
    LeaveTypeItem? selectedLeaveType,
    Map<String, String?>? errors,
    bool? isLoading,
    UserData? userData,
    List<LeaveTypeItem>? leaveTypeList,
    String? startDate,
    endDate,
    List<String>? selectedFileUrl,
    List<MyLeaveRequestItem>? myLeaveRequests,
    List<MyLeaveRequestItem>? approvedLeaveRequests,
    List<MyLeaveRequestItem>? actionItems,
    String? leaveFor,
    List<UnpaidLeaveCategoryItem>? unpaidLeaveCategories,
    List<MourningLeaveRelationItem>? mourningLeaveRelations,
    List<BehalfOfUserItem>? behalfOfUsers,
    UnpaidLeaveCategoryItem? selectedUnpaidLeaveCategory,
    MourningLeaveRelationItem? selectedMourningLeaveRelation,
    BehalfOfUserItem? selectedBehalfOfUser,
    bool? isMyRequest,
    FinancialServicesStatsData? kpiStats,
    ApprovalKpiStatsItem? approvalKpiStats,
    FinancialStatusBreakdownData? statusBreakdown,
    FinancialStatusBreakdownData? approvalStatusBreakdown,
    FinancialServicesTrendBreakdownData? monthlyTrend,
    FinancialServicesTrendBreakdownData? approvalMonthlyTrend,
    String? selectedBreakdownValue,
    int? selectedTrendYear,
    int? selectedBalanceYear,
    List<LeaveBalanceData>? leaveBalances,
    int? availableLeaveBalance,
    MyLeaveRequestItem? selectedApprovedLeave,
  }) {
    return DynamicLeaveFormState(
      selectedLeaveType: selectedLeaveType ?? this.selectedLeaveType,
      errors: errors ?? this.errors,
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
      leaveTypeList: leaveTypeList ?? this.leaveTypeList,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      myLeaveRequests: myLeaveRequests ?? this.myLeaveRequests,
      approvedLeaveRequests:
          approvedLeaveRequests ?? this.approvedLeaveRequests,
      actionItems: actionItems ?? this.actionItems,
      leaveFor: leaveFor ?? this.leaveFor,
      unpaidLeaveCategories:
          unpaidLeaveCategories ?? this.unpaidLeaveCategories,
      mourningLeaveRelations:
          mourningLeaveRelations ?? this.mourningLeaveRelations,
      behalfOfUsers: behalfOfUsers ?? this.behalfOfUsers,
      selectedUnpaidLeaveCategory:
          selectedUnpaidLeaveCategory ?? this.selectedUnpaidLeaveCategory,
      selectedMourningLeaveRelation:
          selectedMourningLeaveRelation ?? this.selectedMourningLeaveRelation,
      selectedBehalfOfUser: selectedBehalfOfUser ?? this.selectedBehalfOfUser,
      isMyRequest: isMyRequest ?? this.isMyRequest,
      kpiStats: kpiStats ?? this.kpiStats,
      approvalKpiStats: approvalKpiStats ?? this.approvalKpiStats,
      statusBreakdown: statusBreakdown ?? this.statusBreakdown,
      approvalStatusBreakdown:
          approvalStatusBreakdown ?? this.approvalStatusBreakdown,
      monthlyTrend: monthlyTrend ?? this.monthlyTrend,
      approvalMonthlyTrend: approvalMonthlyTrend ?? this.approvalMonthlyTrend,
      selectedBreakdownValue:
          selectedBreakdownValue ?? this.selectedBreakdownValue,
      selectedTrendYear: selectedTrendYear ?? this.selectedTrendYear,
      selectedBalanceYear: selectedBalanceYear ?? this.selectedBalanceYear,
      leaveBalances: leaveBalances ?? this.leaveBalances,
      availableLeaveBalance: availableLeaveBalance ?? this.availableLeaveBalance,
      selectedApprovedLeave:
          selectedApprovedLeave ?? this.selectedApprovedLeave,
    );
  }
}

class DynamicLeaveFormController extends StateNotifier<DynamicLeaveFormState> {
  final DynamicLeaveFormParams params;
  final LeaveRepo _leaveRepo = LeaveRepo();

  static const _balanceColors = [
    Color(0xFF6677C6),
    Color(0xFF2EC5CE),
    Color(0xFFE8547F),
    Color(0xFFA347CF),
    Color(0xFFF96636),
  ];

  final stats = [
    StatSummaryData(
      title: 'Total Requests',
      description: 'This Month',
      icon: Icons.assignment_outlined,
      iconBgColor: Color(0xFFF3F6F8),
    ),
    StatSummaryData(
      title: 'Approved',
      description: 'This Month',
      icon: Icons.check_box_outlined,
      iconBgColor: Color(0xFFE7F1FF),
    ),
    StatSummaryData(
      title: 'Pending',
      description: 'This Month',
      icon: Icons.timer_outlined,
      iconBgColor: Color(0xFFFFF9E7),
    ),
    StatSummaryData(
      title: 'Rejected',
      description: 'This Month',
      icon: Icons.cancel_outlined,
      iconBgColor: Color(0xFFFFE9EA),
    ),
  ];

  DynamicLeaveFormController(this.params)
    : super(
        DynamicLeaveFormState(
          selectedLeaveType: LeaveTypeItem(),
          errors: {},
          isLoading: false,
          userData: UserData(),
          leaveTypeList: [],
          startDate: '',
          endDate: '',
          selectedFileUrl: [],
          myLeaveRequests: [],
          approvedLeaveRequests: [],
          actionItems: [],
          leaveFor: 'Self',
          unpaidLeaveCategories: [],
          mourningLeaveRelations: [],
          behalfOfUsers: [],
          selectedUnpaidLeaveCategory: UnpaidLeaveCategoryItem(),
          selectedMourningLeaveRelation: MourningLeaveRelationItem(),
          selectedBehalfOfUser: BehalfOfUserItem(),
          isMyRequest: true,
          kpiStats: FinancialServicesStatsData(),
          approvalKpiStats: ApprovalKpiStatsItem(),
          statusBreakdown: FinancialStatusBreakdownData(),
          approvalStatusBreakdown: FinancialStatusBreakdownData(),
          monthlyTrend: FinancialServicesTrendBreakdownData(),
          approvalMonthlyTrend: FinancialServicesTrendBreakdownData(),
          selectedBreakdownValue: 'Yearly',
          selectedTrendYear: DateTime.now().year,
          selectedBalanceYear: DateTime.now().year,
          leaveBalances: [],
          availableLeaveBalance: 0,
          selectedApprovedLeave: MyLeaveRequestItem(),
        ),
      );
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> get _serviceParams => {
    'service_id': params.serviceId,
    'sub_service_id': determineSubServiceId(),
  };

  List<int> get yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear - 1, currentYear, currentYear + 1];
  }

  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController contactNumberDuringLeaveController;
  late TextEditingController addressDuringLeaveController;
  late TextEditingController notesController;
  late TextEditingController reasonForCancellationController;
  late TextEditingController selectDurationController;
  late TextEditingController employeeNameController;
  late TextEditingController departmentController;

  // List<LeaveField> get allFields {
  //   return [
  //     ...commonFields,
  //     ...?leaveTypeAdditionalFields[state.selectedLeaveType],
  //   ];
  // }

  // void updateLeaveType(LeaveTypeItem newType) {
  //   // dispose removed controllers
  //   final existing = state.controllers;
  //   for (var c in existing.entries) {
  //     c.value.dispose();
  //   }
  //   // set up new controllers
  //   final fields = [...commonFields, ...?leaveTypeAdditionalFields[newType]];
  //   final newControllers = {
  //     for (var f in fields) f.key: TextEditingController(),
  //   };
  //   state = state.copyWith(
  //     selectedLeaveType: newType,
  //     // controllers: newControllers,
  //     errors: {},
  //     isLoading: false,
  //   );
  // }

  // void setValue(String key, String value) {
  //   state.controllers[key]?.text = value;
  //   // errors cleared on input
  //   final e = {...state.errors};
  //   e.remove(key);
  //   state = state.copyWith(errors: e);
  // }

  void setError(String key, String? error) {
    final e = {...state.errors};
    if (error != null && error.isNotEmpty) {
      e[key] = error;
    } else {
      e.remove(key);
    }
    state = state.copyWith(errors: e);
  }

  void showLoading(bool v) => state = state.copyWith(isLoading: v);

  // Validation function
  // bool validate() {
  //   formKey.currentState?.validate();
  //   bool valid = true;
  //   final errs = <String, String?>{};
  //   for (final field in allFields) {
  //     var val = state.controllers[field.key]?.text ?? '';
  //     if (field.required && val.isEmpty) {
  //       errs[field.key] = 'Please enter ${field.label}';
  //       valid = false;
  //     }
  //   }
  //   state = state.copyWith(errors: errs);
  //   return valid;
  // }

  // Map<String, String> getValues() {
  //   final result = <String, String>{};
  //   for (final field in allFields) {
  //     result[field.key] = state.controllers[field.key]?.text ?? '';
  //   }
  //   return result;
  // }

  Future<void> fetchUserDataById() async {
    final authRepo = AuthRepository();
    try {
      final userData = await authRepo.getUserDataById();

      if (userData != null) {
        state = state.copyWith(userData: userData);
        log(userData.toJson().toString());
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching user data $e');
    }
  }

  Future<List<LeaveTypeItem>> fetchLeaveTypes() async {
    String empType = "";
    final leaveRepo = LeaveRepo();
    try {
      final leaveTypes = await leaveRepo.fetchLeaveTypes(empType);

      if (leaveTypes?.data != null) {
        state = state.copyWith(leaveTypeList: leaveTypes?.data ?? []);
        return leaveTypes?.data ?? [];
      }
      return [];
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> onPressSelectStartDate() async {
    final selectedStartDate = DateTime.tryParse(state.startDate);
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final normalizedPickedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      final selectedEndDate = DateTime.tryParse(state.endDate);
      final shouldClearEndDate =
          selectedEndDate != null &&
          DateTime(
                selectedEndDate.year,
                selectedEndDate.month,
                selectedEndDate.day,
              ).isBefore(normalizedPickedDate);

      state = state.copyWith(
        startDate: pickedDate.formattedDateAsYearMonthDate,
        endDate: shouldClearEndDate ? '' : state.endDate,
      );
      startDateController.text = pickedDate.formattedDateAsYearMonthDate;

      if (shouldClearEndDate) {
        endDateController.clear();
        ShowFlutterToast().showFlutterToastFailure(
          'End Date was reset because it cannot be before Start Date.',
        );
      }
    }
  }

  Future<void> onPressSelectEndDate() async {
    final selectedStartDate = DateTime.tryParse(state.startDate);
    final selectedEndDate = DateTime.tryParse(state.endDate);
    final fallbackInitialDate = selectedStartDate ?? DateTime.now();

    DateTime initialDate = selectedEndDate ?? fallbackInitialDate;
    if (selectedStartDate != null && initialDate.isBefore(selectedStartDate)) {
      initialDate = selectedStartDate;
    }

    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: initialDate,
      firstDate: selectedStartDate ?? DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      state = state.copyWith(endDate: pickedDate.formattedDateAsYearMonthDate);
      endDateController.text = pickedDate.formattedDateAsYearMonthDate;
    }
  }

  bool validateLeaveRequestForm() {
    if (formKey.currentState?.validate() == false) {
      return false;
    }
    if (state.selectedLeaveType.id == null) {
      return false;
    }
    if (isCancellationLeaveType(state.selectedLeaveType)) {
      if (state.selectedApprovedLeave.id == null) {
        ShowFlutterToast().showFlutterToastFailure(
          'Please select an approved leave to cancel.',
        );
        return false;
      }
      if (reasonForCancellationController.text.trim().isEmpty) {
        ShowFlutterToast().showFlutterToastFailure(
          'Please enter reason for cancellation.',
        );
        return false;
      }
      return true;
    }
    if (state.availableLeaveBalance <= 0) {
      ShowFlutterToast().showFlutterToastFailure(
        'Leave balance is 0. Leave cannot be applied.',
      );
      return false;
    }
    // if(state.leaveFor == 'Behalf of' && )
    // to do: user need to be selected from dropdown
    return true;
  }

  void onPressSubmitLeaveRequest() {
    if (validateLeaveRequestForm()) {
      createLeaveRequest();
    }
  }

  void onPressSubmitClearFormFields() {
    formKey.currentState?.reset();
    state = state.copyWith(
      selectedLeaveType: LeaveTypeItem(),
      startDate: '',
      endDate: '',
      availableLeaveBalance: 0,
      selectedApprovedLeave: MyLeaveRequestItem(),
    );
    startDateController.clear();
    endDateController.clear();
    contactNumberDuringLeaveController.clear();
    addressDuringLeaveController.clear();
    notesController.clear();
    reasonForCancellationController.clear();
    selectDurationController.clear();
    employeeNameController.clear();
    departmentController.clear();
    KAppX.router.pop();
  }

  int determineSubServiceId() {
    int subServiceId = 0;
    for (var subService in params.subServicesList) {
      if (subService.code == 'LEAVE_MANAGEMENT') {
        subServiceId = subService.id ?? 0;
      }
    }
    return subServiceId;
  }

  Map<String, dynamic> createLeaveRequestBody() {
    final userDate = KAppX.globalProvider.read(userProvider);
    //       "address_during_leave": addressDuringLeaveController.text, annual, accompany, sultanate, study, mourning, marriage, leave extension
    //supporting_documents : ,Exam, maternity, mourning, marriage, paternity

    final Map<String, dynamic> data = {
      "leave_type": state.selectedLeaveType.id.toString(),
      "leave_type_name": state.selectedLeaveType.name,
      "service_id": params.serviceId.toString(),
      "sub_service_id": determineSubServiceId().toString(),
      "leave_start_date": state.startDate,
      "leave_end_date": state.endDate,
      "contact_number_during_leave": contactNumberDuringLeaveController.text,
      "notes": notesController.text,
      "user_id": userDate?.userId.toString(),
      // "delegated_to": "2",
      "department": userDate?.department.toString(),
    };

    //pateint accompany
    if (state.selectedLeaveType.id == 3) {
      data['number_of_escort_instances_per_year'] = 1;
      data['treatment_place'] = 'Royal Hospital, Muscat';
    }
    // sultanate
    if (state.selectedLeaveType.id == 9) {
      data["representation"] = "In side";
      data["country_or_state_being_visited"] = "Mascut";
      data["activity_title"] = "Oman champions - Badminton";
    }

    //unpaid
    if (state.selectedLeaveType.id == 11) {
      data["unpaid_leave_type"] = "Project Management";
    }
    //mourning
    if (state.selectedLeaveType.id == 12) {
      data["mounring_leave_relation"] = 1;
    }
    if (state.selectedLeaveType.id == 2 || state.selectedLeaveType.id == 7) {
      data["leave_for"] = state.leaveFor;
    }

    if (isCancellationLeaveType(state.selectedLeaveType)) {
      final approved = state.selectedApprovedLeave;
      data['approved_leave_request_id'] = approved.id?.toString();
      data['approved_leave_type'] = approved.leaveType?.id?.toString();
      data['approved_leave_type_name'] = approved.leaveType?.name;
      data['leave_duration'] = approved.leaveDuration?.toString();
      data['reason_for_cancellation'] =
          reasonForCancellationController.text.trim();
      data['notes'] = notesController.text.trim().isEmpty
          ? reasonForCancellationController.text.trim()
          : notesController.text.trim();
      data['department'] =
          approved.department ?? departmentController.text.trim();
    }

    return data;
  }

  Future<void> createLeaveRequest() async {
    final data = createLeaveRequestBody();

    try {
      state = state.copyWith(isLoading: true);
      await _leaveRepo.createLeaveRequest(data);
      state = state.copyWith(isLoading: false);
      await _refreshDashboard();
      onPressSubmitClearFormFields();
    } on ApiException catch (apiError) {
      state = state.copyWith(isLoading: false);
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshDashboard() async {
    await fetchMyLeaveRequests();
    if (state.isMyRequest) {
      await Future.wait([
        fetchKPIStats(),
        fetchStatusBreakDownData(),
        fetchMonthlyTrendData(),
      ]);
    } else {
      await Future.wait([
        fetchApproverKPIStats(),
        fetchApproverStatusBreakDownData(),
        fetchApproverMonthlyTrendData(),
        fetchLeaveApprovalRequests(),
      ]);
    }
    // await fetchLeaveBalances();
  }

  Future<void> fetchKPIStats() async {
    try {
      final statsData = await _leaveRepo.fetchLeaveKPIStats(_serviceParams);
      if (statsData != null) {
        state = state.copyWith(kpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave kpi stats $e');
    }
  }

  Future<void> fetchApproverKPIStats() async {
    try {
      final statsData = await _leaveRepo.fetchLeaveApproverKPIStats(
        _serviceParams,
      );
      if (statsData != null) {
        state = state.copyWith(approvalKpiStats: statsData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave approver kpi stats $e');
    }
  }

  Future<void> fetchStatusBreakDownData() async {
    try {
      final statusBreakdownData = await _leaveRepo.fetchLeaveStatusBreakdown({
        'time_period': state.selectedBreakdownValue.toLowerCase(),
        ..._serviceParams,
      });
      if (statusBreakdownData != null) {
        state = state.copyWith(statusBreakdown: statusBreakdownData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave status breakdown $e');
    }
  }

  Future<void> fetchApproverStatusBreakDownData() async {
    try {
      final statusBreakdownData = await _leaveRepo.fetchLeaveStatusBreakdown(
        {
          'time_period': state.selectedBreakdownValue.toLowerCase(),
          ..._serviceParams,
        },
        isMyRequest: false,
      );
      if (statusBreakdownData != null) {
        state = state.copyWith(approvalStatusBreakdown: statusBreakdownData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave approver status breakdown $e');
    }
  }

  void onChangedStatusBreakDownValue(String? val) {
    if (val == null || state.selectedBreakdownValue == val) return;
    state = state.copyWith(selectedBreakdownValue: val);
    if (state.isMyRequest) {
      fetchStatusBreakDownData();
    } else {
      fetchApproverStatusBreakDownData();
    }
  }

  Future<void> fetchMonthlyTrendData() async {
    try {
      final trendData = await _leaveRepo.fetchLeaveTrendBreakdown({
        'year': state.selectedTrendYear,
        ..._serviceParams,
      });
      if (trendData != null) {
        state = state.copyWith(monthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave monthly trend $e');
    }
  }

  Future<void> fetchApproverMonthlyTrendData() async {
    try {
      final trendData = await _leaveRepo.fetchLeaveTrendBreakdown(
        {'year': state.selectedTrendYear, ..._serviceParams},
        isMyRequest: false,
      );
      if (trendData != null) {
        state = state.copyWith(approvalMonthlyTrend: trendData);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave approver monthly trend $e');
    }
  }

  void onChangedTrendYearValue(int? val) {
    if (val == null || state.selectedTrendYear == val) return;
    state = state.copyWith(selectedTrendYear: val);
    if (state.isMyRequest) {
      fetchMonthlyTrendData();
    } else {
      fetchApproverMonthlyTrendData();
    }
  }

  void onChangedBalanceYearValue(int? val) {
    if (val == null || state.selectedBalanceYear == val) return;
    state = state.copyWith(selectedBalanceYear: val);
    // fetchLeaveBalances();
  }

  Future<void> fetchLeaveBalances() async {
    final userId = KAppX.globalProvider.read(userProvider)?.userId;
    if (userId == null) return;

    try {
      final balances = await _leaveRepo.fetchLeaveUserBalances(
        userId,
        year: state.selectedBalanceYear,
      );
      if (balances != null) {
        state = state.copyWith(leaveBalances: _mapLeaveBalances(balances));
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave balances $e');
    }
  }

  List<LeaveBalanceData> _mapLeaveBalances(List<LeaveUserBalanceItem> items) {
    return items.asMap().entries.map((entry) {
      final item = entry.value;
      final used = item.used ?? 0;
      final total = item.total ?? 0;
      return LeaveBalanceData(
        title: item.leaveTypeName ?? 'Leave',
        used: used,
        total: total > 0 ? total : (used > 0 ? used : 1),
        color: _balanceColors[entry.key % _balanceColors.length],
      );
    }).toList();
  }

  Future<void> fetchLeaveApprovalRequests() async {
    try {
      final actionItems = await _leaveRepo.fetchLeaveApprovalRequests(
        queryParameters: _serviceParams,
      );
      if (actionItems != null) {
        state = state.copyWith(actionItems: actionItems);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave approval requests $e');
    }
  }

  void onSwitchTabsInMyRequestCard(int index) {
    final isMyRequest = index == 0;
    state = state.copyWith(isMyRequest: isMyRequest);
    if (isMyRequest) {
      fetchKPIStats();
      fetchMonthlyTrendData();
      fetchStatusBreakDownData();
      fetchMyLeaveRequests();
    } else {
      fetchApproverKPIStats();
      fetchApproverMonthlyTrendData();
      fetchApproverStatusBreakDownData();
      fetchLeaveApprovalRequests();
    }
  }

  Map<String, ChartData> returnStatusBreakdownData() {
    final statusBreakdown = state.isMyRequest
        ? state.statusBreakdown
        : state.approvalStatusBreakdown;

    return {
      'opened': ChartData(
        label: 'Opened',
        value: statusBreakdown.completed ?? 0,
        color: const Color(0xFF54A23B),
      ),
      'pending': ChartData(
        label: 'Pending',
        value: statusBreakdown.pending ?? 0,
        color: const Color(0xFFF7B226),
      ),
      'closed': ChartData(
        label: 'Closed',
        value: statusBreakdown.rejected ?? 0,
        color: const Color(0xFFD43E3E),
      ),
    };
  }

  List<int> returnMonthlyTrendData() {
    final monthlyTrend = state.isMyRequest
        ? state.monthlyTrend.monthlyTrend
        : state.approvalMonthlyTrend.monthlyTrend;

    final trendList = List<int>.filled(12, 0);
    if (monthlyTrend?.isNotEmpty == true) {
      for (var i = 0; i < monthlyTrend!.length && i < 12; i++) {
        trendList[i] = monthlyTrend[i].total ?? 0;
      }
    }
    return trendList;
  }

  List<String> determineKPIStats() {
    if (state.isMyRequest) {
      final kpi = state.kpiStats;
      return [
        '${kpi.total ?? 0}',
        '${kpi.completed ?? 0}',
        '${kpi.pending ?? 0}',
        '${kpi.rejected ?? 0}',
      ];
    }

    final approverKpi = state.approvalKpiStats;
    return [
      '${approverKpi.totalAssignedToMe ?? 0}',
      '${approverKpi.approvedByMe ?? 0}',
      '${approverKpi.pendingMyApproval ?? 0}',
      '${approverKpi.rejectedByMe ?? 0}',
    ];
  }

  Future<void> onSelectLeaveType(LeaveTypeItem leaveType) async {
    final isCancellation = isCancellationLeaveType(leaveType);
    state = state.copyWith(
      selectedLeaveType: leaveType,
      availableLeaveBalance: 0,
      selectedApprovedLeave: MyLeaveRequestItem(),
      startDate: '',
      endDate: '',
    );
    startDateController.clear();
    endDateController.clear();
    reasonForCancellationController.clear();
    selectDurationController.clear();

    if (isCancellation) {
      _populateEmployeeFieldsFromUser();
      await fetchApprovedLeaveRequests();
      return;
    }

    employeeNameController.clear();
    departmentController.clear();
    await fetchLeaveBalanceByType(leaveType.id);
  }

  bool isCancellationLeaveType(LeaveTypeItem leaveType) {
    final name = (leaveType.name ?? '').trim().toLowerCase();
    return name == 'cancellation' || name.contains('cancellation');
  }

  List<MyLeaveRequestItem> get approvedLeavesForCancellation {
    return state.approvedLeaveRequests.where(_canCancelLeave).toList();
  }

  bool _canCancelLeave(MyLeaveRequestItem item) {
    final typeName = (item.leaveType?.name ?? '').trim().toLowerCase();
    if (typeName.contains('cancellation')) return false;
    final status = (item.status ?? '').trim().toLowerCase();
    if (status.contains('cancel')) return false;
    return item.id != null;
  }

  String approvedLeaveDropdownLabel(MyLeaveRequestItem item) {
    final typeName = item.leaveType?.name ?? 'Leave';
    final start = formatLeaveDateForDisplay(item.leaveStartDate);
    final end = formatLeaveDateForDisplay(item.leaveEndDate);
    if (start.isNotEmpty && end.isNotEmpty) {
      return '$typeName ($start - $end)';
    }
    return '$typeName (#${item.id ?? ''})';
  }

  String formatLeaveDateForDisplay(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return '';
    final parsed = DateTime.tryParse(apiDate);
    if (parsed == null) return apiDate;
    return DateFormat('dd/MM/yyyy').format(parsed);
  }

  void _populateEmployeeFieldsFromUser() {
    final user = state.userData;
    final authUser = KAppX.globalProvider.read(userProvider);
    employeeNameController.text =
        user.employeeName ?? authUser?.employeeName ?? '';
    departmentController.text =
        user.department?.departmentName ??
        authUser?.departmentName ??
        '';
  }

  void onSelectApprovedLeave(MyLeaveRequestItem leave) {
    state = state.copyWith(
      selectedApprovedLeave: leave,
      startDate: leave.leaveStartDate ?? '',
      endDate: leave.leaveEndDate ?? '',
    );
    startDateController.text = formatLeaveDateForDisplay(leave.leaveStartDate);
    endDateController.text = formatLeaveDateForDisplay(leave.leaveEndDate);
    selectDurationController.text = '${leave.leaveDuration ?? 0}';
    employeeNameController.text =
        leave.user?.employeeName ?? state.userData.employeeName ?? '';
    departmentController.text =
        leave.department ?? state.userData.department?.departmentName ?? '';
  }

  Future<void> fetchLeaveBalanceByType(int? leaveTypeId) async {
    final userId = KAppX.globalProvider.read(userProvider)?.userId;
    if (userId == null || leaveTypeId == null) {
      state = state.copyWith(availableLeaveBalance: 0);
      return;
    }
    try {
      final balance = await _leaveRepo.fetchLeaveBalanceByType(
        userId: userId,
        leaveTypeId: leaveTypeId,
      );
      state = state.copyWith(availableLeaveBalance: balance);
    } on ApiException catch (apiError) {
      state = state.copyWith(availableLeaveBalance: 0);
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (_) {
      state = state.copyWith(availableLeaveBalance: 0);
      ShowFlutterToast().showFlutterToastFailure(
        'Leave balance is unavailable. Leave cannot be applied.',
      );
    }
  }

  void onUploadFileSuccess(String url) {
    final urls = state.selectedFileUrl;
    urls.add(url);
    state = state.copyWith(selectedFileUrl: urls);
  }

  void onRemoveFile(int index) {
    final urls = state.selectedFileUrl;
    urls.removeAt(index);
    state = state.copyWith(selectedFileUrl: urls);
  }

  Future<void> fetchMyLeaveRequests() async {
    try {
      final myLeaveReq = await _leaveRepo.fetchMyLeaveRequests();

      if (myLeaveReq != null) {
        state = state.copyWith(myLeaveRequests: myLeaveReq);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching leave requests $e');
    }
  }

  Future<void> fetchApprovedLeaveRequests() async {
    try {
      final approvedLeaves = await _leaveRepo.fetchApprovedLeaveRequests();
      if (approvedLeaves != null) {
        state = state.copyWith(approvedLeaveRequests: approvedLeaves);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching approved leave requests $e');
    }
  }

  String determineLeaveType(int id) {
    final leaveType = state.leaveTypeList
        .where((element) => element.id == id)
        .first;

    return leaveType.name ?? 'unknown';
  }

  void onSelectLeaveFor(String leaveFor) {
    state = state.copyWith(leaveFor: leaveFor);
  }

  Future<void> fetchBehalfOfUsers() async {
    final authRepo = AuthRepository();
    final queryParam = {'offset': 1, 'limit': 10};
    try {
      final behalfOfUsers = await authRepo.fetchBehalfOfUsers(queryParam);

      if (behalfOfUsers != null) {
        state = state.copyWith(behalfOfUsers: behalfOfUsers);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching behalf of users $e');
    }
  }

  void onSelectBehalfOfUser(BehalfOfUserItem? behalfOfUser) {
    state = state.copyWith(selectedBehalfOfUser: behalfOfUser);
  }

  Future<void> fetchUnpaidLeaveCategories() async {
    final leaveRepo = LeaveRepo();
    try {
      final unpaidLeaveCat = await leaveRepo.fetchUnpaidLeaveCategories();

      if (unpaidLeaveCat != null) {
        state = state.copyWith(unpaidLeaveCategories: unpaidLeaveCat);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching unpaid leave categories $e');
    }
  }

  void onSelectUnpaidLeaveCategory(UnpaidLeaveCategoryItem? unpaidLeaveCat) {
    state = state.copyWith(selectedUnpaidLeaveCategory: unpaidLeaveCat);
  }

  Future<void> fetchMourningLeaveRelations() async {
    final leaveRepo = LeaveRepo();
    try {
      final mourningLeaveRelations = await leaveRepo
          .fetchMourningLeaveRelation();

      if (mourningLeaveRelations != null) {
        state = state.copyWith(mourningLeaveRelations: mourningLeaveRelations);
      }
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      log('error fetching mourning leave relations $e');
    }
  }

  void onSelectMourningLeaveRelation(
    MourningLeaveRelationItem? mourningLeaveRelation,
  ) {
    state = state.copyWith(
      selectedMourningLeaveRelation: mourningLeaveRelation,
    );
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    contactNumberDuringLeaveController.dispose();
    addressDuringLeaveController.dispose();
    notesController.dispose();
    reasonForCancellationController.dispose();
    selectDurationController.dispose();
    employeeNameController.dispose();
    departmentController.dispose();
    super.dispose();
  }
}

// RIVERPOD PROVIDER
final dynamicLeaveFormControllerProvider = StateNotifierProvider.autoDispose
    .family<
      DynamicLeaveFormController,
      DynamicLeaveFormState,
      DynamicLeaveFormParams
    >((ref, params) {
      final controller = DynamicLeaveFormController(params);

      controller.startDateController = TextEditingController();
      controller.endDateController = TextEditingController();
      controller.contactNumberDuringLeaveController = TextEditingController();
      controller.addressDuringLeaveController = TextEditingController();
      controller.notesController = TextEditingController();
      controller.reasonForCancellationController = TextEditingController();
      controller.selectDurationController = TextEditingController();
      controller.employeeNameController = TextEditingController();
      controller.departmentController = TextEditingController();

      // Call your init logic or async method here.
      // For example, immediately fetch user data:
      Future.microtask(() async {
        await controller.fetchUserDataById();
        await controller.fetchLeaveTypes();
        await controller.fetchMyLeaveRequests();
        await controller.fetchKPIStats();
        await controller.fetchStatusBreakDownData();
        await controller.fetchMonthlyTrendData();
        // await controller.fetchLeaveBalances();
      });

      return controller;
    });
