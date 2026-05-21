// part of 'notification.dart';
//
// class KPushNotification {
//   static const String typeKey = 'notification_type';
//
//   final String title;
//   final String body;
//   final String? image;
//   final bool isFromNotificationTray;
//   // final KPushNotificationMetaData metaData;
//
//   KPushNotification({
//     required this.title,
//     required this.body,
//     // required this.metaData,
//     this.image,
//     this.isFromNotificationTray = false,
//   });
//
//   factory KPushNotification.fromJson({
//     required String title,
//     required String body,
//     String? image,
//     required Map<String, dynamic> json,
//     bool isFromNotificationTray = false,
//   }) {
//     final type = (json['notification_type'] != null ? (json['notification_type'] as String) : 'unknown').toNotificationType;
//     log('[QPushNotification.fromJson] notification_type ${type.toValue}');
//
//     late final KPushNotification notification;
//
//     switch (type) {
//       default:
//         notification = KUnknownPushNotification.fromJson(
//           title: title,
//           body: body,
//           image: image,
//           isFromNotificationTray: isFromNotificationTray,
//           json: json,
//         );
//         break;
//     }
//
//     return notification;
//   }
//
//   Map<String, dynamic> toJson() => {
//         'title': title,
//         'body': body,
//         'image': image,
//         // 'meta_data': metaData.toJson(),
//         'isFromNotificationTray': isFromNotificationTray,
//       };
//
//   @override
//   String toString() {
//     return '${toJson()}';
//   }
// }
//
// // class KPushNotificationMetaData {
// //   final bool isSilent;
// //   final String? groupKey;
// //
// //   KPushNotificationMetaData({
// //     required this.isSilent,
// //     this.groupKey,
// //   });
// //
// //   KPushNotificationMetaData.fromJson(Map<String, dynamic> json)
// //       : this(
// //           isSilent: json['is_silent'],
// //           groupKey: json['group_key'],
// //         );
// //
// //   Map<String, dynamic> toJson() => {
// //         'is_silent': isSilent,
// //         'group_key': groupKey,
// //       };
// // }
//
// ///------------------------Unknown Push Notification----------------
// class KUnknownPushNotification extends KPushNotification {
//   KUnknownPushNotification({
//     required String title,
//     required String body,
//     required bool isFromNotificationTray,
//     String? image,
//     // required KPushNotificationMetaData metaData,
//   }) : super(
//           title: title,
//           body: body,
//           image: image,
//           isFromNotificationTray: isFromNotificationTray,
//           // metaData: metaData,
//         );
//
//   KUnknownPushNotification.fromJson({
//     required String title,
//     required String body,
//     String? image,
//     required bool isFromNotificationTray,
//     required Map<String, dynamic> json,
//   }) : this(
//           title: title,
//           body: body,
//           image: image,
//           isFromNotificationTray: isFromNotificationTray,
//           // metaData: KPushNotificationMetaData.fromJson(
//           //   json['meta_data'] is String
//           //       ? jsonDecode(
//           //           json['meta_data'],
//           //         )
//           //       : json['meta_data'],
//           // ),
//         );
//
//   @override
//   Map<String, dynamic> toJson() => {
//         ...super.toJson(),
//         KPushNotification.typeKey: KNotificationType.unknown.toValue,
//       };
//
//   @override
//   String toString() {
//     return '${toJson()}';
//   }
// }
