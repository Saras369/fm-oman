import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../domain/core/app_info/app_info.dart';

class KAppInfoImpl implements KAppInfo {
  @override
  late final AppInfo info;

  @override
  Future<void> bootUp() async {
    log('[AppInfo.bootUp]');

    final appPackageInfo = await PackageInfo.fromPlatform();

    info = AppInfo(
      name: appPackageInfo.appName,
      version: appPackageInfo.version,
      buildNumber: appPackageInfo.buildNumber,
    );

    log('AppInfo: $info');
  }

  @override
  void bootDown() {
    log('[AppInfo.bootDown]');

    // TODO: implement bootDown
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }
}
