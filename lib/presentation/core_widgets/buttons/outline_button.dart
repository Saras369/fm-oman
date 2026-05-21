import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';
import '../loader/circular_loader.dart';

class KOutlineButton extends ConsumerWidget {
  final VoidCallback onPressed;

  final double? height;

  final Color? color;

  final Color? disableColor;

  final Widget child;

  final bool isDisabled;

  final bool isLoading;

  final EdgeInsets? padding;

  final bool isPrimary;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final double? elevation;

  final Color? shapeBorderColor;

  const KOutlineButton({
    Key? key,
    required this.onPressed,
    this.height,
    this.shapeBorderColor,
    this.color,
    this.disableColor,
    required this.child,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
    this.isPrimary = true,
    this.shape,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  bool get isActive => !(isDisabled || isLoading);

  Color get borderColor {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    late Color kColor;

    if (color != null && disableColor != null) {
      kColor = color!;

      if (!isActive) {
        kColor = disableColor!;
      }
    } else if (isPrimary) {
      kColor = currentTheme.themeBox.colors.primary;

      if (!isActive) {
        kColor = currentTheme.themeBox.colors.secondary.shade90;
      }
    } else {
      kColor = currentTheme.themeBox.colors.secondary.shade90;

      if (!isActive) {
        kColor = currentTheme.themeBox.colors.secondary.shade95;
      }
    }

    return kColor;
  }

  ShapeBorder get materialShape {
    final defaultShape = RoundedRectangleBorder(
      side: BorderSide(
        color: shapeBorderColor ?? borderColor,
        width: 1.toAutoScaledHeight,
      ),
      borderRadius: BorderRadius.circular(4.toAutoScaledHeight),
    );

    if (shape == null) {
      return defaultShape;
    }

    final isShapeRoundedRectangleBorder = shape is RoundedRectangleBorder;

    if (!isShapeRoundedRectangleBorder) {
      return shape!;
    }

    final newShape = shape as RoundedRectangleBorder;

    return newShape.copyWith(side: defaultShape.side);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return MaterialButton(
      height: height ?? 48.toAutoScaledHeight,
      shape: materialShape,
      onPressed: isActive ? onPressed : null,
      color: backgroundColor ?? currentTheme.themeBox.colors.background,
      elevation: elevation,
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: 22.toAutoScaledWidth,
            vertical: currentTheme.themeBox.paddings.v4,
          ),
      child: isLoading ? KCircularLoader(color: borderColor) : child,
    );
  }
}
