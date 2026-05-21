import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';
import 'clickable.dart';

class KTextButton extends ConsumerWidget {
  final Text text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? disableColor;
  final bool isDisabled;
  final bool isLoading;
  final EdgeInsets? padding;

  const KTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.disableColor,
    this.padding,
    this.isLoading = false,
    this.isDisabled = false,
  }) : super(key: key);

  bool get isActive => !(isDisabled || isLoading);

  Color get buttonColor {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    late Color kColor;

    if (color != null && disableColor != null) {
      kColor = color!;

      if (!isActive) {
        kColor = disableColor!;
      }
    } else {
      kColor = currentTheme.themeBox.colors.primary;

      if (!isActive) {
        kColor = currentTheme.themeBox.colors.secondary.shade90;
      }
    }

    return kColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return KClickable(
      onPressed: isActive ? onPressed : null,
      padding: padding,
      child: Text(
        text.data ?? '',
        style: text.style?.copyWith(color: text.style?.color ?? buttonColor),
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
