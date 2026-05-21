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
  // final Map<String, TextEditingController> controllers;
  final Map<String, String?> errors; // fieldKey -> error
  final bool isLoading;
  final UserData userData;
  final List<LeaveTypeItem> leaveTypeList;
  final String startDate, endDate;
  final List<String> selectedFileUrl;
  final List<MyLeaveRequestItem> myLeaveRequests;
  final String leaveFor;
  final List<UnpaidLeaveCategoryItem> unpaidLeaveCategories;
  final List<MourningLeaveRelationItem> mourningLeaveRelations;
  final List<BehalfOfUserItem> behalfOfUsers; // <BehalfOfUser>
  final UnpaidLeaveCategoryItem selectedUnpaidLeaveCategory;
  final MourningLeaveRelationItem selectedMourningLeaveRelation;
  final BehalfOfUserItem selectedBehalfOfUser;

  DynamicLeaveFormState({
    required this.selectedLeaveType,
    // required this.controllers,
    required this.errors,
    required this.isLoading,
    required this.userData,
    required this.leaveTypeList,
    required this.startDate,
    required this.endDate,
    required this.selectedFileUrl,
    required this.myLeaveRequests,
    required this.leaveFor,
    required this.unpaidLeaveCategories,
    required this.mourningLeaveRelations,
    required this.behalfOfUsers,
    required this.selectedUnpaidLeaveCategory,
    required this.selectedMourningLeaveRelation,
    required this.selectedBehalfOfUser,
  });

  DynamicLeaveFormState copyWith({
    LeaveTypeItem? selectedLeaveType,
    // Map<String, TextEditingController>? controllers,
    Map<String, String?>? errors,
    bool? isLoading,
    UserData? userData,
    List<LeaveTypeItem>? leaveTypeList,
    String? startDate,
    endDate,
    List<String>? selectedFileUrl,
    List<MyLeaveRequestItem>? myLeaveRequests,
    String? leaveFor,
    List<UnpaidLeaveCategoryItem>? unpaidLeaveCategories,
    List<MourningLeaveRelationItem>? mourningLeaveRelations,
    List<BehalfOfUserItem>? behalfOfUsers,
    UnpaidLeaveCategoryItem? selectedUnpaidLeaveCategory,
    MourningLeaveRelationItem? selectedMourningLeaveRelation,
    BehalfOfUserItem? selectedBehalfOfUser,
  }) {
    return DynamicLeaveFormState(
      selectedLeaveType: selectedLeaveType ?? this.selectedLeaveType,
      // controllers: controllers ?? this.controllers,
      errors: errors ?? this.errors,
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
      leaveTypeList: leaveTypeList ?? this.leaveTypeList,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedFileUrl: selectedFileUrl ?? this.selectedFileUrl,
      myLeaveRequests: myLeaveRequests ?? this.myLeaveRequests,
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
    );
  }
}

class DynamicLeaveFormController extends StateNotifier<DynamicLeaveFormState> {
  final DynamicLeaveFormParams params;

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
          leaveFor: 'Self',
          unpaidLeaveCategories: [],
          mourningLeaveRelations: [],
          behalfOfUsers: [],
          selectedUnpaidLeaveCategory: UnpaidLeaveCategoryItem(),
          selectedMourningLeaveRelation: MourningLeaveRelationItem(),
          selectedBehalfOfUser: BehalfOfUserItem(),
        ),
      );
  final formKey = GlobalKey<FormState>();

  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController contactNumberDuringLeaveController;
  late TextEditingController addressDuringLeaveController;
  late TextEditingController notesController;

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
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
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
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> onPressSelectStartDate() async {
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      state = state.copyWith(
        startDate: pickedDate.formattedDateAsYearMonthDate,
      );
      startDateController.text = pickedDate.formattedDateAsYearMonthDate;
    }
  }

  Future<void> onPressSelectEndDate() async {
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
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
    );
    startDateController.clear();
    endDateController.clear();
    contactNumberDuringLeaveController.clear();
    addressDuringLeaveController.clear();
    notesController.clear();
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

    return data;
  }

  Future<void> createLeaveRequest() async {
    final data = createLeaveRequestBody();

    final authRepo = LeaveRepo();
    try {
      state = state.copyWith(isLoading: true);
      await authRepo.createLeaveRequest(data);
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

  void onSelectLeaveType(LeaveTypeItem leaveType) {
    state = state.copyWith(selectedLeaveType: leaveType);
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
    final authRepo = LeaveRepo();
    try {
      final myLeaveReq = await authRepo.fetchMyLeaveRequests();

      if (myLeaveReq != null) {
        state = state.copyWith(myLeaveRequests: myLeaveReq);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching leave requests $e');
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
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
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
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
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
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
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

      // Call your init logic or async method here.
      // For example, immediately fetch user data:
      Future.microtask(() {
        controller.fetchUserDataById();
        controller.fetchLeaveTypes();
        controller.fetchMyLeaveRequests();
      });

      return controller;
    });
