import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'environment_keys.dart';

class KEnvironment {
  static const _defaultEnvFile = 'env/.default.env';
  static const _stagingEnvFile = 'env/.staging.env';
  static const _productionEnvFile = 'env/.production.env';

  static _KEnvironmentKeys? _config;
  static late final Map<String, String> _envConfig;

  // ignore: library_private_types_in_public_api
  static _KEnvironmentKeys get config {
    if (_config == null) {
      KEnvironment._internal();
    }

    return _config!;
  }

  KEnvironment._internal() {
    _config = _KEnvironmentKeys(_envConfig);
  }

  static Future<void> initialize() async {
    late final Map<String, String> defaultConfig;
    Map<String, String> finalConfig;

    try {
      defaultConfig = await _loadDefaultConfig();
    } catch (error) {
      log(
        '[ENV] ${error.runtimeType} error loading $_defaultEnvFile. Are you sure $_defaultEnvFile in present in the project directory and listed under assets in pubspec.yaml?',
      );
      rethrow;
    }

    try {
      late Map<String, String> config;

      if (kReleaseMode) {
        config = await _loadConfig(_productionEnvFile, defaultConfig);
      } else {
        config = await _loadConfig(_stagingEnvFile, defaultConfig);
      }

      finalConfig = config;
    } catch (error) {
      finalConfig = defaultConfig;
      log(
        '[ENV] ${error.runtimeType} error loading config file. Using $_defaultEnvFile as fallback.',
      );
    }

    _envConfig = finalConfig;
  }

  static Future<Map<String, String>> _loadDefaultConfig() async {
    final defaultConfig = <String, String>{};

    await dotenv.load(fileName: _defaultEnvFile);
    defaultConfig.addAll(dotenv.env);

    return defaultConfig;
  }

  static Future<Map<String, String>> _loadConfig(
    String fileName,
    Map<String, String> defaultConfig,
  ) async {
    final config = <String, String>{};

    await dotenv.load(fileName: fileName);
    config.addAll(dotenv.env);

    for (final key in defaultConfig.keys) {
      config.putIfAbsent(key, () => defaultConfig[key]!);
    }

    return config;
  }
}
