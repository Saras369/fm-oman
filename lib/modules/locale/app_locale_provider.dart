import 'dart:convert';

import 'package:code_setup/modules/domain/core/storage/persistent_storage/persistent_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kAppLocaleStorageKey = 'app_locale_v1';

/// Drives [MaterialApp.router] locale and rebuilds the tree when it changes.
final appLocaleProvider = StateProvider<Locale>((ref) => const Locale('en'));

Future<String?> readPersistedAppLanguageCode() async {
  try {
    final storage = KPersistentStorage();
    final raw = await storage.retrieve(
      key: _kAppLocaleStorageKey,
      decoder: jsonDecode,
    );
    if (raw is Map<String, dynamic>) {
      final code = raw['language_code'];
      if (code is String && (code == 'ar' || code == 'en')) return code;
    }
  } catch (_) {}
  return null;
}

Future<void> persistAppLanguageCode(String languageCode) async {
  if (languageCode != 'ar' && languageCode != 'en') return;
  final storage = KPersistentStorage();
  await storage.store(
    key: _kAppLocaleStorageKey,
    data: {'language_code': languageCode},
    encoder: jsonEncode,
    overwrite: true,
  );
}
