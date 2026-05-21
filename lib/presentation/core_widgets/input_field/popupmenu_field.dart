import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KPopupmenuField<T> extends ConsumerWidget {
  final PopupMenuItemBuilder<T> itemBuilder;

  final T? initialValue;

  final VoidCallback? onOpened;

  final PopupMenuItemSelected<T>? onSelected;

  final PopupMenuCanceled? onCanceled;

  final String? tooltip;

  final double elevation;

  final Color? shadowColor;

  final Color? surfaceTintColor;

  final EdgeInsetsGeometry? padding;

  final double? splashRadius;

  final Widget? child;

  final Widget? icon;

  final Offset offset;

  final bool enabled;

  final ShapeBorder? shape;

  final Color? color;

  final bool enableFeedback;

  final double? iconSize;

  final BoxConstraints? constraints;

  final PopupMenuPosition? position;

  final Clip clipBehavior;

  const KPopupmenuField({
    super.key,
    required this.itemBuilder,
    this.initialValue,
    this.onOpened,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation = 0,
    this.shadowColor,
    this.surfaceTintColor,
    this.padding,
    this.child,
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback = true,
    this.constraints,
    this.position,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return PopupMenuButton(
      initialValue: initialValue,
      itemBuilder: itemBuilder,
      onOpened: onOpened,
      onSelected: (value) {
        if (enableFeedback) {
          KAppX.services.haptics.hapticLight();

          Feedback.forTap(context);
        }
        onSelected?.call(value);
      },
      onCanceled: onCanceled,
      tooltip: tooltip,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      padding:
          padding ??
          EdgeInsets.symmetric(
            vertical: currentTheme.paddings.v16,
            horizontal: currentTheme.paddings.h8,
          ),
      //TODO: It is showing rectangular splash-color box (grey) by default - need change have to make custom
      splashRadius: splashRadius,
      icon: icon,
      iconSize: iconSize,
      offset: offset,
      enabled: enabled,
      shape:
          shape ??
          RoundedRectangleBorder(
            side: BorderSide(
              width: 1.toAutoScaledHeight,
              color: currentTheme.colors.secondary.shade90,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.toAutoScaledHeight),
            ),
          ),
      color: color ?? currentTheme.colors.background,
      constraints: constraints,
      position: position,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

class KPopupMenuDivider extends PopupMenuEntry<Never> {
  const KPopupMenuDivider({super.key, this.padding, this.height = 16.0});

  final EdgeInsets? padding;

  @override
  final double height;

  @override
  bool represents(void value) => false;

  @override
  State<KPopupMenuDivider> createState() => _KPopupMenuDividerState();
}

class _KPopupMenuDividerState extends State<KPopupMenuDivider> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Padding(
      padding:
          widget.padding ??
          EdgeInsets.symmetric(horizontal: 8.toAutoScaledWidth),
      child: Divider(
        color: currentTheme.colors.secondary.shade99,
        height: widget.height,
      ),
    );
  }
}
