// part of 'view.dart';

// class _VSControllerParams extends Equatable {
//   final String webUrl;
//   String? merchantTransactionId;
//   bool? isPayment;
//   String? startTransactionUrl;

//   _VSControllerParams({
//     required this.webUrl,
//     this.merchantTransactionId,
//     this.isPayment,
//     this.startTransactionUrl,
//   });

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
//   final bool isLoading;
//   final bool canPop;
//   _ViewState({required this.isLoading, required this.canPop});

//   _ViewState.init() : this(isLoading: false, canPop: true);

//   _ViewState copyWith({bool? canPop, bool? isLoading}) {
//     return _ViewState(
//       isLoading: isLoading ?? this.isLoading,
//       canPop: canPop ?? this.canPop,
//     );
//   }
// }

// class _VSController extends StateNotifier<_ViewState> {
//   final _VSControllerParams params;
//   _VSController(this.params) : super(_ViewState.init());
//   late WebViewController webViewController;
//   void initState() {
//     webViewUrlHit();
//     if (params.isPayment == true) {
//       state = state.copyWith(canPop: false);
//     }
//   }

//   void webViewUrlHit() {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             if (progress < 100) {
//               state = state.copyWith(isLoading: true);
//             } else {
//               state = state.copyWith(isLoading: false);
//             }
//           },
//           onPageStarted: (String url) {
//             print('on page started- $url');
//           },
//           onPageFinished: (String url) async {
//             await Future.delayed(Duration(milliseconds: 500));
//             webViewController.runJavaScript("""
//     if (typeof WOW !== 'undefined') {
//       new WOW().sync();
//     }
//   """);

//             // Force a user interaction event to unstuck the WebView
//             webViewController.runJavaScript("""
//             document.dispatchEvent(new Event('click'));
//           """);

//             // Force WebView to re-render by changing zoom levels
//             webViewController.runJavaScript(
//               "document.body.style.zoom = '1.01';",
//             );
//             await Future.delayed(Duration(milliseconds: 500));
//             webViewController.runJavaScript(
//               "document.body.style.zoom = '1.0';",
//             );
//           },
//           onHttpError: (HttpResponseError error) {
//             // state = state.copyWith(canPop: true);
//           },
//           onWebResourceError: (WebResourceError error) {
//             // state = state.copyWith(canPop: true);
//           },
//           onNavigationRequest: (NavigationRequest request) async {
//             print(request.url);
//             if (request.url.startsWith('https://google.com')) {
//               state = state.copyWith(canPop: true);
//               await KAppX.router.maybePop();
//               // await KAppX.router.maybePop();
//               KAppX.router.push(
//                 PaymentStatusRoute(
//                   merchantTransactionId: params.merchantTransactionId ?? '',
//                 ),
//               );
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse(
//           params.isPayment == true
//               ? (params.startTransactionUrl ?? '')
//               : params.webUrl,
//         ),
//       );
//   }

//   Future<void> onPopScope() async {
//     final context = KAppX.currentContext!;
//     bool shouldPop = await _showExitConfirmationDialog();
//     if (shouldPop) {
//       Navigator.of(context).pop(true);
//     }
//   }

//   Future<bool> _showExitConfirmationDialog() async {
//     return await KAppX.extendedRouter.dialog.showKDialog<bool>(
//           context: KAppX.currentContext!,
//           builder: (context) {
//             return SizedBox(
//               height: 233.toAutoScaledHeight,
//               child: ReusableAlertDialog(
//                 image: KIcons.questionIcon,
//                 message: 'Are you sure you want to cancel the payment?',
//                 noWidth: 70.toAutoScaledWidth,
//                 yesWidth: 76.toAutoScaledWidth,
//                 noText: 'No',
//                 yesText: 'Yes',
//                 onPressNo: () {
//                   Navigator.of(context).pop(false);
//                   // Close dialog, but don't pop screen
//                 },
//                 onPressYes: () {
//                   Navigator.of(context).pop(true);
//                   // Close dialog and confirm exit
//                 },
//                 isLoading: false,
//               ),
//             );
//           },
//         ) ??
//         false; // If dismissed unexpectedly, return false
//   }

//   @override
//   void dispose() {
//     webViewController.clearCache();
//     super.dispose();
//   }
// }
