import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';
import 'icon_button.dart';

class KBackButton extends ConsumerWidget {
  final double? width;
  final double? height;
  final bool cancel;
  final Icon? icon;
  final Color? color;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const KBackButton({
    Key? key,
    this.icon,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
    this.cancel = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return KIconButton(
      icon: () {
        Icon? icon = this.icon;

        if (icon == null) {
          if (cancel) {
            icon = Icon(Icons.clear);
          } else {
            icon = Icon(CupertinoIcons.arrow_left);
          }
        }

        return Icon(
          icon.icon,
          color: color ?? currentTheme.themeBox.colors.onBackground,
          size: width ?? 24.toAutoScaledWidth,
        );
      }(),
      onPressed: onPressed,
      padding: padding,
    );
  }
}
