import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../utils/app_extensions/app_extension.dart';
import '../../utils/data_type_extensions/data_type_extensions.dart';

class KPill extends ConsumerWidget {
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  const KPill({
    Key? key,
    this.backgroundColor,
    this.borderSide,
    required this.child,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return Container(
      height: height,
      constraints: BoxConstraints(minHeight: 20.toAutoScaledHeight),
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: currentTheme.paddings.h5,
            vertical: 1.5.toAutoScaledHeight,
          ),
      decoration: ShapeDecoration(
        color: backgroundColor ?? HexColor.fromHex('#010218').withOpacity(0.25),
        shape: StadiumBorder().copyWith(side: borderSide),
      ),
      child: child,
    );
  }
}
