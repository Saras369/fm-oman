part of '../network.dart';

class DioInternetConnectivityInterceptor extends Interceptor {
  bool _isDialogShowing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final status = await KConnectivity.instance.currentConnectivityStatus;

    if (status == ConnectivityStatus.disconnected) {
      if (!_isDialogShowing && KAppX.currentContext != null) {
        _isDialogShowing = true;
        // ignore: use_build_context_synchronously
        await KAppX.extendedRouter.dialog.showKDialog(
          context: KAppX.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
              'Please check your internet connection and try again.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        _isDialogShowing = false;
      }

      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
