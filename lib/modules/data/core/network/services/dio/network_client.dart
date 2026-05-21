part of 'network.dart';

class DioNetworkingOptions {
  final String? baseUrl;
  final Map<String, String>? headers;

  DioNetworkingOptions({this.baseUrl, this.headers});
}

class DioNetworkingClient extends DioForNative {
  final DioNetworkingBox _box;

  DioNetworkingClient(
    this._box, {
    String? authorizationToken,
    // String? timezone,
  }) : super(
         BaseOptions(
           baseUrl: _box.defaultOptions.baseUrl!,
           headers: {
             ..._box.defaultOptions.headers!,
             if (authorizationToken != null) ...{'jwt': authorizationToken},
             // if (timezone != null) ...{'Timezone': timezone},
           },
           validateStatus: (_) => true,
         ),
       ) {
    log('Headers : ${_box.defaultOptions.headers!}');
  }

  DioNetworkingClient.fromOptions(
    this._box,
    DioNetworkingOptions options, {
    String? authorizationToken,
  }) : super(
         BaseOptions(
           baseUrl: options.baseUrl ?? _box.defaultOptions.baseUrl!,
           headers: {
             ..._box.defaultOptions.headers!,
             if (options.headers != null) ...options.headers!,
             if (authorizationToken != null) ...{'jwt': authorizationToken},
           },
           validateStatus: (_) => true,
         ),
       );
}
