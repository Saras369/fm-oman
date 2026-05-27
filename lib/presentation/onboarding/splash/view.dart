import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final StateController = ref.watch(_vsProvider.notifier);
    return KScaffold(body: SafeArea(child: Container()));
  }
}

// import 'package:auto_route/auto_route.dart';
// import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

// import '../../core_widgets/image/image_provider.dart';

// @RoutePage()
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late Animation<double> _secondAnimation;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     // Define the animation (from 0.0 to 1.0)
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
//       ),
//     );
//     _secondAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1, curve: Curves.easeInOut),
//       ),
//     );

//     // Add a listener to detect when the animation completes
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         userSession(); // Route change only after the animation completes
//       }
//     });

//     // Start the animation
//     _controller.forward();

//     // Future.delayed(const Duration(seconds: 2), () {
//     //   userSession();
//     // });
//     super.initState();
//   }

//   userSession() {
//     KAuthCred().getProfileData().then((onValue) {
//       final userInfo = KAppX.globalProvider.read(userProvider);
//       if (context.mounted) {
//         if (userInfo.token != null) {
//           KAppX.router.replace(KBottomNavigatorRoute());
//         } else {
//           KAppX.router.replace(LoginRoute());
//           // KAppX.router.replace(KBottomNavigatorRoute());
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: buildDiagonalAnimatedWidget(
//               'assets/icon/icon.png',
//               _animation,
//               167.69,
//               167.88,
//             ),
//           ),
//           20.toVerticalSizedBox,
//           buildAnimatedWidget(
//             KIcons.radiogramText,
//             _secondAnimation,
//             259.16,
//             23.71,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class AnimatedImage extends StatelessWidget {
// //   final Animation<double> animation;
// //   final String imagePath;
// //   final double width;
// //   final double height;
// //
// //   const AnimatedImage({
// //     Key? key,
// //     required this.animation,
// //     required this.imagePath,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: animation,
// //       builder: (context, child) {
// //         return ClipRect(
// //           child: Align(
// //             alignment: Alignment.centerLeft,
// //             widthFactor: animation.value, // Gradually increases width
// //             child: child,
// //           ),
// //         );
// //       },
// //       child: KImageProvider(
// //         imagePath,
// //         width: 300, // Adjust as per your requirement
// //         fit: BoxFit.cover,
// //       ),
// //     );
// //   }
// // }

// Widget buildAnimatedWidget(
//   String image,
//   Animation<double> animation,
//   double width,
//   double height,
// ) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (context, child) {
//       return Stack(
//         children: [
//           KImageProvider(
//             width: width.toAutoScaledWidth,
//             height: height.toAutoScaledHeight,
//             image: image,
//             fit: BoxFit.fill,
//             tintColor: Colors.transparent,
//           ),
//           ClipRect(
//             child: Align(
//               alignment: Alignment.centerLeft,
//               widthFactor:
//                   animation.value, // Reveal the text from left to right
//               child: child,
//             ),
//           ),
//         ],
//       );
//     },
//     child: KImageProvider(
//       width: width.toAutoScaledWidth,
//       height: height.toAutoScaledHeight,
//       image: image,
//       fit: BoxFit.fill,
//     ),
//   );
// }

// Widget buildDiagonalAnimatedWidget(
//   String image,
//   Animation<double> animation,
//   double width,
//   double height,
// ) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (context, child) {
//       return Stack(
//         children: [
//           KImageProvider(
//             width: width.toAutoScaledWidth,
//             height: height.toAutoScaledWidth,
//             image: image,
//             fit: BoxFit.fill,
//             tintColor: Colors.transparent,
//           ),
//           ClipRect(
//             child: Align(
//               alignment: Alignment.topLeft,
//               widthFactor:
//                   animation.value, // Reveal the text from left to right
//               heightFactor: animation.value,
//               child: child,
//             ),
//           ),
//         ],
//       );
//     },
//     child: KImageProvider(
//       width: width.toAutoScaledWidth,
//       height: height.toAutoScaledWidth,
//       image: image,
//       fit: BoxFit.fill,
//     ),
//   );
// }
