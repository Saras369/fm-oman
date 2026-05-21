part of 'network.dart';

class _KNetworkHeaderKeys {
  static const String contentType = 'Content-Type';
  // static const String appVersion = 'X-App-Version';
  // static const String deviceOs = 'X-Device-OS';
  // static const String deviceOsVersion = 'X-Device-OS-Version';
}

class KNetworkingDefaults {
  KNetworkingDefaults._();

  // final String baseUrl = KEnvironment.config.apiUrl;
  final String baseUrl = 'https://fm.altomouhit.com';

  final Map<String, String> defaultHeaders = {
    _KNetworkHeaderKeys.contentType: 'application/json',
    // _KNetworkHeaderKeys.appVersion: KAppInfo.instance.info.version,
    // _KNetworkHeaderKeys.deviceOs: KDeviceInfo.instance.info.osName,
    // _KNetworkHeaderKeys.deviceOsVersion: KDeviceInfo.instance.info.osVersion,
  };
}
