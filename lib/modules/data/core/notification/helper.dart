// part of 'notification.dart';
//
// extension on RemoteMessage {
//   KPushNotification toPushNotification({
//     bool isFromNotificationTray = true,
//   }) {
//     try {
//       final _notification = KPushNotification.fromJson(
//         title: notification?.title ?? '',
//         body: notification?.body ?? '',
//         image: Platform.isAndroid ? notification?.android?.imageUrl : notification?.apple?.imageUrl,
//         isFromNotificationTray: isFromNotificationTray,
//         json: data,
//       );
//       return _notification;
//     } catch (e, st) {
//       log('Error converting RemoteMessage object to KPushNotification', name: 'PN_ERROR', error: e, stackTrace: st);
//       final _notification = KPushNotification.fromJson(
//         title: notification?.title ?? '',
//         body: notification?.body ?? '',
//         image: Platform.isAndroid ? notification?.android?.imageUrl : notification?.apple?.imageUrl,
//         isFromNotificationTray: isFromNotificationTray,
//         json: data,
//       );
//       return _notification;
//     }
//   }
// }
//
// extension on String {
//   KPushNotification toPushNotification({
//     bool isFromNotificationTray = true,
//   }) {
//     final json = jsonDecode(this);
//
//     final title = json['title'] as String;
//     final body = json['body'] as String;
//     final image = json['image'] as String?;
//
//     final notification = KPushNotification.fromJson(
//       title: title,
//       body: body,
//       image: image,
//       isFromNotificationTray: isFromNotificationTray,
//       json: json,
//     );
//
//     return notification;
//   }
//
//   int get toQuasiUniqueId {
//     late final int uniqueId;
//
//     if (isEmpty) {
//       uniqueId = 0;
//     } else {
//       uniqueId = codeUnits.reduce((value, element) => value + element);
//     }
//
//     return uniqueId;
//   }
// }
