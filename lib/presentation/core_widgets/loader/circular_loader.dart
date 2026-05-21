import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KCircularLoader extends ConsumerWidget {
  final bool isPrimary;
  final Color? color;
  final double? strokeWidth;
  const KCircularLoader({
    Key? key,
    this.isPrimary = true,
    this.color,
    this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return CircularProgressIndicator(
      color:
          color ??
          (isPrimary
              ? currentTheme.themeBox.colors.primary
              : currentTheme.themeBox.colors.secondary),
      strokeWidth: strokeWidth ?? 4.toAutoScaledHeight,
    );
  }
}
