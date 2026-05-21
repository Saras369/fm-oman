import 'package:flutter/material.dart';

import '../../../data/core/theme/theme.dart';

part 'policies/colors.dart';
part 'policies/fonts.dart';
part 'policies/margins.dart';
part 'policies/paddings.dart';

enum KThemeType { dark, light }

abstract class KThemeBox {
  static final KThemeBox instance = KThemeBoxImpl();

  KThemeType get type;

  KThemeColors get colors;

  void switchTo(KThemeType type);

  KThemeFontSizes get fontSizes;

  KThemeFontWeights get fontWeights;

  KThemeFontLineHeights get fontLineHeights;

  KThemeMargins get margins;

  KThemePaddings get paddings;
}
