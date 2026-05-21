part of '../../theme.dart';

class KThemeColorsLightImpl implements KThemeColors {
  static const int _primaryMainValue = 0XFFCD2027;
  @override
  KMaterialColor get primary =>
      KMaterialColor(_primaryMainValue, const <int, Color>{
        10: Color(0xFF07006C),
        20: Color(0xFF1200A9),
        30: Color(0xFF2E2BC2),
        40: Color(0xFF4849DA),
        50: Color(_primaryMainValue),
        60: Color(0xFF8083FF),
        70: Color(0xFFA0A3FF),
        80: Color(0xFFC1C1FF),
        90: Color(0xFFE1E0FF),
        95: Color(0xFFF2EFFF),
        99: Color(0xFFFFFBFF),
      });

  static const int _onPrimaryMainValue = 0xFFFFFFFF;
  @override
  KMaterialColor get onPrimary =>
      KMaterialColor(_onPrimaryMainValue, const <int, Color>{
        10: Color(0xFFFFFFFF),
        20: Color(0xFFFFFFFF),
        30: Color(0xFFFFFFFF),
        40: Color(0xFFFFFFFF),
        50: Color(_onPrimaryMainValue),
        60: Color(0xFF000000),
        70: Color(0xFF000000),
        80: Color(0xFF000000),
        90: Color(0xFF000000),
        95: Color(0xFF000000),
        99: Color(0xFF000000),
      });

  static const int _secondaryMainValue = 0xFF1A1A1A;
  @override
  KMaterialColor get secondary =>
      KMaterialColor(_secondaryMainValue, const <int, Color>{
        10: Color(_secondaryMainValue),
        20: Color(0xFF333333),
        30: Color(0xFF4D4D4D),
        40: Color(0xFF666666),
        50: Color(0xFF808080),
        60: Color(0xFF999999),
        70: Color(0xFFB2B2B2),
        80: Color(0xFFCCCCCC),
        90: Color(0xFFE5E5E5),
        95: Color(0xFFF2F2F2),
        99: Color(0xFFF9F9F9),
      });

  static const int _onSecondaryMainValue = 0xFFFFFFFF;
  @override
  KMaterialColor get onSecondary =>
      KMaterialColor(_onSecondaryMainValue, const <int, Color>{
        10: Color(0xFFFFFFFF),
        20: Color(0xFFFFFFFF),
        30: Color(0xFFFFFFFF),
        40: Color(0xFFFFFFFF),
        50: Color(_onSecondaryMainValue),
        60: Color(0xFF000000),
        70: Color(0xFF000000),
        80: Color(0xFF000000),
        90: Color(0xFF000000),
        95: Color(0xFF000000),
        99: Color(0xFF000000),
      });

  @override
  Color get background => Color(0xFFF6F6F9);

  @override
  Color get onBackground => secondary;

  @override
  Color get onBackgroundVariant => secondary.shade50;

  static const _successMainValue = 0xFF00C72F;
  @override
  KMaterialColor get success =>
      KMaterialColor(_successMainValue, const <int, Color>{
        10: Color(0xFF002809),
        20: Color(0xFF003C0E),
        30: Color(0xFF005013),
        40: Color(0xFF00771C),
        50: Color(0xFF009F26),
        60: Color(_successMainValue),
        70: Color(0xFF30D256),
        80: Color(0xFF60DD7D),
        90: Color(0xFFA8EEB8),
        95: Color(0xFFD8F9DF),
        99: Color(0xFFF0FFF3),
      });

  static const _onSuccessMainValue = 0xFF000000;
  @override
  KMaterialColor get onSuccess =>
      KMaterialColor(_onSuccessMainValue, const <int, Color>{
        10: Color(0xFFFFFFFF),
        20: Color(0xFFFFFFFF),
        30: Color(0xFFFFFFFF),
        40: Color(0xFFFFFFFF),
        50: Color(0xFFFFFFFF),
        60: Color(_onSuccessMainValue),
        70: Color(0xFF000000),
        80: Color(0xFF000000),
        90: Color(0xFF000000),
        95: Color(0xFF000000),
        99: Color(0xFF000000),
      });

  static const _errorMainValue = 0xFFE66C56;
  @override
  KMaterialColor get error =>
      KMaterialColor(_errorMainValue, const <int, Color>{
        10: Color(0xFF3F0300),
        20: Color(0xFF640C03),
        30: Color(0xFF842415),
        40: Color(0xFFA43C2A),
        50: Color(0xFFC55340),
        60: Color(_errorMainValue),
        70: Color(0xFFFF8A75),
        80: Color(0xFFFFB4A6),
        90: Color(0xFFFFDAD4),
        95: Color(0xFFFFEDE9),
        99: Color(0xFFFFFBFF),
      });

  static const _onErrorMainValue = 0xFF000000;
  @override
  KMaterialColor get onError =>
      KMaterialColor(_onErrorMainValue, const <int, Color>{
        10: Color(0xFFFFFFFF),
        20: Color(0xFFFFFFFF),
        30: Color(0xFFFFFFFF),
        40: Color(0xFFFFFFFF),
        50: Color(0xFFFFFFFF),
        60: Color(_onErrorMainValue),
        70: Color(0xFF000000),
        80: Color(0xFF000000),
        90: Color(0xFF000000),
        95: Color(0xFF000000),
        99: Color(0xFF000000),
      });

  static const _warningMainValue = 0xFFF9CB33;
  @override
  KMaterialColor get warning =>
      KMaterialColor(_warningMainValue, const <int, Color>{
        10: Color(0xFF322600),
        20: Color(0xFF634C00),
        30: Color(0xFF957200),
        40: Color(0xFFC69800),
        50: Color(0xFFF8BE00),
        60: Color(_warningMainValue),
        70: Color(0xFFFBD866),
        80: Color(0xFFFCE599),
        90: Color(0xFFFDEBB2),
        95: Color(0xFFFEF2CC),
        99: Color(0xFFFFFBF2),
      });

  static const _onWarningMainValue = 0xFF000000;
  @override
  KMaterialColor get onWarning =>
      KMaterialColor(_onWarningMainValue, const <int, Color>{
        10: Color(0xFFFFFFFF),
        20: Color(0xFFFFFFFF),
        30: Color(0xFFFFFFFF),
        40: Color(0xFF000000),
        50: Color(0xFF000000),
        60: Color(_onWarningMainValue),
        70: Color(0xFF000000),
        80: Color(0xFF000000),
        90: Color(0xFF000000),
        95: Color(0xFF000000),
        99: Color(0xFF000000),
      });
}
