part of 'view.dart';

class _VSControllerParams extends Equatable {
  final int serviceId;
  final int subServiceId;

  _VSControllerParams({required this.serviceId, required this.subServiceId});

  @override
  List<Object?> get props => [serviceId, subServiceId];
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
  final List<BankNameItem> bankNames;

  _ViewState({required this.isLoading, required this.bankNames});

  _ViewState.init() : this(isLoading: false, bankNames: []);

  _ViewState copyWith({bool? isLoading, List<BankNameItem>? bankNames}) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      bankNames: bankNames ?? this.bankNames,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init()) {}

  void initState() {
    fetchBankNames();
  }

  Future<void> onPressSubmit(Map<String, dynamic> values) async {
    final data = createTransferToMissionRequestBody(values);
    try {
      await missionTransferRepo.createTransferToMissionRequest(data);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Map<String, dynamic> createTransferToMissionRequestBody(
    Map<String, dynamic> values,
  ) {
    final userData = KAppX.globalProvider.read(userProvider);
    final data = {
      "service_id": params.serviceId,
      "sub_service_id": params.subServiceId,
      "req_user_department_id": userData?.department,
      "req_user_section_id": userData?.section,
      "graduation_year": values["graduationYear"],
      "country": values["country"],
      "educational_institution": values["educationalInstitution"],
      "specialization": values["specialization"],
      "qualification": values["qualification"],
      "conversation_level": values["conversationLevel"],
      "writing_level": values["writingLevel"],
      "reading_level": values["readingLevel"],
      "language": values["language"],
      "number_of_children": values["numberOfChildren"],
      "number_of_wives": values["numberOfWives"],
      "marital_status": values["maritalStatus"],
      "date_of_transfer": values["dateOfTransfer"],
      "date_of_transfer_to_it": values["dateOfTransferToIt"],
      "position_in_the_mission": values["positionOfMission"],
      "missions": values["missions"],
      "this_year_evaluation": values["thisYearEvaluation"],
      "last_year": values["lastYearEvaluation"],
      "missions_you_would_like_to_work_in": values["missionWouldLikeToWorkIn"],
    };

    return data;

    // financialServiceRepo.createPaySlipRequest(data).then((value) {
    //   KAppX.router.pop();
    //   KAppX.router.pop();
    // });
  }

  final missionTransferRepo = TransferToMissionRepo();

  List<DropdownOption<dynamic>> get bankNameOptions {
    return state.bankNames
        .map(
          (e) => DropdownOption(
            value: e.id, // ✅ store id (or full object)
            label: e.bankName ?? '', // ✅ show bank name
          ),
        )
        .toList();
  }

  Future<void> fetchBankNames() async {
    final financialServiceRepo = FinancialServicesRepo();
    try {
      final bankNames = await financialServiceRepo.fetchBankNames();

      if (bankNames != null) {
        state = state.copyWith(bankNames: bankNames);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  get missionTransferFields => [
    DynamicField(
      name: 'graduationYear',
      label: 'Graduation Year',
      type: FieldType.year,
      required: true,
      placeholder: 'Enter graduation year',
    ),
    DynamicField(
      name: 'country',
      label: 'Country',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter country',
    ),
    DynamicField(
      name: 'educationalInstition',
      label: 'Educational Instition',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter educational instition',
    ),
    DynamicField(
      name: 'specialization',
      label: 'Specialization',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter specialization',
    ),
    DynamicField(
      name: 'qualification',
      label: 'Qualification',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter qualification',
    ),
    DynamicField(
      name: 'conversationLevel',
      label: 'Conversation Level',
      type: FieldType.radio,
      required: true,
      options: ['Beginner', 'Intermediate', 'Expert'],
    ),
    DynamicField(
      name: 'writingLevel',
      label: 'Writing Level',
      type: FieldType.radio,
      required: true,
      options: ['Beginner', 'Intermediate', 'Expert'],
    ),
    DynamicField(
      name: 'readingLevel',
      label: 'Reading Level',
      type: FieldType.radio,
      required: true,
      options: ['Beginner', 'Intermediate', 'Expert'],
    ),
    DynamicField(
      name: 'language',
      label: 'Language',
      type: FieldType.select,
      required: true,
      options: [
        DropdownOption(value: 'English', label: 'English'),
        DropdownOption(value: 'Arabic', label: 'Arabic'),
      ],
    ),
    DynamicField(
      name: 'maritalStatus',
      label: 'Marital Status',
      type: FieldType.radio,
      options: ['Single', 'Married'],
      required: true,
    ),

    DynamicField(
      name: 'numberOfWives',
      label: 'Number of Wives/Spouses',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Number of Wives',
      visibleWhen: (values) => values['maritalStatus'] == 'Married',
    ),
    DynamicField(
      name: 'numberOfChildren',
      label: 'Number of Children',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Number of Children',
      visibleWhen: (values) => values['maritalStatus'] == 'Married',
    ),

    DynamicField(
      name: 'positionOfMission',
      label: 'Position Of Mission',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Position Of Mission',
    ),
    DynamicField(
      name: 'missions',
      label: 'Missions',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter missions',
    ),
    DynamicField(
      name: 'thisYearEvaluation',
      label: 'This Year Evaluation',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter This Year Evaluation',
    ),
    DynamicField(
      name: 'lastYearEvaluation',
      label: 'Last Year Evaluation',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Last Year Evaluation',
    ),
    DynamicField(
      name: 'dateOfTransfer',
      label: 'Date Of Transfer',
      type: FieldType.date,
      required: true,
      placeholder: 'Enter Date Of Transfer',
    ),
    DynamicField(
      name: 'dateOfTransferToIt',
      label: 'Date Of Transfer To It',
      type: FieldType.date,
      required: true,
      placeholder: 'Enter Date Of Transfer To It',
    ),
    DynamicField(
      name: 'missionWouldLikeToWorkIn',
      label: 'Mission Would Like To Work In',
      type: FieldType.text,
      required: true,
      placeholder: 'Enter Mission Would Like To Transfer',
    ),
    DynamicField(
      name: 'attach',
      label: 'Attach (Optional)',
      type: FieldType.file,
      required: false,
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }
}
