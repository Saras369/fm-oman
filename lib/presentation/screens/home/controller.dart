part of 'view.dart';

class BottomNavigatorVSControllerParams extends Equatable {
  final BuildContext context;
  BottomNavigatorVSControllerParams({required this.context});

  @override
  List<Object> get props => [];
}

class Equatable {}

final bottomNavigatorVsProvider =
    StateNotifierProvider.family<
      _VSController,
      _ViewState,
      BottomNavigatorVSControllerParams
    >((ref, params) {
      final stateController = _VSController(params);
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final int currentTabIndex;

  _ViewState({required this.currentTabIndex});

  _ViewState.init() : this(currentTabIndex: 0);

  _ViewState copyWith({int? currentTabIndex}) {
    return _ViewState(currentTabIndex: currentTabIndex ?? this.currentTabIndex);
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final BottomNavigatorVSControllerParams params;
  _VSController(this.params) : super(_ViewState.init());

  void initState() {
    printUserData();
  }

  Future<void> printUserData() async {
    final userData = await KAuthCred().getProfileData();
    log(userData!.toJson().toString());
  }

  int get currentTabIndex {
    return state.currentTabIndex;
  }

  // AutoTabsRouter.of(params.context).activeIndex;

  void onTabChanged(int index) {
    // getting context
    // final tabsRouter = AutoTabsRouter.of(context);
    //
    // tabsRouter.setActiveIndex(index);
    state = state.copyWith(currentTabIndex: index);

    // Services are loaded in [allServicesVSProvider] via fetchUserRoles → fetchServices.
    // Do not call fetchServices here; that caused a duplicate API request on tab open.
  }
}

final homeNavBarProvider = StateNotifierProvider<_BottomNavBarController, int>((
  ref,
) {
  return _BottomNavBarController();
});

class _BottomNavBarController extends StateNotifier<int> {
  _BottomNavBarController() : super(0); // Initialize with the default index

  void setActiveIndex(int index) {
    state = index;
  }
}
