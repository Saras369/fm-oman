import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../utils/app_extensions/app_extension.dart';
import 'buttons/gesture_detector.dart';

class KBottomSheetDrager extends ConsumerWidget {
  final VoidCallback? onTap;
  final VerticalDragEndCallback? onVerticalDragEnd;
  final EdgeInsets? padding;
  const KBottomSheetDrager({
    Key? key,
    this.onTap,
    this.onVerticalDragEnd,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return KGestureDetector(
      onTap: onTap,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding:
            padding ??
            EdgeInsets.symmetric(vertical: currentTheme.themeBox.paddings.v20),
        child: Container(
          width: 108.toAutoScaledWidth,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.toAutoScaledWidth,
              color: currentTheme.themeBox.colors.secondary,
            ),
            borderRadius: BorderRadius.circular(32.toAutoScaledWidth / 2),
          ),
        ),
      ),
    );
  }
}
