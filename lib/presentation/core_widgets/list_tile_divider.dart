import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../utils/app_extensions/app_extension.dart';

class KDivider extends ConsumerWidget {
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  const KDivider({Key? key, this.color, this.backgroundColor, this.padding})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return Container(
      color: backgroundColor ?? currentTheme.colors.background,
      padding:
          padding ??
          EdgeInsets.symmetric(horizontal: currentTheme.paddings.h16),
      child: Divider(
        height: 1.toAutoScaledHeight,
        color: color ?? currentTheme.colors.secondary.shade99,
      ),
    );
  }
}
