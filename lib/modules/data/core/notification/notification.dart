// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:math' as math;
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show SchedulerBinding;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sociall_one/modules/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
// import 'package:sociall_one/modules/domain/core/notification/notification.dart';
// import 'package:sociall_one/repository/domain/user/user_repository.dart';
// import 'package:sociall_one/utils/app_extensions/app_extension.dart';
//
// part 'helper.dart';
// part 'notification_routes.dart';
//
// Future<void> _onFirebaseBackgroundMessage(RemoteMessage message) async {
//   log('[_onFirebaseBackgroundMessage] remoteNotification: ${message.notification}');
//   log('[_onFirebaseBackgroundMessage] remoteNotification.contentAvailable: ${message.contentAvailable}');
//   log('[_onFirebaseBackgroundMessage] remoteNotification.messageId: ${message.messageId}');
//
//   final notification = message.toPushNotification();
//   log('[_onBackgroundMessage] notification: $notification');
//   //TODO: check if working
// }
//
// class KNotificationBoxImpl implements KNotificationBox {
//   final StreamController<String> _tokensStreamController = StreamController<String>.broadcast();
//   final StreamController<KPushNotification> _notificationsStreamController = StreamController<KPushNotification>.broadcast();
//
//   late StreamSubscription<String> _onTokenRefreshStreamSubscription;
//   late StreamSubscription<RemoteMessage> _onMessageStreamSubscription;
//   late StreamSubscription<RemoteMessage> _onMessageOpenedStreamSubscription;
//
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   @override
//   Future<void> bootUp() async {
//     log('[NotificationBox.bootUp]');
//     final settings = await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onBackgroundMessage(_onFirebaseBackgroundMessage);
//
//       final setUpProcesses = <Future>[
//         //Add any other process
//         _setUpFirebaseMessagingTokenListeners(),
//         _setUpNotificationListeners(),
//         _setUpLocalNotificationsPlugin(),
//       ];
//
//       await Future.wait(setUpProcesses);
//     }
//   }
//
//   Future<void> _setUpFirebaseMessagingTokenListeners() async {
//     _onTokenRefreshStreamSubscription = FirebaseMessaging.instance.onTokenRefresh.listen(
//       (String token) {
//         log('[FirebaseMessaging.onTokenRefresh] token: $token');
//
//         _tokensStreamController.add(token);
//       },
//     );
//   }
//
//   Future<void> _setUpNotificationListeners() async {
//     _onMessageStreamSubscription = FirebaseMessaging.onMessage.listen(
//       (RemoteMessage remoteMessage) {
//         log('[FirebaseMessaging.onMessage] remoteMessage.notification: ${remoteMessage.notification}');
//         log('[FirebaseMessaging.onMessage] remoteMessage.data: ${remoteMessage.data}');
//         log('[FirebaseMessaging.onMessage] remoteMessage.messageId: ${remoteMessage.messageId}');
//
//         _reportDelayedNotification(remoteMessage);
//         final remoteNotification = remoteMessage.toPushNotification(
//           isFromNotificationTray: false,
//         );
//
//         log('[FirebaseMessaging.onMessage] notification');
//         log('[FirebaseMessaging.onMessage] notification: $remoteNotification');
//
//         _notificationsStreamController.add(remoteNotification);
//         log('[FirebaseMessaging.onMessage] end of onMessage');
//       },
//     );
//
//     _onMessageOpenedStreamSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
//       (RemoteMessage remoteMessage) {
//         log('[FirebaseMessaging.onMessageOpenedApp] remoteMessage.notification: ${remoteMessage.notification}');
//         log('[FirebaseMessaging.onMessageOpenedApp] remoteMessage.data: ${remoteMessage.data}');
//         log('[FirebaseMessaging.onMessageOpenedApp] remoteMessage.messageId: ${remoteMessage.messageId}');
//
//         final remoteNotification = remoteMessage.toPushNotification();
//         log('[FirebaseMessaging.onMessageOpenedApp] notification: $remoteNotification');
//
//         _notificationsStreamController.add(remoteNotification);
//       },
//     );
//   }
//
//   final _highImportanceAndroidNotificationChannel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );
//
//   final _lowImportanceAndroidNotificationChannel = AndroidNotificationChannel(
//     'low_importance_channel',
//     'Low Importance Notifications',
//     description: 'This channel is used for low importance notifications',
//     importance: Importance.low,
//   );
//
//   Future<void> _setUpLocalNotificationsPlugin() async {
//     final initializationSettingsAndroid = AndroidInitializationSettings(
//       'ic_notification_icon',
//     );
//
//     final initializationSettingsIOS = IOSInitializationSettings(
//       defaultPresentAlert: false,
//       defaultPresentSound: false,
//       defaultPresentBadge: false,
//     );
//
//     final initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (payloadString) {
//         log('[flutterLocalNotificationsPlugin.onSelectNotification] payload: $payloadString');
//         log('[flutterLocalNotificationsPlugin.onSelectNotification] payload.runtimeType: ${payloadString.runtimeType}');
//
//         if (payloadString != null && payloadString.isNotEmpty) {
//           log('[flutterLocalNotificationsPlugin.onSelectNotification] payloadString != null && payloadString.isNotEmpty');
//
//           final localNotification = payloadString.toPushNotification();
//
//           log('[flutterLocalNotificationsPlugin.onSelectNotification] localNotification: $localNotification');
//
//           _notificationsStreamController.add(localNotification);
//         }
//       },
//     );
//
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_lowImportanceAndroidNotificationChannel);
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_highImportanceAndroidNotificationChannel);
//   }
//
//   @override
//   void bootDown() {
//     log('[NotificationBox.bootDown]');
//     _onTokenRefreshStreamSubscription.cancel();
//     _onMessageStreamSubscription.cancel();
//     _onMessageOpenedStreamSubscription.cancel();
//     _tokensStreamController.close();
//     _notificationsStreamController.close();
//
//     _onTokenRefreshedSubscription.cancel();
//     _onPushNotificationSubscription.cancel();
//   }
//
//   late StreamSubscription<String> _onTokenRefreshedSubscription;
//   late StreamSubscription<KPushNotification> _onPushNotificationSubscription;
//
//   @override
//   void onBootUp() async {
//     _onTokenRefreshedSubscription = onTokenRefresh.listen(
//       (token) => _registerNotificationToken(token),
//     );
//
//     _onPushNotificationSubscription = onNotification.listen(
//       (notification) {
//         KAppX.router.onPushNotification(notification);
//       },
//     );
//   }
//
//   Future<void> _registerNotificationToken(String token) async {
//     final usersRepository = UsersRepository();
//
//     await usersRepository.registerFCMToken(
//       request: RegisterTokenRequest(
//         deviceToken: token,
//       ),
//     );
//   }
//
//   @override
//   Future<String?> get token async {
//     final token = await FirebaseMessaging.instance.getToken();
//     log('[FirebaseMessaging.token] token: $token');
//
//     return token;
//   }
//
//   @override
//   Stream<String> get onTokenRefresh => _tokensStreamController.stream;
//
//   @override
//   Future<KPushNotification?> get startUpNotification async {
//     log('Notification verify 251');
//     final initialRemoteMessage = await FirebaseMessaging.instance.getInitialMessage();
//
//     if (initialRemoteMessage != null) {
//       final remoteNotification = initialRemoteMessage.toPushNotification();
//       log('[FirebaseMessaging.initialRemoteMessage] startUpNotification : $remoteNotification');
//
//       return remoteNotification;
//     }
//
//     final initialLocalMessage = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     final payloadString = initialLocalMessage?.payload;
//
//     if (payloadString != null && payloadString.isNotEmpty) {
//       final localNotification = payloadString.toPushNotification();
//
//       log('[flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails] startUpNotification : $localNotification');
//
//       return localNotification;
//     }
//
//     return null;
//   }
//
//   @override
//   Stream<KPushNotification> get onNotification => _notificationsStreamController.stream;
//
//   @override
//   Future<void> triggerLocalNotification({
//     int? id,
//     required String title,
//     required String message,
//     required Map<String, dynamic> payload,
//     String? image,
//     bool isSilent = true,
//     String? groupKey,
//   }) async {
//     final brightness = SchedulerBinding.instance.window.platformBrightness;
//     final isDarkMode = brightness == Brightness.dark;
//
//     final notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         isSilent ? _lowImportanceAndroidNotificationChannel.id : _highImportanceAndroidNotificationChannel.id,
//         isSilent ? _lowImportanceAndroidNotificationChannel.name : _highImportanceAndroidNotificationChannel.name,
//         channelDescription: isSilent ? _lowImportanceAndroidNotificationChannel.description : _highImportanceAndroidNotificationChannel.description,
//         priority: isSilent ? Priority.low : Priority.max,
//         importance: isSilent ? Importance.low : Importance.max,
//         icon: image,
//         tag: groupKey,
//         //TODO: colors of notification
//         color: !isDarkMode ? Colors.black38 : Colors.white,
//       ),
//       iOS: IOSNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: !isSilent,
//         threadIdentifier: groupKey,
//       ),
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       id ?? groupKey?.toQuasiUniqueId ?? math.Random().nextInt(12345),
//       title,
//       message,
//       notificationDetails,
//       payload: jsonEncode(payload),
//     );
//   }
//
//   @override
//   Future<void> triggerPersistentNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? image,
//     String? payload,
//   }) async {
//     final brightness = SchedulerBinding.instance.window.platformBrightness;
//     final isDarkMode = brightness == Brightness.dark;
//
//     final notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         _lowImportanceAndroidNotificationChannel.id,
//         _lowImportanceAndroidNotificationChannel.name,
//         channelDescription: _lowImportanceAndroidNotificationChannel.description,
//         priority: Priority.defaultPriority,
//         importance: Importance.defaultImportance,
//         //TODO: colors of notification
//         color: !isDarkMode ? Colors.black38 : Colors.white,
//         ongoing: true,
//         autoCancel: false,
//       ),
//       iOS: IOSNotificationDetails(
//         presentAlert: false,
//         presentBadge: false,
//         presentSound: false,
//       ),
//     );
//
//     await _flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: payload);
//   }
//
//   @override
//   Future<void> cancelNotification({
//     required int id,
//   }) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   @override
//   Future<void> startForegroundService({
//     required int id,
//     required String title,
//     required String body,
//     String? image,
//     String? payload,
//     required Set<AndroidServiceForegroundType> serviceTypes,
//   }) async {
//     if (!Platform.isAndroid) {
//       log('startForegroundService was called from a platform which is not Android, returning...',
//           name: 'NotificationsAmenityImpl.startForegroundService');
//       return;
//     }
//
//     final brightness = SchedulerBinding.instance.window.platformBrightness;
//     final isDarkMode = brightness == Brightness.dark;
//
//     final androidNotificationDetails = AndroidNotificationDetails(
//       _lowImportanceAndroidNotificationChannel.id,
//       _lowImportanceAndroidNotificationChannel.name,
//       channelDescription: _lowImportanceAndroidNotificationChannel.description,
//       priority: Priority.defaultPriority,
//       importance: Importance.defaultImportance,
//       //TODO: colors of notification
//       color: !isDarkMode ? Colors.black38 : Colors.white,
//     );
//
//     final plugin = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//
//     await plugin?.startForegroundService(
//       id,
//       title,
//       body,
//       notificationDetails: androidNotificationDetails,
//       payload: payload,
//       startType: AndroidServiceStartType.startSticky,
//       foregroundServiceTypes: serviceTypes,
//     );
//   }
//
//   @override
//   Future<void> stopForegroundService() async {
//     if (!Platform.isAndroid) {
//       log(
//         'stopForegroundService was called from a platform which is not Android, returning...',
//         name: 'NotificationsAmenityImpl.stopForegroundService',
//       );
//
//       return;
//     }
//
//     final plugin = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//
//     await plugin?.stopForegroundService();
//   }
// }
//
// Future<void> _reportDelayedNotification(RemoteMessage remoteMessage) async {
//   log('Testing delay in PN', name: 'delayed_notification');
//   const timeDelta = Duration(minutes: 5);
//   final now = DateTime.now();
//
//   if (remoteMessage.sentTime == null) {
//     log('RemoteMessage.sentTime was null, abort testing for delay', name: 'delayed_notification');
//
//     return;
//   }
//
//   final notificationDelay = now.difference(remoteMessage.sentTime!);
//   final isNotificationDelayed = notificationDelay > timeDelta;
//
//   if (isNotificationDelayed) {
//     log('Delayed PN received, Delay in ms: ${notificationDelay.inMilliseconds}', name: 'delayed_notification');
//     // final profileDetails = KAppX.currentContext?.read(KAppX.profile.current);
//
//     // final formattedMessage = 'PN delayed for user ${profileDetails?.uid} by ${notificationDelay.inSeconds} seconds';
//
//     //TODO: send analytics
//   } else {
//     log('PN NOT delayed', name: 'delayed_notification');
//   }
// }
