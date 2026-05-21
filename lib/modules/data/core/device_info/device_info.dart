import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../../../domain/core/device_info/device_info.dart';

class DeviceInfoAndroid extends DeviceInfo {
  final AndroidDeviceInfo extraAndroidDeviceInfo;
  DeviceInfoAndroid({
    required super.osName,
    required super.osVersion,
    required super.deviceName,
    required super.deviceId,
    required this.extraAndroidDeviceInfo,
  });
}

class DeviceInfoIos extends DeviceInfo {
  final IosDeviceInfo? extraIosDeviceInfo;
  DeviceInfoIos({
    required super.osName,
    required super.osVersion,
    required super.deviceName,
    required super.deviceId,
    required this.extraIosDeviceInfo,
  });
}

class KDeviceInfoImpl implements KDeviceInfo {
  @override
  late final DeviceInfo info;

  @override
  Future<void> bootUp() async {
    log('[DeviceInfo.bootUp]');

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;

      info = DeviceInfoIos(
        osName: 'iOS',
        osVersion: iosInfo.systemVersion ?? '',
        deviceName: iosInfo.name ?? '',
        deviceId: iosInfo.identifierForVendor ?? '',
        extraIosDeviceInfo: iosInfo,
      );
    } else if (Platform.isAndroid) {
      final futures = UnmodifiableListView([
        deviceInfo.androidInfo,
        // FirebaseInstallations.instance.getId(),
      ]);

      final results = await Future.wait(futures);
      final androidInfo = results[0];
      final deviceId = results[1] as String;

      info = DeviceInfoAndroid(
        osName: 'Android',
        osVersion: androidInfo.version.release ?? '',
        deviceName: androidInfo.model ?? '',
        deviceId: deviceId,
        extraAndroidDeviceInfo: androidInfo,
      );
    }

    log('DeviceInfo: $info');
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  void bootDown() {
    log('[DeviceInfo.bootDown]');
    // TODO: implement bootDown
  }
}
