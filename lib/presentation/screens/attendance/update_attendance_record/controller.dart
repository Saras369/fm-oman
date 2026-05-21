part of 'view.dart';

// class _VSControllerParams extends Equatable {
//   final TaskItemDetail taskItemDetails;
//   _VSControllerParams(
//       {
//         required this.taskItemDetails,
//       });
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
// final _paramProvider = Provider<_VSControllerParams>((ref) {
//   throw UnimplementedError();
// });

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
  final String fromDate, toDate, fromTime, toTime;

  _ViewState({
    required this.isLoading,
    required this.attendanceData,
    required this.myAttendanceRequests,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        attendanceData: AttendanceData(),
        myAttendanceRequests: [],
        fromDate: '',
        toDate: '',
        fromTime: '',
        toTime: '',
      );

  _ViewState copyWith({
    bool? isLoading,
    AttendanceData? attendanceData,
    List<AttendanceRequestItem>? myAttendanceRequests,
    String? fromDate,
    String? toDate,
    String? fromTime,
    String? toTime,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      attendanceData: attendanceData ?? this.attendanceData,
      myAttendanceRequests: myAttendanceRequests ?? this.myAttendanceRequests,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
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

  void initState() {
    fromDateController = TextEditingController();
    toDateController = TextEditingController();
    fromTimeController = TextEditingController();
    toTimeController = TextEditingController();
    reasonController = TextEditingController();
    fetchAttendanceRecord();
    fetchMyAttendanceRequests();
  }

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
  Future<void> fetchAttendanceRecord() async {
    final attendanceRepo = AttendanceRepository();

    try {
      final atttendanceData = await attendanceRepo.fetchAttendanceRecord();

      if (atttendanceData != null) {
        state = state.copyWith(attendanceData: atttendanceData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {}
  }

  Future<void> fetchMyAttendanceRequests() async {
    final attendanceRepo = AttendanceRepository();
    try {
      final attendanceReq = await attendanceRepo.fetchMyAttendanceRequests();

      if (attendanceReq != null) {
        state = state.copyWith(myAttendanceRequests: attendanceReq);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> onPressUpdateCreateAttendanceRequest() async {
    final user = KAppX.globalProvider.read(userProvider);
    final isValid = formKey.currentState?.validate();
    if (isValid == true) {
      final Map<String, dynamic> data = {
        "user_id": user?.userId,
        "service_id": 1,
        "sub_service_id": 4,
        "req_user_department_id": user?.department,
        "req_user_section_id": user?.section,
        "from_date": "2025-11-21",
        "to_date": "2025-11-22",
        "from_time": "08:00",
        "to_time": "10:30",
        "reason": "Meeting",
        "comments": "Adjusting attendance to cover Ministry briefing",
      };

      final attendanceRepo = AttendanceRepository();
      try {
        state = state.copyWith(isLoading: true);
        await attendanceRepo.createUpdateAttendanceRequest(data);
        state = state.copyWith(isLoading: false);

        /// to do: fetch leave request list

        // KAppX.router.pop();
        onPressSubmitClearFormFields();
      } on ApiException catch (apiError) {
        state = state.copyWith(isLoading: false);

        Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      } catch (e) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  void onPressRequestDetails(int requestId) {}

  void onPressSubmitClearFormFields() {
    formKey.currentState?.reset();
    fromDateController.clear();
    toDateController.clear();
    fromTimeController.clear();
    toTimeController.clear();
    reasonController.clear();
    KAppX.router.pop();
  }

  Future<void> onPressFromDate(bool isFromDate) async {
    final dateTime = await KAppX.extendedRouter.showKDatePicker(
      initialDate: DateTime.now(),
      // make it todays date
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (dateTime != null) {
      if (isFromDate) {
        state = state.copyWith(
          fromDate: dateTime.formattedDateAsYearMonthDate.toString(),
        );
        fromDateController.text = dateTime.formattedDateAsDateMonthYear;
      }

      if (!isFromDate) {
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
      }

      if (!isFromTime) {
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
