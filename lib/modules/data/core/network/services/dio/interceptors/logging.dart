part of '../network.dart';

class DioNetworkLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('==========================================>');
    developer.log('RequestOptions.method : ${options.method}');
    developer.log('RequestOptions.url : ${options.uri}');
    developer.log('RequestOptions Headers: ${options.headers}');
    developer.log('RequestOptions.data : ${options.data}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log('==========================================>');
    developer.log('ResponseOptions.url : ${response.realUri}');
    developer.log('ResponseOptions Headers: ${response.headers}');
    developer.log('ResponseOptions.data : ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log('DioError : $err');

    return super.onError(err, handler);
  }
}
