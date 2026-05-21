import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/helper/helper.dart';

typedef VerticalDragDownCallback = void Function(DragDownDetails);
typedef VerticalDragEndCallback = void Function(DragEndDetails);
typedef LeftDragUpdateCallback = void Function(DragUpdateDetails);
typedef RightDragUpdateCallback = void Function(DragUpdateDetails);

final _throttle = KThrottle(Duration(milliseconds: 1000));

class KGestureDetector extends ConsumerWidget {
  final VoidCallback? onTap;
  final Widget child;
  final HitTestBehavior behavior;
  final bool disabled;
  final VoidCallback? onDisabledTapCallback;
  final EdgeInsets? padding;
  final VerticalDragDownCallback? onVerticalDragDown;
  final VerticalDragEndCallback? onVerticalDragEnd;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final LeftDragUpdateCallback? onLeftDragUpdate;
  final RightDragUpdateCallback? onRightDragUpdate;
  const KGestureDetector({
    Key? key,
    this.onTap,
    required this.child,
    this.behavior = HitTestBehavior.translucent,
    this.disabled = false,
    this.onDisabledTapCallback,
    this.padding,
    this.onVerticalDragDown,
    this.onVerticalDragEnd,
    this.onHorizontalDragUpdate,
    this.onLeftDragUpdate,
    this.onRightDragUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (disabled) {
          onDisabledTapCallback?.call();
          return;
        }

        if (onTap != null) {
          onTap?.call();
        }
      },
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragEnd: onVerticalDragEnd,
      onHorizontalDragUpdate:
          onHorizontalDragUpdate ??
          (details) {
            final value = details.primaryDelta ?? 0;
            if (value > 0) {
              _throttle(() => onLeftDragUpdate?.call(details));
            } else if (value < 0) {
              _throttle(() => onRightDragUpdate?.call(details));
            }
          },
      behavior: behavior,
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
