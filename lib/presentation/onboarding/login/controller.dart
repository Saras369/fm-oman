part of 'view.dart';

// // class _VSControllerParams extends Equatable {
// //   final TaskItemDetail taskItemDetails;
// //   _VSControllerParams(
// //       {
// //         required this.taskItemDetails,
// //       });
// //
// //   @override
// //   // TODO: implement props
// //   List<Object?> get props => [];
// // }
// //
// // final _paramProvider = Provider<_VSControllerParams>((ref) {
// //   throw UnimplementedError();
// // });

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

  _ViewState copyWith({bool? isLoading}) {
    return _ViewState(isLoading: isLoading ?? this.isLoading);
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late SingleAccountPca msal;

  void initState() {
    initializeMsal();
  }

  Future<void> initializeMsal() async {
    try {
      msal = await SingleAccountPca.create(
        clientId: 'de8765fe-2893-4413-90cf-c9e2e0ec83e2',
        androidConfig: AndroidConfig(
          configFilePath: 'assets/msal_config.json',
          redirectUri: 'msauth://com.amnet.fm/+yTKwzXT6K1fl0HQWwIryOQSHEw=',
        ),
        appleConfig: AppleConfig(
          authority:
              "https://login.microsoftonline.com/a0d55139-70f6-49e4-b912-4d13d30fc66b",
          authorityType: AuthorityType.aad,
          broker: Broker.safariBrowser,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  String accessToken = '';

  Future<void> signIn() async {
    try {
      AuthenticationResult result = await msal.acquireToken(
        scopes: ['user.read'],
      );

      accessToken = result.accessToken;

      onGettingSSOAccessTokenFetchAuthToken(accessToken);

      // Use this info to sign in your user or call Microsoft Graph APIs
    } on MsalException catch (e) {
      print('Error during login: ${e.message}');
    }
  }

  Future<void> _signOut() async {
    await msal.signOut();
  }

  Future<void> onGettingSSOAccessTokenFetchAuthToken(String accessToken) async {
    final authRepo = AuthRepository();

    final response = await authRepo.getAuthTokenWithSSOAccessToken(accessToken);

    if (response != null && response.isNotEmpty) {
      final authToken = response['token'];
      decodeJwtPayloadSafe(authToken);
    }
  }

  void decodeJwtPayloadSafe(String token) async {
    final kAuthCred = KAuthCred();

    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw FormatException('Invalid JWT token structure');
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalized);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = json.decode(decodedString);
      payloadMap['accessToken'] = token;
      log('user details - $payloadMap');
      if (payloadMap is! Map<String, dynamic>) {
        throw FormatException('Payload is not a valid JSON object');
      }

      final User user = User.fromJson((payloadMap));

      await kAuthCred.storeProfileData(user);

      KAppX.router.replace(HomeRoute());
    } on FormatException catch (e) {
      log('FormatException while decoding JWT: $e');
    } catch (e) {
      log('Unexpected error decoding JWT: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
