import '../../../../environment/environment.dart';
import '../../../data/core/network/network.dart';

part 'network_defaults.dart';

abstract class KNetworkingBox<C, O> {
  //TODO: it should be type of KNetworkingBox
  static final KNetworkingBoxImpl instance = KNetworkingBoxImpl();

  static final KNetworkingDefaults defaults = KNetworkingDefaults._();

  Future<C?> secureClient({O? options, bool loggingEnabled = true});

  Future<C?> unsecureClient({O? options, bool loggingEnabled = true});
}
