part of 'view.dart';

final allServicesVSProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      // Async fetches can finish after dispose; keepAlive reduces churn, and
      // [_VSController._applyState] avoids updating after the notifier is gone.
      ref.keepAlive();

      var isMounted = true;
      ref.onDispose(() {
        isMounted = false;
      });

      final stateController = _VSController(shouldUpdate: () => isMounted);
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final String fromDate;
  final String toDate;
  final String selectedRole;
  final List<AllServicesData>? services;
  final List<Bookmarks>? bookmarks;

  _ViewState({
    required this.isLoading,
    required this.fromDate,
    required this.toDate,
    required this.selectedRole,
    required this.services,
    required this.bookmarks,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        fromDate: '',
        toDate: '',
        selectedRole: '',
        services: [],
        bookmarks: [],
      );

  _ViewState copyWith({
    bool? isLoading,
    String? fromDate,
    String? toDate,
    String? selectedRole,
    List<AllServicesData>? services,
    List<Bookmarks>? bookmarks,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      selectedRole: selectedRole ?? this.selectedRole,
      services: services ?? this.services,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController({required bool Function() shouldUpdate})
    : _shouldUpdate = shouldUpdate,
      super(_ViewState.init());

  final bool Function() _shouldUpdate;

  void _applyState(_ViewState next) {
    if (!_shouldUpdate()) return;
    try {
      state = next;
    } catch (_) {
      // StateNotifier / Riverpod: notifier may already be disposed.
    }
  }

  void initState() {
    fetchUserRoles();
    fetchBookmarks();
  }

  final servicesRepo = AllServicesRepo();
  Future<void>? _servicesLoadFuture;

  void onTabChanged(int index) {
    // state = state.copyWith();
    // if (index == 0) fetchServices();
    // if (index == 1) fetchBookmarks();
  }

  int? _parseStoredRoleId(Map<String, dynamic>? userMeta) {
    final storedRole = userMeta?['role'];
    if (storedRole is int) return storedRole;
    return int.tryParse(storedRole?.toString() ?? '');
  }

  RoleDetails? _findRoleById(List<RoleDetails> roles, int roleId) {
    for (final role in roles) {
      if (role.role?.id == roleId) return role;
    }
    return null;
  }

  Future<void> _persistRoleMeta(KAuthCred authCred, RoleDetails role) async {
    await authCred.storeUserMeta(
      role: role.role?.id ?? 0,
      departmentId: role.department?.id ?? 0,
      sectionId: role.section?.id ?? 0,
    );
  }

  /// Loads roles, resolves the active role from storage (or defaults to the
  /// last role), then fetches services for that role.
  Future<void> fetchUserRoles() async {
    final authCred = KAuthCred();
    try {
      final roles = await servicesRepo.getUserRoles();
      if (roles == null || roles.isEmpty) return;

      final userMeta = await authCred.getUserMeta();
      final storedRoleId = _parseStoredRoleId(userMeta);
      final matchedRole = storedRoleId != null
          ? _findRoleById(roles, storedRoleId)
          : null;

      final activeRole = matchedRole ?? roles.last;
      if (matchedRole == null) {
        await _persistRoleMeta(authCred, activeRole);
      }

      _applyState(state.copyWith(selectedRole: activeRole.role?.name ?? ''));
      await fetchServices();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log(e.toString());
    }
  }

  /// Fetches all services from the server and updates the state accordingly.
  /// If the call fails, it will display a toast with the error message.
  Future<void> fetchServices() async {
    if (_servicesLoadFuture != null) return _servicesLoadFuture!;

    _servicesLoadFuture = _fetchServices();
    try {
      await _servicesLoadFuture;
    } finally {
      _servicesLoadFuture = null;
    }
  }

  Future<void> _fetchServices() async {
    _applyState(state.copyWith(isLoading: true));
    try {
      final services = await servicesRepo.fetchAllServices();

      ///user-service/user/109/role/2/services?department_id=161&section_id=402
      if (services != null && services.isNotEmpty) {
        _applyState(state.copyWith(services: services, isLoading: false));
        return;
      }
    } on ApiException catch (apiError) {
      _applyState(state.copyWith(isLoading: false));
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      log(e.toString());
      _applyState(state.copyWith(isLoading: false));
    }
  }

  Future<void> fetchBookmarks() async {
    try {
      final bookmarks = await servicesRepo.fetchBookmarks();

      if (bookmarks != null) {
        _applyState(state.copyWith(bookmarks: bookmarks));
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      log('error fetching bookmarks $e');
    }
  }

  Future<void> updateBookmark(int serviceId, {VoidCallback? onSuccess}) async {
    final userData = KAppX.globalProvider.read(userProvider);
    try {
      final data = {"service_id": serviceId, "user_id": userData?.userId};
      await servicesRepo.updateBookmark(data);
      onSuccess?.call(); // Notify caller on success
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message);
    } catch (e) {
      log('error updating bookmark $e');
    }
  }

  void onBookmarkToggle(String serviceId) {}

  void onPressSubService(List<SubServices> subServices, int serviceId) {
    if (serviceId == 46) {
      KAppX.router.push(
        KBottomNavigatorRoute(
          serviceId: serviceId,
          subServicesList: subServices,
        ),
      );
    } else if (serviceId == 47) {
      KAppX.router.push(
        FinancialServicesDashboardRoute(
          serviceId: serviceId,
          subServiceList: subServices,
        ),
      );
    } else if (_isSecurityServices(serviceId, subServices)) {
      KAppX.router.push(
        SecurityServicesRoute(
          serviceId: serviceId,
          subServicesList: subServices,
        ),
      );
    } else if (serviceId == 4) {
      KAppX.router.push(
        HelpDeskMenuRoute(serviceId: serviceId, subServicesList: []),
      );
    } else if (serviceId == 55) {
      KAppX.router.push(
        DiplomaticServicesRoute(serviceId: serviceId, subServicesList: []),
      );
    } else if (serviceId == 39) {
      KAppX.router.push(
        MeetingManagementRoute(
          serviceId: serviceId,
          subServicesList: subServices,
        ),
      );
    }
  }

  bool _isSecurityServices(int serviceId, List<SubServices> subServices) {
    final hasSecuritySubService = subServices.any((subService) {
      final name = subService.subServiceName?.toLowerCase() ?? '';
      return (name.contains('employee') && name.contains('card')) ||
          (name.contains('retired') && name.contains('card')) ||
          (name.contains('gate') && name.contains('pass'));
    });

    if (hasSecuritySubService) return true;

    return serviceId == 38 || serviceId == 40 || serviceId == 48;
  }
}
