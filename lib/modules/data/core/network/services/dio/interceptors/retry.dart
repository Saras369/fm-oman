part of '../network.dart';

class DioRetryInterceptor extends Interceptor {
  final DioNetworkingClient client;

  late StreamSubscription<ConnectivityStatus>
  onConnectivityStatusChangedSubscription;

  bool isDisconnected = false;

  DioRetryInterceptor({required this.client});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.isRetryRequired) {
      isDisconnected = true;

      onConnectivityStatusChangedSubscription = KConnectivity
          .instance
          .onConnectivityStatusChanged
          .listen((connectivityStatus) async {
            if (connectivityStatus == ConnectivityStatus.connected) {
              onConnectivityStatusChangedSubscription.cancel();

              if (isDisconnected) {
                log('[QRetryInterceptor.onError] retry initiated');
                isDisconnected = false;

                final requestOptions = err.requestOptions;

                final retryResponse = await client.request(
                  requestOptions.path,
                  cancelToken: requestOptions.cancelToken,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                  onSendProgress: requestOptions.onSendProgress,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                );

                handler.resolve(retryResponse);
              }
            }
          });
    } else {
      super.onError(err, handler);
    }
  }
}

extension DioErrorX on DioException {
  bool get isRetryRequired {
    return type == DioExceptionType.unknown &&
        error != null &&
        error is SocketException;
  }
}
