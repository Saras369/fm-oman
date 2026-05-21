import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KDrawer extends ConsumerWidget {
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final double? width;
  final Widget? child;
  final String? semanticLabel;

  const KDrawer({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.width,
    this.child,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return Drawer(
      backgroundColor:
          backgroundColor ?? currentTheme.themeBox.colors.background,
      elevation: elevation,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.toAutoScaledHeight),
              bottomRight: Radius.circular(20.toAutoScaledHeight),
            ),
          ),
      width:
          width ?? (MediaQuery.of(context).size.width - 73.toAutoScaledWidth),
      semanticLabel: semanticLabel,
      shadowColor: currentTheme.themeBox.colors.onBackground.withOpacity(0.7),
      child: child,
    );
  }
}
