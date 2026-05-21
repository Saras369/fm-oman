import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';
import '../loader/circular_loader.dart';

class KActionButton extends ConsumerWidget {
  final VoidCallback onPressed;

  final double? height;
  final Color? color;
  final Color? onColor;
  final Color? disableColor;
  final bool isPrimary;
  final Widget child;
  final bool isDisabled;
  final bool isLoading;
  final EdgeInsets? padding;
  const KActionButton({
    Key? key,
    required this.onPressed,
    this.height,
    this.color,
    this.onColor,
    this.disableColor,
    this.isPrimary = true,
    required this.child,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
  }) : super(key: key);

  Color get buttonColor {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    late Color buttonColor;

    if (color != null && disableColor != null) {
      buttonColor = color!;

      if (isDisabled) {
        buttonColor = disableColor!;
      }
    } else if (isPrimary) {
      buttonColor = currentTheme.themeBox.colors.primary;

      if (isDisabled) {
        buttonColor = currentTheme.themeBox.colors.secondary.shade90;
      }
    } else {
      buttonColor = currentTheme.themeBox.colors.background;

      if (isDisabled) {
        buttonColor = currentTheme.themeBox.colors.secondary.shade90;
      }
    }

    return buttonColor;
  }

  Color get onButtonColor {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    late Color buttonColor;

    if (color != null && disableColor != null && onColor != null) {
      buttonColor = onColor!;
    } else if (isPrimary) {
      buttonColor = currentTheme.themeBox.colors.onPrimary;
    } else {
      buttonColor = currentTheme.themeBox.colors.onBackground;
    }

    return buttonColor;
  }

  bool get isActive => !(isDisabled || isLoading);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    final kHeight = height ?? 56.toAutoScaledHeight;

    return MaterialButton(
      height: kHeight,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.toAutoScaledHeight),
      ),
      onPressed: isActive ? onPressed : () {},
      padding: padding,
      child: isLoading
          ? SizedBox(
              height: kHeight / 1.8,
              width: kHeight / 1.8,
              child: KCircularLoader(
                color: onButtonColor,
                isPrimary: isPrimary,
                strokeWidth: kHeight / (kHeight / 2),
              ),
            )
          : child,
    );
  }
}

class KTextActionButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final double? height;
  final Color? color;
  final Color? onColor;
  final Color? disableColor;
  final bool isPrimary;
  final Text text;
  final bool isDisabled;
  final bool isLoading;
  final EdgeInsets? padding;
  const KTextActionButton({
    Key? key,
    required this.onPressed,
    this.height,
    this.color,
    this.onColor,
    this.disableColor,
    this.isPrimary = true,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
  }) : super(key: key);

  bool get isActive => !(isDisabled || isLoading);

  Color get textColor {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    late Color color;

    if (isPrimary) {
      color = text.style?.color ?? currentTheme.themeBox.colors.onPrimary;

      if (!isActive) {
        color = currentTheme.themeBox.colors.secondary.shade50;
      }
    } else {
      color = text.style?.color ?? currentTheme.themeBox.colors.onBackground;

      if (!isActive) {
        color = currentTheme.themeBox.colors.secondary.shade90;
      }
    }

    return color;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return KActionButton(
      onPressed: onPressed,
      height: height,
      color: color,
      onColor: onColor,
      disableColor: disableColor,
      isPrimary: isPrimary,
      isDisabled: isDisabled,
      isLoading: isLoading,
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: 22.toAutoScaledWidth,
            vertical: currentTheme.themeBox.paddings.v4,
          ),
      child: Text(
        text.data ?? '',
        style: text.style?.copyWith(color: textColor),
        strutStyle: text.strutStyle,
        textAlign: text.textAlign,
        textDirection: text.textDirection,
        locale: text.locale,
        softWrap: text.softWrap,
        overflow: text.overflow,
        textScaleFactor: text.textScaleFactor,
        maxLines: text.maxLines,
        semanticsLabel: text.semanticsLabel,
        textWidthBasis: text.textWidthBasis,
        textHeightBehavior: text.textHeightBehavior,
        selectionColor: text.selectionColor,
      ),
    );
  }
}
