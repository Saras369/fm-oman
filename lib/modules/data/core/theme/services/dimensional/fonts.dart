part of 'dimensional.dart';

class _DimensionalFontSizes implements KThemeFontSizes {
  final context = KAppX.currentContext;
  double get _baseFontSize {
    if (Responsive.isMobile(context!)) {
      return 1; // Adjust the base font size for mobile
    } else if (Responsive.isTablet(context!)) {
      return 0.6; // Adjust the base font size for tablet
    } else {
      return 0.3; // Default font size for desktop
    }
  }

  @override
  double get s11 => (_baseFontSize * 11.0).toAutoScaledFont;
  @override
  double get s12 => (_baseFontSize * 12.0).toAutoScaledFont;
  @override
  double get s13 => (_baseFontSize * 13.0).toAutoScaledFont;
  @override
  double get s14 => (_baseFontSize * 14.0).toAutoScaledFont;
  @override
  double get s16 => (_baseFontSize * 16.0).toAutoScaledFont;
  @override
  double get s18 => (_baseFontSize * 18.0).toAutoScaledFont;
  @override
  double get s20 => (_baseFontSize * 20.0).toAutoScaledFont;
  @override
  double get s24 => (_baseFontSize * 24.0).toAutoScaledFont;
  @override
  double get s36 => (_baseFontSize * 36.0).toAutoScaledFont;
  @override
  double get s48 => (_baseFontSize * 48.0).toAutoScaledFont;
  @override
  double get s10 => (_baseFontSize * 10.0).toAutoScaledFont;
  @override
  double get s15 => (_baseFontSize * 15.0).toAutoScaledFont;
  @override
  double get s25 => (_baseFontSize * 25.0).toAutoScaledFont;
  @override
  double get s30 => (_baseFontSize * 30.0).toAutoScaledFont;
  @override
  double get s35 => (_baseFontSize * 35.0).toAutoScaledFont;
  @override
  double get s40 => (_baseFontSize * 40.0).toAutoScaledFont;
  @override
  double get s5 => (_baseFontSize * 5.0).toAutoScaledFont;
}

class _DimensionalFontWeights implements KThemeFontWeights {
  @override
  FontWeight get wRegular => FontWeight.w400;

  @override
  FontWeight get wBold => FontWeight.w500;

  @override
  FontWeight get wBolder => FontWeight.w600;
}

class _DimensionalFontLineHeights implements KThemeFontLineHeights {
  @override
  double get lh14 => 14.0.toAutoScaledFont;

  @override
  double get lh15 => 15.0.toAutoScaledFont;

  @override
  double get lh16 => 16.0.toAutoScaledFont;

  @override
  double get lh18 => 18.0.toAutoScaledFont;

  @override
  double get lh20 => 20.0.toAutoScaledFont;

  @override
  double get lh22 => 22.0.toAutoScaledFont;

  @override
  double get lh24 => 24.0.toAutoScaledFont;

  @override
  double get lh28 => 28.0.toAutoScaledFont;

  @override
  double get lh32 => 32.0.toAutoScaledFont;

  @override
  double get lh44 => 44.0.toAutoScaledFont;

  @override
  double get lh48 => 48.0.toAutoScaledFont;

  @override
  double get lh60 => 60.0.toAutoScaledFont;

  @override
  double get lh36 => 36.0.toAutoScaledFont;
}
