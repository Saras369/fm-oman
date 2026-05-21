part of '../../app_extension.dart';

class KThemeSetting
    implements
        _KAppSetting<
          AutoDisposeStateNotifierProvider<KThemeStateNotifier, KThemeState>,
          KThemeType
        > {
  KThemeSetting._();

  @override
  // TODO: implement current
  AutoDisposeStateNotifierProvider<KThemeStateNotifier, KThemeState>
  get current => _themeProvider;

  @override
  void switchTo(KThemeType type) {
    KAppX.globalProvider.read(_themeProvider.notifier).switchTo(type);
  }
}
