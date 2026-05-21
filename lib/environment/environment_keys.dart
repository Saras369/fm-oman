part of 'environment.dart';

class _KEnvironmentKeys {
  final Map<String, String> _envConfig;

  _KEnvironmentKeys(this._envConfig);

  /// Either `production` or `staging`
  String get environment => _envConfig['ENVIRONMENT']!;

  String get clientSecret => _envConfig['CLIENT_SECRET']!;

  String get apiUrl => _envConfig['API_URL']!;

  String get redirectUrl => _envConfig['REDIRECT_URL']!;

  String get deepLinkUrl => _envConfig['DEEP_LINK_URL']!;
  String get state => _envConfig['STATE']!;

  String get websiteUrl => _envConfig['WEBSITE_URL']!;

  String get apiContainsCheck => _envConfig['API_CONTAINS']!;

  // String get googlePlaceApiKey {
  //   if (Platform.isIOS) {
  //     return _envConfig['GOOGLE_PLACE_API_IOS_KEY']!;
  //   }
  //
  //   return _envConfig['GOOGLE_PLACE_API_ANDROID_KEY']!;
  // }
}
