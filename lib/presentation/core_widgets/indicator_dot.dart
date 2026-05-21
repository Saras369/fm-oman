import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../utils/app_extensions/app_extension.dart';

class KPageIndicatorDot extends ConsumerWidget {
  final bool isActive;
  final double? width;
  final double? height;
  final Color? activeColor;
  final Color? disableColor;
  const KPageIndicatorDot({
    Key? key,
    this.isActive = false,
    this.width,
    this.height,
    this.activeColor,
    this.disableColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return Container(
      width: width ?? 12.toAutoScaledWidth,
      height: height ?? 12.toAutoScaledHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? (activeColor ?? currentTheme.themeBox.colors.primary)
            : (disableColor ?? currentTheme.themeBox.colors.primary.shade90),
      ),
    );
  }
}
