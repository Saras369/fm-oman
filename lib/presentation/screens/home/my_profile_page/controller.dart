part of 'view.dart';

// class _VSControllerParams extends Equatable {

//   _VSControllerParams({
//   });

//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

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

  _ViewState copyWith({bool? canPop, bool? isLoading}) {
    return _ViewState(isLoading: isLoading ?? this.isLoading);
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  IO.Socket? socket;

  void initState() {
    _initSocket();
  }

  void _initSocket() {
    print('Initializing socket connection for testing...');
    socket = IO.io(
      'https://fm.altomouhit.com/',
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setPath('/socket.io')
          .disableAutoConnect()
          .build(),
    );

    socket?.connect();

    socket?.onConnect((_) {
      print('✅ Socket test: Connected to server!');
    });

    socket?.onDisconnect((_) {
      print('❌ Socket test: Disconnected!');
    });

    socket?.onError((error) {
      print('⚠️ Socket test Error: $error');
    });
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }
}
