import 'package:code_setup/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/app_extensions/app_extension.dart';
import '../../../../../domain/core/theme/theme.dart';
import '../../theme.dart';

part 'extensions.dart';
part 'fonts.dart';
part 'margins.dart';
part 'paddings.dart';

class DimensionalThemeService implements KThemeService {
  @override
  KThemeFontLineHeights get fontLineHeights => _DimensionalFontLineHeights();

  @override
  KThemeFontSizes get fontSizes => _DimensionalFontSizes();

  @override
  KThemeFontWeights get fontWeights => _DimensionalFontWeights();

  @override
  KThemeMargins get margins => _DimensionalMargins();

  @override
  KThemePaddings get paddings => _DimensionalPaddings();
}

abstract class DimensionalPolicies {
  DimensionalPolicies._();

  static double get policyRatioForWidth {
    const designWidth = 440.0;

    final deviceWidth = () {
      late double width;

      final context = KAppX.currentContext;

      if (context != null) {
        width = MediaQuery.of(context).size.width;
      } else {
        width = designWidth;
      }

      return width;
    }();

    final widthScaleRatio = deviceWidth / designWidth;

    return widthScaleRatio;
  }

  static double getPolicyRatioForWidthWithContext(BuildContext context) {
    const designWidth = 440.0;
    final widthScaleRatio = MediaQuery.of(context).size.width / designWidth;
    return widthScaleRatio;
  }

  static double get policyRatioForHeight {
    const designHeight = 903.0;

    final deviceHeight = () {
      late double height;

      final context = KAppX.currentContext;

      if (context != null) {
        height = MediaQuery.of(context).size.height;
      } else {
        height = designHeight;
      }

      return height;
    }();

    final heightScaleRatio = deviceHeight / designHeight;

    return heightScaleRatio;
  }

  static double getPolicyRatioForHeightWithContext(BuildContext context) {
    const designHeight = 903.0;
    final heightScaleRatio = MediaQuery.of(context).size.height / designHeight;
    return heightScaleRatio;
  }
}
