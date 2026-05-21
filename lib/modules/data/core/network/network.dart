import 'dart:developer';

import 'package:code_setup/modules/data/core/network/services/dio/network.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';

import '../../../domain/core/network/network.dart';

part 'services/network_service.dart';

//It was time consuming to create implement complete client, for now directly type casted clients from dio service, still plug and play
class KNetworkingBoxImpl
    implements KNetworkingBox<DioNetworkingClient, DioNetworkingOptions> {
  late final KNetworkingBoxService<DioNetworkingClient, DioNetworkingOptions>
  _networkingBoxService;

  KNetworkingBoxImpl() {
    _networkingBoxService = DioNetworkingBox(
      defaultOptions: DioNetworkingOptions(
        baseUrl: KNetworkingBox.defaults.baseUrl,
        headers: KNetworkingBox.defaults.defaultHeaders,
      ),
    );
  }

  @override
  void bootDown() {
    log('[NetworkingBox.bootDown]');
    // TODO: implement bootDown
  }

  @override
  Future bootUp() {
    log('[NetworkingBox.bootUp]');
    // TODO: implement bootUp
    throw UnimplementedError();
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  Future<DioNetworkingClient?> secureClient({
    DioNetworkingOptions? options,
    bool loggingEnabled = true,
  }) async {
    DioNetworkingClient? client;
    dynamic user = await KAuthCred().getProfileData();

    String authCred = '';

    if (user != null) {
      authCred = user?.accessToken ?? '';
    }

    final isUserLoggedIn = authCred.isNotEmpty;

    if (isUserLoggedIn) {
      final accessToken = authCred;

      client = await _networkingBoxService.client(
        options: options,
        accessToken: accessToken,
        loggingEnabled: loggingEnabled,
      );
    } else {
      log('[secureClient] Client could not be created');
    }

    return client;
  }

  @override
  Future<DioNetworkingClient?> unsecureClient({
    DioNetworkingOptions? options,
    bool loggingEnabled = true,
  }) async {
    final client = await _networkingBoxService.client(
      options: options,
      loggingEnabled: loggingEnabled,
    );

    return client;
  }
}
