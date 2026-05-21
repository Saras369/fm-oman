part of '../../app_extension.dart';

class _BottomSheetRoute {
  _BottomSheetRoute._();

  Future<T?> showConstraintBottomSheet<T>({
    BuildContext? context,
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragger = true,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    Future<bool> Function()? onTap,
    Future<bool> Function(DragEndDetails)? onVerticalDragEnd,
  }) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return showModalBottomSheet<T>(
      constraints: constraints ?? BoxConstraints(minHeight: 0),
      context: context ?? KAppX.currentContext!,
      backgroundColor: backgroundColor ?? currentTheme.colors.background,
      elevation: elevation ?? 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.toAutoScaledWidth),
          topRight: Radius.circular(32.toAutoScaledWidth),
        ),
      ),
      clipBehavior: clipBehavior,
      barrierColor: currentTheme.colors.secondary.shade10.withOpacity(0.7),
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      // showDragHandle: showDragger,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  showDragger
                      ? KBottomSheetDrager(
                          onTap: () async {
                            if (isDismissible) {
                              final res = await onTap?.call() ?? true;

                              if (res) {
                                KAppX.router.maybePop();
                              }
                            }
                          },
                          onVerticalDragEnd: (details) async {
                            final res =
                                await onVerticalDragEnd?.call(details) ?? true;
                            if (res) {
                              KAppX.router.maybePop();
                            }
                          },
                        )
                      : SizedBox(),
                  // Container(
                  //         width: 108.toAutoScaledWidth,
                  //         height: 4.toAutoScaledHeight,
                  //         decoration: BoxDecoration(
                  //             borderRadius:
                  //                 BorderRadius.circular(12.toAutoScaledWidth),
                  //             color: currentTheme.colors.secondary),
                  //         // color: ,
                  //       ),
                  //
                  builder(context),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
