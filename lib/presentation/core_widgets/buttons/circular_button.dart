import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/data_type_extensions/data_type_extensions.dart';
import 'clickable.dart';

class KCircularButton extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final VoidCallback onPressed;
  final bool isDisabled;
  final EdgeInsets? touchablePadding;
  final Border? border;

  const KCircularButton({
    Key? key,
    this.backgroundColor,
    required this.child,
    required this.onPressed,
    this.touchablePadding,
    this.isDisabled = false,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KClickable(
      onPressed: onPressed,
      disabled: isDisabled,
      padding: touchablePadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              backgroundColor ?? HexColor.fromHex('#010218').withOpacity(0.25),
          shape: BoxShape.circle,
          border: border,
        ),
        child: child,
      ),
    );
  }
}
