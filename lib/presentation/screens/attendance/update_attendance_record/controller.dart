part of 'view.dart';

String attendanceApproverDisplayName(AttendanceRequestItem item) {
  final details = item.approvalDetails ?? [];
  for (final approval in details) {
    final userName = approval.approverUser?.employeeName?.trim();
    if (userName != null && userName.isNotEmpty) return userName;

    final roleName = approval.approverRole?.name?.trim();
    if (roleName != null && roleName.isNotEmpty) return roleName;
  }
  return 'N/A';
}

List<AttendanceRequestItem> filterAttendanceRequests(
  List<AttendanceRequestItem> list,
  String query,
) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return list;

  return list.where((item) {
    final idMatch = '${item.id ?? ''}'.contains(q);
    final approverMatch = attendanceApproverDisplayName(item)
        .toLowerCase()
        .contains(q);
    return idMatch || approverMatch;
  }).toList();
}

final _vsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final AttendanceData attendanceData;
  final List<AttendanceRequestItem> myAttendanceRequests;
  final List<AttendanceRequestItem> actionItems;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String searchQuery;
  final int requestListTabIndex;

  _ViewState({
    required this.isLoading,
    required this.attendanceData,
    required this.myAttendanceRequests,
    required this.actionItems,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.searchQuery,
    required this.requestListTabIndex,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        attendanceData: AttendanceData(),
        myAttendanceRequests: [],
        actionItems: [],
        fromDate: '',
        toDate: '',
        fromTime: '',
        toTime: '',
        searchQuery: '',
        requestListTabIndex: 0,
      );

  List<AttendanceRequestItem> get filteredMyRequests =>
      filterAttendanceRequests(myAttendanceRequests, searchQuery);

  List<AttendanceRequestItem> get filteredActionItems =>
      filterAttendanceRequests(actionItems, searchQuery);

  _ViewState copyWith({
    bool? isLoading,
    AttendanceData? attendanceData,
    List<AttendanceRequestItem>? myAttendanceRequests,
    List<AttendanceRequestItem>? actionItems,
    String? fromDate,
    String? toDate,
    String? fromTime,
    String? toTime,
    String? searchQuery,
    int? requestListTabIndex,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      attendanceData: attendanceData ?? this.attendanceData,
      myAttendanceRequests: myAttendanceRequests ?? this.myAttendanceRequests,
      actionItems: actionItems ?? this.actionItems,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      searchQuery: searchQuery ?? this.searchQuery,
      requestListTabIndex: requestListTabIndex ?? this.requestListTabIndex,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  late TextEditingController fromTimeController;
  late TextEditingController toTimeController;
  late TextEditingController reasonController;

  final formKey = GlobalKey<FormState>();
  final _attendanceRepo = AttendanceRepository();

  void initState() {
    fromDateController = TextEditingController();
    toDateController = TextEditingController();
    fromTimeController = TextEditingController();
    toTimeController = TextEditingController();
    reasonController = TextEditingController();
    fetchAttendanceRecord();
    _refreshMyRequestsDashboardData();
  }

  Future<void> _refreshMyRequestsDashboardData() async {
    List<AttendanceRequestItem>? myRequests;

    try {
      myRequests = await _attendanceRepo.fetchMyAttendanceRequests();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error refreshing my attendance requests: $e');
    }

    state = state.copyWith(
      myAttendanceRequests: myRequests ?? state.myAttendanceRequests,
    );
  }

  Future<void> _refreshActionItemsDashboardData() async {
    List<AttendanceRequestItem>? approvalRequests;

    try {
      approvalRequests = await _attendanceRepo.fetchAttendanceApprovalRequests();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error refreshing attendance approval requests: $e');
    }

    state = state.copyWith(
      actionItems: approvalRequests ?? state.actionItems,
    );
  }

  Future<void> switchToMyRequestsTabAndRefresh() async {
    state = state.copyWith(requestListTabIndex: 0);
    await _refreshMyRequestsDashboardData();
  }

  void setRequestListTab(int index) {
    state = state.copyWith(
      requestListTabIndex: index,
    );
    if (index == 1) {
      _refreshActionItemsDashboardData();
    } else {
      _refreshMyRequestsDashboardData();
    }
  }

  void onSearchChanged(String value) {
    state = state.copyWith(searchQuery: value);
  }

  Future<void> fetchAttendanceRecord() async {
    try {
      final atttendanceData = await _attendanceRepo.fetchAttendanceRecord();
      if (atttendanceData != null) {
        state = state.copyWith(attendanceData: atttendanceData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> onPressUpdateCreateAttendanceRequest() async {
    final user = KAppX.globalProvider.read(userProvider);
    final isValid = formKey.currentState?.validate();
    if (isValid != true) return;

    final existingServiceId = state.myAttendanceRequests.firstOrNull?.serviceId;
    final existingSubServiceId =
        state.myAttendanceRequests.firstOrNull?.subServiceId;

    final Map<String, dynamic> data = {
      'user_id': user?.userId,
      'service_id': existingServiceId ?? 46,
      'sub_service_id': existingSubServiceId ?? 189,
      'req_user_department_id': user?.department,
      'req_user_section_id': user?.section,
      'from_date': state.fromDate,
      'to_date': state.toDate,
      'from_time': state.fromTime,
      'to_time': state.toTime,
      'reason': reasonController.text.trim(),
      'comments': reasonController.text.trim(),
    };

    try {
      state = state.copyWith(isLoading: true);
      await _attendanceRepo.createUpdateAttendanceRequest(data);
      state = state.copyWith(isLoading: false);
      await onAttendanceRequestCreated();
    } on ApiException catch (apiError) {
      state = state.copyWith(isLoading: false);
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onAttendanceRequestCreated() async {
    state = state.copyWith(requestListTabIndex: 0);
    onPressSubmitClearFormFields(clearOnly: true);
    await _refreshMyRequestsDashboardData();
    KAppX.extendedRouter.dialog.closeKDialog();
  }

  void onPressRequestDetails(int requestId) {
    KAppX.router.push(UpdateAttendanceDetailsRoute(requestId: requestId));
  }

  void onPressSubmitClearFormFields({bool clearOnly = false}) {
    formKey.currentState?.reset();
    fromDateController.clear();
    toDateController.clear();
    fromTimeController.clear();
    toTimeController.clear();
    reasonController.clear();
    state = state.copyWith(fromDate: '', toDate: '', fromTime: '', toTime: '');
    if (!clearOnly) {
      KAppX.router.pop();
    }
  }

  Future<void> onPressFromDate(bool isFromDate) async {
    final dateTime = await KAppX.extendedRouter.showKDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(DateTime.now().year + 1),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (dateTime != null) {
      if (isFromDate) {
        state = state.copyWith(
          fromDate: dateTime.formattedDateAsYearMonthDate.toString(),
        );
        fromDateController.text = dateTime.formattedDateAsDateMonthYear;
      } else {
        state = state.copyWith(
          toDate: dateTime.formattedDateAsYearMonthDate.toString(),
        );
        toDateController.text = dateTime.formattedDateAsDateMonthYear;
      }
    }
  }

  Future<void> onPressTime(bool isFromTime) async {
    final dateTime = await KAppX.extendedRouter.showKTimePicker(
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (dateTime != null) {
      if (isFromTime) {
        state = state.copyWith(fromTime: dateTime.formattedTimeTrain);
        fromTimeController.text = dateTime.formattedTime;
      } else {
        state = state.copyWith(toTime: dateTime.formattedTimeTrain);
        toTimeController.text = dateTime.formattedTime;
      }
    }
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
