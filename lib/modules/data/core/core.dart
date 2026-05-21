// import 'dart:async';
// import 'dart:developer';
//
// import '../../domain/core/core.dart';
//
// class KCoreModuleImpl implements KCoreModule<void> {
//   @override
//   Future<void> bootUp() async {
//     log('[CoreModule.bootUp]');
//
//     for (final coreAmenity in KCoreModule.bootUpProcesses) {
//       try {
//         await coreAmenity.bootUp().then(
//               (value) => coreAmenity.onBootUp(),
//             );
//       } catch (err) {
//         //
//       }
//     }
//   }
//
//   @override
//   void bootDown() {
//     log('[CoreModule.bootDown]');
//
//     for (final coreAmenity in KCoreModule.bootUpProcesses.reversed) {
//       try {
//         coreAmenity.bootDown();
//       } catch (err) {
//         //
//       }
//     }
//   }
//
//   @override
//   void onBootUp() {
//     // TODO: implement onBootUp
//     log('[CoreModule.onBootUp]');
//   }
// }
