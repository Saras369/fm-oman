// part of '../../app_extension.dart';
//
// class KTimeService {
//   KTimeService._();
//
//   Future<String> getLocalTimezoneRegion() async {
//     var localTimezone = await FlutterNativeTimezone.getLocalTimezone();
//
//     //Handle Asia/Kolkata Asia/Calcutta
//     if (localTimezone == 'Asia/Calcutta') {
//       localTimezone = 'Asia/Kolkata';
//     }
//
//     return localTimezone;
//   }
//
//   Future<List<String>> getAvailableTimezones() async {
//     var timezones = await FlutterNativeTimezone.getAvailableTimezones();
//
//     timezones = timezones.toSet().toList();
//
//     final localTimezoneIndex = timezones.indexOf('Asia/Calcutta');
//     if (localTimezoneIndex > -1) {
//       timezones[localTimezoneIndex] = 'Asia/Kolkata';
//     }
//
//     return timezones;
//   }
// }
