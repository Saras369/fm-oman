import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KCheckBox extends ConsumerWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const KCheckBox({Key? key, required this.value, required this.onChanged})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return SizedBox(
      width: 20.toAutoScaledWidth,
      height: 20.toAutoScaledHeight,
      child: Checkbox(
        checkColor: currentTheme.themeBox.colors.onPrimary,
        activeColor: currentTheme.themeBox.colors.primary,
        // fillColor: MaterialStateProperty.all<Color>(
        //   currentTheme.themeBox.colors.primary,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.toAutoScaledWidth),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
