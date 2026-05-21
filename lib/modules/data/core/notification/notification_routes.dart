// part of 'notification.dart';
//
// class KPushNotificationType {
//   KPushNotificationType._();
//
//   static void onUnknownPushNotification(KUnknownPushNotification unknownPushNotification) {
//     void runNotificationClickedLogic() async {
//       await KAppX.profile.refresh();
//       //TODO: Update home or whatever screen with event broker before navigate
//
//       KAppX.router.navigate(HomeRoute());
//     }
//
//     void runNotificationTriggerLogic() {
//       KNotificationBox.instance.triggerLocalNotification(
//         title: unknownPushNotification.title,
//         message: unknownPushNotification.body,
//         image: unknownPushNotification.image,
//         payload: unknownPushNotification.toJson(),
//         // isSilent: unknownPushNotification.metaData.isSilent,
//         // groupKey: unknownPushNotification.metaData.groupKey,
//       );
//     }
//
//     if (unknownPushNotification.isFromNotificationTray) {
//       runNotificationClickedLogic();
//     } else {
//       runNotificationTriggerLogic();
//     }
//   }
// }
