import 'dart:async';
import 'dart:developer' as developer;
import 'dart:developer';
import 'dart:io';

import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/app_extensions/app_extension.dart';
import '../../../../../domain/core/connectivity/connectivity.dart';
import '../../network.dart';

part 'interceptors/internet_connectivity.dart';
part 'interceptors/logging.dart';
part 'interceptors/no_token.dart';
part 'interceptors/retry.dart';
part 'network_client.dart';

class DioNetworkingBox
    implements
        KNetworkingBoxService<DioNetworkingClient, DioNetworkingOptions> {
  final DioNetworkingOptions defaultOptions;

  DioNetworkingBox({required this.defaultOptions});

  @override
  Future<DioNetworkingClient> client({
    DioNetworkingOptions? options,
    String? accessToken,
    required bool loggingEnabled,
  }) async {
    late DioNetworkingClient client;

    // final currentTimezoneRegion =
    //     await KAppX.services.time.getLocalTimezoneRegion();

    if (accessToken != null) {
      client = await _createSecureClient(
        accessToken: accessToken,
        // currentTimezoneRegion: currentTimezoneRegion,
        options: options,
      );
    } else {
      client = await _createUnsecureClient(
        // currentTimezoneRegion: currentTimezoneRegion,
        options: options,
      );
    }

    client.addBaseInterceptors();

    if (loggingEnabled) {
      client.addLoggingIntercept();
    }

    return client;
  }

  Future<DioNetworkingClient> _createUnsecureClient({
    // required String currentTimezoneRegion,
    DioNetworkingOptions? options,
  }) async {
    final client = options != null
        ? DioNetworkingClient.fromOptions(
            this,
            options,
            // timezone: currentTimezoneRegion,
          )
        : DioNetworkingClient(
            this,
            // timezone: currentTimezoneRegion,
          );

    return client;
  }

  Future<DioNetworkingClient> _createSecureClient({
    required String accessToken,
    // required String currentTimezoneRegion,
    DioNetworkingOptions? options,
  }) async {
    final client = options != null
        ? DioNetworkingClient.fromOptions(
            this,
            options,
            // authorizationToken: accessToken,
            // timezone: currentTimezoneRegion,
          )
        : DioNetworkingClient(
            this,
            authorizationToken: accessToken,
            // timezone: currentTimezoneRegion,
          );

    return client;
  }
}

extension DioNetworkingClientX on DioNetworkingClient {
  void addBaseInterceptors() {
    interceptors.add(DioInternetConnectivityInterceptor());
  }

  void addLoggingIntercept() {
    interceptors.add(DioRetryInterceptor(client: this));
    interceptors.add(DioNetworkLoggingInterceptor());
    interceptors.add(DioTokenInvalidInterceptor());
  }
}
