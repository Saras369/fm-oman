// import 'package:code_setup/utils/app_extensions/app_extension.dart';
// import 'package:flutter/material.dart';

// class PermissionHandlerUtil {
//   /// ✅ Request Storage Permission Based on Android Version
//   static Future<bool> requestStoragePermission() async {
//     if (await _hasStoragePermission()) {
//       return true; // Already granted
//     }

//     // Request permissions based on Android version
//     // PermissionStatus storageStatus = await Permission.storage.request();
//     // PermissionStatus manageStatus = await Permission.manageExternalStorage.request();
//     //
//     // if (storageStatus.isGranted || manageStatus.isGranted) {
//     //   return true; // Permission granted
//     // }

//     // If permanently denied, show dialog and guide user to settings
//     // if (storageStatus.isPermanentlyDenied || manageStatus.isPermanentlyDenied) {
//     //   bool openedSettings = await _showPermissionDialog(
//     //       KAppX.currentContext!,
//     //       "Storage Permission",
//     //       "This app requires storage permission to download files. Please allow access from settings.");
//     //   return openedSettings ? await requestStoragePermission() : false;
//     // }

//     return false; // Permission not granted
//   }

//   /// ✅ Request Notification Permission & Show Dialog If Denied
//   static Future<bool> requestNotificationPermission() async {
//     if (await Permission.notification.isGranted) {
//       return true; // Already granted
//     }

//     // Request notification permission
//     PermissionStatus status = await Permission.notification.request();
//     if (status.isGranted) {
//       return true;
//     }

//     // If permanently denied, show dialog & check permission again after user action
//     if (status.isPermanentlyDenied) {
//       bool openedSettings = await _showPermissionDialog(
//           KAppX.currentContext!,
//           "Notification Permission",
//           "This app requires notification permission to show download progress. Please allow access from settings.");
//       return openedSettings ? await openAppSettings() : false;
//     }

//     return false;
//   }

//   /// 🔍 Helper: Check if Storage Permission is Already Granted
//   static Future<bool> _hasStoragePermission() async {
//     return await Permission.storage.isGranted || await Permission.manageExternalStorage.isGranted;
//   }

//   /// 📌 Show Permission Dialog & Wait for User Action
//   static Future<bool> _showPermissionDialog(
//       BuildContext context, String title, String message) async {
//     bool permissionGranted = false;

//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent closing without action
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, false);
//             },
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context, true);
//               await openAppSettings(); // 🔥 Redirect to App Settings
//             },
//             child: Text("Open Settings"),
//           ),
//         ],
//       ),
//     ).then((value) {
//       permissionGranted = value ?? false;
//     });

//     return permissionGranted;
//   }
// }
