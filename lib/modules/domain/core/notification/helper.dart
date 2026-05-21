// part of 'notification.dart';
//
// const notificationTypeMap = <KNotificationType, String>{};
//
// extension ToKNotificationTypeEnum on String {
//   KNotificationType get toNotificationType {
//     late KNotificationType _enum;
//     try {
//       _enum = notificationTypeMap.keys.firstWhere(
//         (key) => notificationTypeMap[key] == this,
//       );
//     } catch (e) {
//       _enum = KNotificationType.unknown;
//     }
//     return _enum;
//   }
// }
//
// extension ToKNotificationTypeValue on KNotificationType {
//   String get toValue {
//     final value = notificationTypeMap[this] ?? 'unknown';
//     return value;
//   }
// }
