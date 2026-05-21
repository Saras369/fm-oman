part of 'dimensional.dart';

extension AutoScaledDimensionX on num {
  double get toAutoScaledWidth {
    final autoScaledDimension = this * DimensionalPolicies.policyRatioForWidth;

    return autoScaledDimension;
  }

  double toAutoScaledWidthForContext(BuildContext context) {
    final autoScaledDimension =
        this * DimensionalPolicies.getPolicyRatioForWidthWithContext(context);

    return autoScaledDimension;
  }

  double get toAutoScaledHeight {
    final autoScaledDimension = this * DimensionalPolicies.policyRatioForHeight;

    return autoScaledDimension;
  }

  double toAutoScaledHeightByContext(BuildContext context) {
    final autoScaledDimension =
        this * DimensionalPolicies.getPolicyRatioForWidthWithContext(context);

    return autoScaledDimension;
  }
}

extension AutoScaledFontX on num {
  double get toAutoScaledFont {
    final autoScaledFont = this * DimensionalPolicies.policyRatioForWidth;

    return autoScaledFont;
  }
}

extension PaddingIntX on num {
  EdgeInsets get toHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get toVerticalPadding =>
      EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get toLeftOnlyPadding => EdgeInsets.only(left: toDouble());

  EdgeInsets get toRightOnlyPadding => EdgeInsets.only(right: toDouble());

  EdgeInsets get toTopOnlyPadding => EdgeInsets.only(top: toDouble());

  EdgeInsets get toBottomOnlyPadding => EdgeInsets.only(bottom: toDouble());
}

extension MarginIntX on num {
  EdgeInsets get toHorizontalMargin =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get toVerticalMargin => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get toLeftOnlyMargin => EdgeInsets.only(left: toDouble());

  EdgeInsets get toRightOnlyMargin => EdgeInsets.only(right: toDouble());

  EdgeInsets get toTopOnlyMargin => EdgeInsets.only(top: toDouble());

  EdgeInsets get toBottomOnlyMargin => EdgeInsets.only(bottom: toDouble());
}

extension SizedBoxIntX on num {
  SizedBox get toHorizontalSizedBox =>
      SizedBox(width: toDouble().toAutoScaledWidth);

  SizedBox get toVerticalSizedBox =>
      SizedBox(height: toDouble().toAutoScaledHeight);
}
