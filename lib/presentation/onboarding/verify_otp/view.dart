// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
// import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

// import '../../../utils/api_end_points.dart';
// import '../../../utils/app_extensions/app_extension.dart';
// import '../../core_widgets/buttons/action_button.dart';
// import '../login/view.dart';

// part 'controller.dart';

// @RoutePage()
// class VerifyOTPScreen extends ConsumerWidget {
//   final String mobileNumber;
//   const VerifyOTPScreen({super.key, required this.mobileNumber});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     final state = ref.watch(
//       _vsProvider(_VSControllerParams(mobileNum: mobileNumber)),
//     );
//     final stateController = ref.watch(
//       _vsProvider(_VSControllerParams(mobileNum: mobileNumber)).notifier,
//     );

//     return KScaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               35.toVerticalSizedBox,
//               Center(
//                 child: KImageProvider(
//                   width: 126.41.toAutoScaledWidth,
//                   height: 20.toAutoScaledHeight,
//                   image: KIcons.ppHorizontalLogoWithImages,
//                 ),
//               ),
//               30.toVerticalSizedBox,
//               KImageProvider(
//                 width: 202.toAutoScaledWidth,
//                 height: 214.toAutoScaledHeight,
//                 image: KIcons.ppVerification,
//               ),
//               30.toVerticalSizedBox,
//               Text(
//                 'OTP Verification',
//                 style: TextStyle(
//                   fontSize: currentTheme.fontSizes.s30,
//                   fontFamily: GoogleFonts.kanit().fontFamily,
//                   fontWeight: currentTheme.fontWeights.wBold,
//                 ),
//               ),
//               20.toVerticalSizedBox,
//               // MobileNumberInputField(
//               //   mobileInputController: stateController.mobileNumberController,
//               // ),
//               // 10.toVerticalSizedBox,
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Enter the OTP sent to +91$mobileNumber',
//                       style: TextStyle(
//                         fontSize: currentTheme.fontSizes.s14,
//                         fontFamily: GoogleFonts.lato().fontFamily,
//                         fontWeight: currentTheme.fontWeights.wRegular,
//                         color: currentTheme.colors.secondary.shade50,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         stateController.onPressEditButton();
//                       },
//                       icon: Icon(
//                         Icons.edit_outlined,
//                         color: currentTheme.colors.primary,
//                         size: 20.toAutoScaledWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               20.toVerticalSizedBox,
//               otpInput(currentTheme, stateController.otpTextController),
//               20.toVerticalSizedBox,
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Didn’t you receive the OTP?',
//                       style: TextStyle(
//                         fontSize: currentTheme.fontSizes.s13,
//                         fontFamily: GoogleFonts.lato().fontFamily,
//                         fontWeight: currentTheme.fontWeights.wRegular,
//                         color: currentTheme.colors.secondary.shade70,
//                       ),
//                     ),
//                     5.toHorizontalSizedBox,
//                     InkWell(
//                       onTap: stateController.onPressResendOTP,
//                       child: Text(
//                         'Resend OTP',
//                         style: TextStyle(
//                           fontSize: currentTheme.fontSizes.s13,
//                           fontFamily: GoogleFonts.lato().fontFamily,
//                           fontWeight: currentTheme.fontWeights.wRegular,
//                           color: currentTheme.colors.primary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               20.toVerticalSizedBox,
//               SizedBox(
//                 width: 250.toAutoScaledWidth,
//                 child: KTextActionButton(
//                   isLoading: state.isLoading,
//                   isDisabled: !state.isCountFour,
//                   onPressed: stateController.onPressVerifyOTP,
//                   text: Text(
//                     'Verify',
//                     style: TextStyle(
//                       fontSize: currentTheme.fontSizes.s16,
//                       fontFamily: GoogleFonts.lato().fontFamily,
//                       fontWeight: currentTheme.fontWeights.wBolder,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
