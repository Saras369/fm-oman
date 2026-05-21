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
  _ViewState({required this.isLoading});

  _ViewState.init() : this(isLoading: false);

  _ViewState copyWith({bool? isCountTen, bool? isLoading}) {
    return _ViewState(isLoading: isLoading ?? this.isLoading);
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());
  void initState() {
    userSession();
  }

  userSession() {
    KAuthCred().getProfileData().then((onValue) {
      final userInfo = KAppX.globalProvider.read(userProvider);
      if (userInfo?.accessToken != null) {
        KAppX.router.replace(HomeRoute());
      } else {
        KAppX.router.replace(LoginRoute());
        // KAppX.router.replace(KBottomNavigatorRoute());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
