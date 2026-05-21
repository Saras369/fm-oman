part of 'view.dart';

final settingsProvider =
    StateNotifierProvider.autoDispose<SettingsController, SettingsState>((ref) {
      final controller = SettingsController(ref);
      controller.initState();
      return controller;
    });

class SettingsController extends StateNotifier<SettingsState> {
  final Ref ref;

  SettingsController(this.ref) : super(SettingsState.initial());

  void initState() {
    fetchUserRoles();
    _syncStoredLanguageSelection();
  }

  Future<void> _syncStoredLanguageSelection() async {
    final code = await readPersistedAppLanguageCode();
    if (code == null || (code != 'ar' && code != 'en')) return;
    ref.read(appLocaleProvider.notifier).state = Locale(code);
    LanguageItem? selected;
    for (final l in state.languageList) {
      if (l.code == code) {
        selected = l;
        break;
      }
    }
    if (selected != null) {
      state = state.copyWith(selectedLanguage: selected);
    }
  }

  void onToggleTheme(bool value) {
    // TODO: integrate with your actual theme service
    // Example (adjust to your implementation):
    // final themeController = KAppX.globalProvider.read(KAppX.theme.current);
    // themeController.toggleTheme();
    state = state.copyWith(isDarkMode: value);
  }

  void onSelectRole(RoleDetails role) {
    // TODO: Persist selected role if needed (API / local storage)
    final authCred = KAuthCred();

    state = state.copyWith(selectedRole: role);

    authCred.storeUserMeta(
      role: role.role?.id ?? 0,
      departmentId: role.department?.id ?? 0,
      sectionId: role.section?.id ?? 0,
    );
  }

  void onSelectLanguage(LanguageItem language) {
    state = state.copyWith(selectedLanguage: language);
    ref.read(appLocaleProvider.notifier).state = Locale(language.code);
    persistAppLanguageCode(language.code);
  }

  Future<void> onLogoutPressed(BuildContext context) async {
    state = state.copyWith(isLoggingOut: true);
    try {
      await KAuthCred().clearSession();
      await KAppX.router.replaceAll([LoginRoute()]);
    } catch (e) {
      state = state.copyWith(isLoggingOut: false);
      Fluttertoast.showToast(
        msg: 'Unable to logout. Please try again.',
        timeInSecForIosWeb: 3,
      );
    }
  }

  Future<void> fetchUserRoles() async {
    final servicesRepo = AllServicesRepo();
    try {
      final services = await servicesRepo.getUserRoles();

      if (services != null) {
        state = state.copyWith(rolesList: services);
        initializeSelelctedRole();
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  Future<void> initializeSelelctedRole() async {
    final authCred = KAuthCred();
    final userMeta = await authCred.getUserMeta();
    final roleId = userMeta?['role'];
    final rolesList = state.rolesList;
    for (var role in rolesList) {
      if (roleId == role.role?.id) {
        state = state.copyWith(selectedRole: role);
      }
    }
  }
}

///
class RoleItem {
  final int id;
  final String name;

  const RoleItem({required this.id, required this.name});
}

class LanguageItem {
  final String code;
  final String name;

  const LanguageItem({required this.code, required this.name});
}

class SettingsState {
  final bool isDarkMode;
  final RoleDetails selectedRole;
  final List<LanguageItem> languageList;
  final LanguageItem? selectedLanguage;
  final bool isLoggingOut;
  final List<RoleDetails> rolesList;

  const SettingsState({
    required this.isDarkMode,
    required this.selectedRole,
    required this.languageList,
    required this.selectedLanguage,
    required this.isLoggingOut,
    required this.rolesList,
  });

  factory SettingsState.initial() {
    // You can replace these hardcoded items with real data from your API
    return SettingsState(
      isDarkMode: false,
      selectedRole: RoleDetails(),
      languageList: const [
        LanguageItem(code: 'en', name: 'English'),
        LanguageItem(code: 'ar', name: 'Arabic'),
      ],
      selectedLanguage: null,
      isLoggingOut: false,
      rolesList: [],
    );
  }

  SettingsState copyWith({
    bool? isDarkMode,
    RoleDetails? selectedRole,
    List<LanguageItem>? languageList,
    LanguageItem? selectedLanguage,
    bool? isLoggingOut,
    List<RoleDetails>? rolesList,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectedRole: selectedRole ?? this.selectedRole,
      languageList: languageList ?? this.languageList,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      rolesList: rolesList ?? this.rolesList,
    );
  }
}
