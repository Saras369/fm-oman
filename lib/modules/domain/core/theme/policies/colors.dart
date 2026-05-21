part of '../theme.dart';

abstract class KThemeColors {
  factory KThemeColors.dark() => KThemeColorsDarkImpl();

  factory KThemeColors.light() => KThemeColorsLightImpl();

  /// [primary] represents the color that will be used often across the application
  /// to draw attention, and sometimes brand awareness.
  ///
  KMaterialColor get primary;

  /// [onPrimary] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [primary].
  KMaterialColor get onPrimary;

  /// [secondary], also known as accent color, is to be used sparingly across the app to add a bit of differentiating
  /// touch in places where [primary] is already being used extensively.
  ///
  KMaterialColor get secondary;

  /// [onSecondary] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [secondary].
  KMaterialColor get onSecondary;

  /// [background] is to be used as backgrounds of such elements as [Scaffold], [ListView]s, etc.
  ///
  Color get background;

  /// [onBackground] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [background].
  Color get onBackground;

  /// [onBackgroundVariant] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [background].
  Color get onBackgroundVariant;

  /// [success] is the color of the success element.
  KMaterialColor get success;

  /// [onSuccess] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [success].
  KMaterialColor get onSuccess;

  /// [error] is the color of the failure element.
  KMaterialColor get error;

  /// [onError] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [error].
  KMaterialColor get onError;

  /// [warning] is used to display warning or elements which need user's attention because something could be invalid.
  KMaterialColor get warning;

  /// [onWarning] is the color of elements such as texts, icon, etc that are to be rendered
  /// above [error].
  KMaterialColor get onWarning;
}

class KMaterialColor extends ColorSwatch<int> {
  const KMaterialColor(super.primary, super.swatch);

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;

  Color get shade50 => this[50]!;

  Color get shade60 => this[60]!;

  Color get shade70 => this[70]!;

  Color get shade80 => this[80]!;

  Color get shade90 => this[90]!;

  Color get shade95 => this[95]!;

  Color get shade99 => this[99]!;
}
