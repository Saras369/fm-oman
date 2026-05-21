import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';
import 'clickable.dart';

typedef KRadioButtonOnPressed<T> = void Function(T value);

class KRadioButton<T> extends ConsumerWidget {
  final String? title;
  final Widget? child;
  final T value;
  final KRadioButtonOnPressed<T> onPressed;
  final bool isActive;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  const KRadioButton({
    Key? key,
    this.title,
    this.child,
    required this.onPressed,
    required this.value,
    this.isActive = false,
    this.textStyle,
    this.padding,
  }) : assert(
         (title == null && child != null) || (title != null && child == null),
       ),
       super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return KClickable(
      onPressed: () => onPressed.call(value),
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 20.toAutoScaledWidth,
          ),
          4.toHorizontalSizedBox,
          child ??
              Text(
                title!,
                style:
                    textStyle ??
                    TextStyle(
                      fontSize: currentTheme.fontSizes.s12,
                      fontWeight: currentTheme.fontWeights.wBolder,
                      color: currentTheme.colors.secondary.shade40,
                    ),
              ),
        ],
      ),
    );
  }
}
