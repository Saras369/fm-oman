// import 'package:auto_route/annotations.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

// import '../../../utils/app_extensions/app_extension.dart';
// import '../../../utils/assets/icons.dart';
// import '../../common_widgets/reusable_alert_dialog.dart';

// part 'controller.dart';

// @RoutePage()
// class WebviewScreen extends ConsumerWidget {
//   final String webUrl;
//   bool? isPayment;
//   String? merchantTransactionId;
//   String? startTransactionUrl;
//   WebviewScreen({
//     super.key,
//     required this.webUrl,
//     this.merchantTransactionId,
//     this.isPayment,
//     this.startTransactionUrl,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stateController = ref.watch(
//       _vsProvider(
//         _VSControllerParams(
//           webUrl: webUrl,
//           merchantTransactionId: merchantTransactionId,
//           isPayment: isPayment,
//           startTransactionUrl: startTransactionUrl,
//         ),
//       ).notifier,
//     );
//     final state = ref.watch(
//       _vsProvider(
//         _VSControllerParams(
//           webUrl: webUrl,
//           merchantTransactionId: merchantTransactionId,
//           isPayment: isPayment,
//           startTransactionUrl: startTransactionUrl,
//         ),
//       ),
//     );
//     return PopScope(
//       canPop: webUrl.isEmpty ? false : true,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         if (!didPop) {
//           stateController.onPopScope();
//         }
//       },

//       child: Scaffold(
//         appBar: isPayment == true ? null : KAppBar(),
//         body: state.isLoading
//             ? Center(child: KCircularLoader())
//             : SafeArea(
//                 child: WebViewWidget(
//                   controller: stateController.webViewController,
//                 ),
//               ),
//       ),
//     );
//   }
// }
