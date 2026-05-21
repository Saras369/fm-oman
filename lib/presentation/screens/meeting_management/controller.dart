part of 'view.dart';

class _VSControllerParams extends Equatable {
  final List<SubServices> subServicesList;
  final int serviceId;
  _VSControllerParams({required this.subServicesList, required this.serviceId});

  @override
  List<Object> get props => [subServicesList, serviceId];
}

// final bottomNavigatorVsProvider =
//     StateNotifierProvider.autoDispose<
//       _VSController,
//       _ViewState,
//     >((ref) {
//       final stateController = _VSController();
//       return stateController;
//     });

final _vsProvider =
    StateNotifierProvider.family<
      _VSController,
      _ViewState,
      _VSControllerParams
    >((ref, params) {
      final stateController = _VSController(params);

      // stateController.initState();

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
  final _VSControllerParams params;

  _VSController(this.params) : super(_ViewState.init());

  void initState() {
    print('hello');
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

    if (index == 2) {
      // final profileStateController = KAppX.globalProvider.read(patientProfileVSProvider.notifier);
      // profileStateController.initState();
    }
  }

  String titleForIndex(int index) {
    switch (index) {
      case 0:
        return '  Collaboration';
      default:
        return '  Register Vacancy';
    }
  }
}

final bottomNavBarProvider =
    StateNotifierProvider<_BottomNavBarController, int>((ref) {
      return _BottomNavBarController();
    });

class _BottomNavBarController extends StateNotifier<int> {
  _BottomNavBarController() : super(0); // Initialize with the default index

  void setActiveIndex(int index) {
    state = index;
  }
}
