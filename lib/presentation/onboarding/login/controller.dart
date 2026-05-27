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
  late TextEditingController tokenController;

  void initState() {
    tokenController = TextEditingController();
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
    state = state.copyWith(isLoading: true);
    try {
      final result = await msal.acquireToken(scopes: ['user.read']);
      accessToken = result.accessToken;
      await onGettingSSOAccessTokenFetchAuthToken(accessToken);
    } on MsalException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? 'Microsoft sign-in failed',
        timeInSecForIosWeb: 3,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Microsoft sign-in failed',
        timeInSecForIosWeb: 3,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Optional login: paste Microsoft SSO token or app auth JWT.
  Future<void> signInWithPastedToken() async {
    final pasted = tokenController.text.trim();
    if (pasted.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please paste a token to continue',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      if (_isJwtFormat(pasted)) {
        final loggedIn = await completeLoginWithAuthToken(
          pasted,
          showErrorToast: false,
        );
        if (loggedIn) return;
      }

      await onGettingSSOAccessTokenFetchAuthToken(pasted);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool _isJwtFormat(String token) => token.split('.').length == 3;

  Future<void> _signOut() async {
    await msal.signOut();
  }

  Future<void> onGettingSSOAccessTokenFetchAuthToken(String accessToken) async {
    final authRepo = AuthRepository();
    final response = await authRepo.getAuthTokenWithSSOAccessToken(accessToken);

    if (response == null || response.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Unable to authenticate with the provided token',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    final authToken = response['token'];
    if (authToken == null || authToken.toString().isEmpty) {
      Fluttertoast.showToast(
        msg: 'Authentication response did not include a token',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    await completeLoginWithAuthToken(authToken.toString());
  }

  Future<bool> completeLoginWithAuthToken(
    String token, {
    bool showErrorToast = true,
  }) async {
    final kAuthCred = KAuthCred();

    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw const FormatException('Invalid JWT token structure');
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalized);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = json.decode(decodedString);
      if (payloadMap is! Map<String, dynamic>) {
        throw const FormatException('Payload is not a valid JSON object');
      }

      payloadMap['accessToken'] = token;
      log('user details - $payloadMap');

      final user = User.fromJson(payloadMap);
      await kAuthCred.storeProfileData(user);
      KAppX.router.replace(HomeRoute());
      return true;
    } on FormatException catch (e) {
      log('FormatException while decoding JWT: $e');
      if (showErrorToast) {
        Fluttertoast.showToast(
          msg: 'Invalid token format',
          timeInSecForIosWeb: 3,
        );
      }
    } catch (e) {
      log('Unexpected error decoding JWT: $e');
      if (showErrorToast) {
        Fluttertoast.showToast(
          msg: 'Unable to sign in with this token',
          timeInSecForIosWeb: 3,
        );
      }
    }
    return false;
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }
}
