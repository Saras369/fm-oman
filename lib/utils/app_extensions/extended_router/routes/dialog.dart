part of '../../app_extension.dart';

class _DialogRoute {
  _DialogRoute._();

  /// Closes the top overlay route opened via [showKDialog].
  /// Uses the app router navigator key (not AutoRoute page pop).
  void closeKDialog<T>([T? result]) {
    final navigator = KAppX.router.navigatorKey.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop<T>(result);
    }
  }

  Future<T?> showKDialog<T>({
    BuildContext? context,
    required Widget Function(BuildContext) builder,
    String? barrierLabel,
    bool useRootNavigator = true,
    bool barrierDismissible = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    Color? backgroundColor,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    Duration insetAnimationDuration = const Duration(milliseconds: 100),
    Curve insetAnimationCurve = Curves.decelerate,
    EdgeInsets? insetPadding,
    Clip clipBehavior = Clip.none,
    ShapeBorder? shape,
    AlignmentGeometry? alignment,
  }) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return showDialog<T>(
      barrierColor: currentTheme.colors.secondary.shade10.withOpacity(0.7),
      context: context ?? KAppX.currentContext!,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final currentTheme = ref.watch(KAppX.theme.current).themeBox;

            return Dialog(
              backgroundColor:
                  backgroundColor ?? currentTheme.colors.background,
              elevation: elevation,
              shadowColor: shadowColor,
              surfaceTintColor: surfaceTintColor,
              insetAnimationDuration: insetAnimationDuration,
              insetAnimationCurve: insetAnimationCurve,
              insetPadding:
                  insetPadding ??
                  EdgeInsets.symmetric(horizontal: 40.toAutoScaledWidth),
              clipBehavior: clipBehavior,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.toAutoScaledWidth),
              ),
              child: builder(context),
            );
          },
        );
      },
    );
  }
}
