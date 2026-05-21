// import 'dart:developer';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../../utils/app_extensions/app_extension.dart';
// import '../../../domain/core/permissions/permissions.dart';
//
// class KPermissionsBoxImpl implements KPermissionBox {
//   @override
//   void bootDown() {
//     log('[PermissionsBox.bootDown]');
//     // TODO: implement bootDown
//   }
//
//   @override
//   Future<void> bootUp() async {
//     log('[PermissionsBox.bootUp]');
//     // TODO: implement bootUp
//     //throw UnimplementedError();
//   }
//
//   @override
//   void onBootUp() {
//     log('[PermissionsBox.onBootUp]');
//     // TODO: implement onBootUp
//   }
//
//   @override
//   Future<bool> requestPermission(PermissionTypes permission) async {
//     var permissionValue = await _checkPermission(permission);
//
//     if (permissionValue == PermissionValues.allowed) {
//       return true;
//     }
//
//     // late PermissionStatus status;
//
//     if (permissionValue == PermissionValues.denied) {
//       // status = await
//       _askPermission(permission);
//     }
//
//     // if (status.isGranted || status.isRestricted || status.isLimited) {
//     //   return true;
//     // }
//     //
//     // if (permissionValue == PermissionValues.permanentlyDenied ||
//     //     status == PermissionStatus.permanentlyDenied) {
//     //   _showPermissionPermanentlyDeniedNotification(permission);
//     // }
//
//     return false;
//   }
//
//   @override
//   Future<bool> checkPermission(PermissionTypes permission) async {
//     var value = false;
//     var permanentDeny = false;
//
//     var permissionStatus = await _checkPermission(permission);
//
//     if (permissionStatus == PermissionValues.allowed) {
//       value = true;
//     }
//
//     //Sometimes when permanently denied by os and not user the above function does not return anything.
//     final noPermissionReturned = value == false && permissionStatus != PermissionValues.denied;
//
//     if (noPermissionReturned) {
//       permanentDeny = await _checkIfPermanentDeny(permission);
//     }
//
//     if (permissionStatus == PermissionValues.permanentlyDenied || permanentDeny) {
//       _showPermissionPermanentlyDeniedNotification(permission);
//     }
//     return value;
//   }
//
//  void _askPermission(PermissionTypes permission) async {
//     try {
//       // late PermissionStatus status;
//       // switch (permission) {
//       //   case PermissionTypes.photo:
//       //     status = (await PhotoManager.requestPermissionExtend()).toPermissionStatus;
//       //     break;
//       // }
//       // return status;
//       showPermissionExplanationDialog();
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//   // Future<PermissionValues> _checkPermission(PermissionTypes permission) async {
//   //   var value = PermissionValues.denied;
//   //
//   //   late PermissionStatus status;
//   //
//   //   switch (permission) {
//   //     case PermissionTypes.photo:
//   //        status = (await PhotoManager.requestPermissionExtend()).toPermissionStatus;
//   //       break;
//   //   }
//   //
//   //   if (status.isGranted || status.isLimited || status.isRestricted) {
//   //     log('status.isGranted ${status.isGranted} status.isLimited ${status.isLimited}  status.isRestricted ${status.isRestricted}');
//   //     value = PermissionValues.allowed;
//   //   } else if (status == PermissionStatus.permanentlyDenied) {
//   //     log('PermissionStatus.permanentlyDenied ${PermissionStatus.permanentlyDenied}');
//   //     value = PermissionValues.permanentlyDenied;
//   //   }
//   //   return value;
//   // }
//
//   Future<bool> _checkIfPermanentDeny(PermissionTypes permission) async {
//     var value = false;
//     try {
//       switch (permission) {
//         case PermissionTypes.photo:
//
//           ///This might not be a correct
//           var req = await Permission.photos.isPermanentlyDenied;
//
//           value = req;
//           break;
//       }
//       log('value $value');
//       return value;
//     } catch (e) {
//       log('message $e');
//       return false;
//     }
//   }
//
//   void _showPermissionPermanentlyDeniedNotification(PermissionTypes permission) {
//     log('permission show $permission');
//     showPermissionExplanationDialog();
//     //TODO:
//   }
//
//   @override
//   Future<void> showAppSettings() async {
//     await openAppSettings();
//   }
// }
//
// extension on PermissionState {
//   PermissionStatus get toPermissionStatus {
//     switch (this) {
//       case PermissionState.notDetermined:
//         return PermissionStatus.permanentlyDenied;
//       case PermissionState.restricted:
//         return PermissionStatus.restricted;
//       case PermissionState.denied:
//         return PermissionStatus.denied;
//       case PermissionState.authorized:
//         return PermissionStatus.granted;
//       case PermissionState.limited:
//         return PermissionStatus.limited;
//     }
//   }
// }
//
// void showPermissionExplanationDialog() {
//   final context = KAppX.currentContext;
//   showDialog(
//     context: context!,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Allow access to continue'),
//         content: Text('To create posts, SociallOne needs permission to access your gallery to upload media and photos from this device.'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel', style: TextStyle(color: Colors.red),),
//             onPressed: () {
//               KAppX.router.pop();
//             },
//           ),
//           TextButton(
//             child: Text('Go to Settings', style: TextStyle(color: Colors.black),),
//             onPressed: () {
//               openAppSettings(); // Open app settings
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
