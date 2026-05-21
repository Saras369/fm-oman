part of 'view.dart';

// class _VSControllerParams {
//   final int requestId;

//   _VSControllerParams({required this.requestId});
// }

class _ViewState {
  final bool isLoading;
  final DepartmentCategoryItem departmentCategories;
  final OrgType selectedDepartmentCategory;
  final DepartmentItem selectedDepartementItem;
  final DepartmentItem selectedFormDepartementItem;
  final List<TelephoneDirectoryItem> contactsList;
  final String selectedPosition;
  final String selectedDiplomaticTitle;
  final String selectedMission;
  final String selectedConsulate;

  _ViewState({
    required this.isLoading,
    required this.departmentCategories,
    required this.selectedDepartementItem,
    required this.contactsList,
    required this.selectedDepartmentCategory,
    required this.selectedPosition,
    required this.selectedDiplomaticTitle,
    required this.selectedMission,
    required this.selectedConsulate,
    required this.selectedFormDepartementItem,
  });

  _ViewState copyWith({
    bool? isLoading,
    DepartmentCategoryItem? departmentCategories,
    DepartmentItem? selectedDepartementItem,
    List<TelephoneDirectoryItem>? contactsList,
    OrgType? selectedDepartmentCategory,
    String? selectedPosition,
    String? selectedDiplomaticTitle,
    String? selectedMission,
    String? selectedConsulate,
    DepartmentItem? selectedFormDepartementItem,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      departmentCategories: departmentCategories ?? this.departmentCategories,
      selectedDepartementItem:
          selectedDepartementItem ?? this.selectedDepartementItem,
      contactsList: contactsList ?? this.contactsList,
      selectedDepartmentCategory:
          selectedDepartmentCategory ?? this.selectedDepartmentCategory,
      selectedPosition: selectedPosition ?? this.selectedPosition,
      selectedDiplomaticTitle:
          selectedDiplomaticTitle ?? this.selectedDiplomaticTitle,
      selectedMission: selectedMission ?? this.selectedMission,
      selectedConsulate: selectedConsulate ?? this.selectedConsulate,
      selectedFormDepartementItem:
          selectedFormDepartementItem ?? this.selectedFormDepartementItem,
    );
  }
}

class _VsController extends StateNotifier<_ViewState> {
  late TextEditingController personNameController;
  late TextEditingController emailController;
  late TextEditingController extensionNmuberController;
  late TextEditingController contextualSearchController;
  _VsController()
    : super(
        _ViewState(
          isLoading: false,
          departmentCategories: DepartmentCategoryItem(),
          selectedDepartementItem: DepartmentItem(),
          contactsList: [],
          selectedDepartmentCategory: OrgType.fm,
          selectedPosition: '',
          selectedDiplomaticTitle: '',
          selectedMission: '',
          selectedConsulate: '',
          selectedFormDepartementItem: DepartmentItem(),
        ),
      );

  void showLoading(bool v) => state = state.copyWith(isLoading: v);
  final formKey = GlobalKey<FormState>();

  final positionList = ['Employee', 'Manager'];
  final diplomaticTitleList = ['FM', 'Embassy'];

  Future<void> fetchContactsList() async {
    final telephoneRepo = TelephoneDirectoryRepo();
    final queryParam = {
      'categories': state.selectedDepartmentCategory == OrgType.fm
          ? 'FM'
          : 'Embassy',
    };

    try {
      final contactsList = await telephoneRepo.fetchContactsList(
        state.selectedDepartementItem.id ?? 0,
        queryParam,
      );

      if (contactsList != null) {
        state = state.copyWith(contactsList: contactsList);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> fetchDepartmentsNCategories() async {
    final telephoneRepo = TelephoneDirectoryRepo();

    try {
      final departemntCategory = await telephoneRepo
          .fetchDepartemntCategoriesNList();

      if (departemntCategory != null) {
        state = state.copyWith(
          departmentCategories: departemntCategory,
          selectedDepartementItem: departemntCategory.fm?.first,
        );
        fetchContactsList();
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  String getInitials(String name) {
    if (name.trim().isEmpty) return '';
    List<String> names = name.trim().split(RegExp(r'\s+'));
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names[names.length - 1][0]).toUpperCase();
  }

  Future<void> createTelephoneDirectory() async {
    final telephoneRepo = TelephoneDirectoryRepo();
    try {
      await telephoneRepo.createTelephoneDirectory({});
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  void onSelectOrgType(OrgType orgType) {
    state = state.copyWith(
      selectedDepartmentCategory: orgType,
      selectedDepartementItem: orgType == OrgType.fm
          ? state.departmentCategories.fm?.first
          : state.departmentCategories.embassy?.first,
    );
    fetchContactsList();
  }

  void onSelectDepartmentOrgItem(DepartmentItem departmentItem) {
    state = state.copyWith(selectedDepartementItem: departmentItem);
    fetchContactsList();
  }

  void onSelectDepartmentItemInForm(DepartmentItem departmentItem) {
    state = state.copyWith(selectedFormDepartementItem: departmentItem);
  }

  void onSelectPosition(String position) {
    state = state.copyWith(selectedPosition: position);
  }

  void onSelectDiplomaticTitle(String diplomaticTitle) {
    state = state.copyWith(selectedDiplomaticTitle: diplomaticTitle);
  }

  void onSelectMission(String mission) {
    state = state.copyWith(selectedMission: mission);
  }

  void onSelectConsulate(String consulate) {
    state = state.copyWith(selectedConsulate: consulate);
  }

  void onPressSubmitClearFormFields() {
    personNameController.clear();
    emailController.clear();
    extensionNmuberController.clear();
    contextualSearchController.clear();
  }

  void onPressBack() => KAppX.router.pop();

  void onPressAddNewContact() {
    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),

      builder: (context) {
        return TelephoneDirectoryForm();
      },
    );
  }

  @override
  void dispose() {
    personNameController.dispose();
    emailController.dispose();
    extensionNmuberController.dispose();
    contextualSearchController.dispose();
    super.dispose();
  }
}

// RIVERPOD PROVIDER
final _vsProvider =
    StateNotifierProvider.autoDispose<_VsController, _ViewState>((ref) {
      final controller = _VsController();
      // ...
      controller.personNameController = TextEditingController();
      controller.emailController = TextEditingController();
      controller.extensionNmuberController = TextEditingController();
      controller.contextualSearchController = TextEditingController();
      // controller.fetchContactsList();
      controller.fetchDepartmentsNCategories();
      return controller;
    });
