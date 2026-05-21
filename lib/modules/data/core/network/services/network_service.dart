part of '../network.dart';

abstract class KNetworkingBoxService<C, O> {
  Future<C> client({
    O? options,
    String? accessToken,
    required bool loggingEnabled,
  });
}
