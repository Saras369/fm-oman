import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';

class KIconButton extends ConsumerWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const KIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return IconButton(
      constraints: BoxConstraints(minHeight: 0, minWidth: 0),
      padding: padding,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
