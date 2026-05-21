import 'dart:ui';

import 'package:code_setup/modules/locale/app_locale_provider.dart';
import 'package:code_setup/presentation/app.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KAppX.connectivity.onBootUp();

  // await KEnvironment.initialize();

  runApp(
    UncontrolledProviderScope(
      container: KAppX.globalProvider,
      child: MyApp(),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final code = await readPersistedAppLanguageCode();
    if (code != null && (code == 'ar' || code == 'en')) {
      KAppX.globalProvider.read(appLocaleProvider.notifier).state =
          Locale(code);
    }
  });
}
