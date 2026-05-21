// part of 'view.dart';

// class _VSControllerParams extends Equatable {
//   final String mobileNum;
//   _VSControllerParams({required this.mobileNum});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

// final _paramProvider = Provider<_VSControllerParams>((ref) {
//   throw UnimplementedError();
// });

// final _vsProvider = StateNotifierProvider.autoDispose
//     .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
//       final stateController = _VSController(params);

//       stateController.initState();

//       return stateController;
//     });

// class _ViewState {
//   final bool isCountFour;
//   final bool isLoading;
//   _ViewState({required this.isCountFour, required this.isLoading});

//   _ViewState.init() : this(isCountFour: false, isLoading: false);

//   _ViewState copyWith({bool? isCountFour, bool? isLoading}) {
//     return _ViewState(
//       isCountFour: isCountFour ?? this.isCountFour,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }

// class _VSController extends StateNotifier<_ViewState> {
//   final _VSControllerParams params;
//   _VSController(this.params) : super(_ViewState.init());
//   late TextEditingController mobileNumberController;
//   late TextEditingController otpTextController;
//   void initState() {
//     mobileNumberController = TextEditingController(text: params.mobileNum);
//     otpTextController = TextEditingController();
//     otpTextController.addListener(() {
//       onChangeMobileInputText();
//     });
//   }

//   void onChangeMobileInputText() {
//     if (otpTextController.text.length == 4) {
//       state = state.copyWith(isCountFour: true);
//     } else {
//       state = state.copyWith(isCountFour: false);
//     }
//   }

//   void onPressVerifyOTP() async {
//     final data = {
//       "phoneNumber": params.mobileNum,
//       "otp": otpTextController.text,
//     };

//     final repo = VerifyOtpRepo();
//     state = state.copyWith(isLoading: true);
//     final response = await repo.validateOTP(data);
//     dynamic msg = '';
//     if (response.data != null) {
//       msg = response.data['message'];
//     }
//     // if(response['message'] != null) {
//     //   msg = response['message'];
//     // }
//     state = state.copyWith(isLoading: false);
//     if (response != null && response.statusCode == 200) {
//       final data = PatientLoginModel.fromJson(response.data);
//       await KAuthCred().storeProfileData(data.data ?? PatientLoginDetails());
//       KAppX.router.replace(KBottomNavigatorRoute());
//     } else {
//       Fluttertoast.showToast(
//         msg: msg ?? "Failed to verify otp",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 3,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   void onPressEditButton() {
//     KAppX.router.replace(LoginRoute());
//   }

//   void onPressResendOTP() async {
//     final loginRepo = LoginRepo();

//     final Map<String, dynamic> data = {'primaryPhoneNumber': params.mobileNum};
//     final response = await loginRepo.sendOTP(data);
//     final status = response['status'];
//     final msg = response['message'];
//     if (status == 'success') {
//       Fluttertoast.showToast(
//         msg: "OTP resent successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 3,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else {
//       Fluttertoast.showToast(
//         msg: msg ?? "Failed to resend otp",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 3,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
