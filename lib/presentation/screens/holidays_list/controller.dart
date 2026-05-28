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
  final HolidayModel holidayModel;

  _ViewState({required this.isLoading, required this.holidayModel});

  _ViewState.init() : this(isLoading: false, holidayModel: HolidayModel());

  _ViewState copyWith({bool? isLoading, HolidayModel? holidayModel}) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      holidayModel: holidayModel ?? this.holidayModel,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  void initState() {
    fetchHolidayList();
  }

  Future<void> fetchHolidayList() async {
    final holidayRepo = HolidaysRepo();

    try {
      final holidayData = await holidayRepo.fetchHolidayList(
        year: DateTime.now().year,
      );

      if (holidayData != null) {
        state = state.copyWith(holidayModel: holidayData);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      log(apiError.message.toString());
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }
}
