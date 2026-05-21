import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';
import '../buttons/back_button.dart';

class KAppBar extends ConsumerWidget implements PreferredSizeWidget {
  PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Future<bool> Function()? onPopCallback;
  final bool showArrow;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;
  final double titleSpacing;
  final double? appBarHeight;
  KAppBar({
    Key? key,
    PreferredSizeWidget? bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.onPopCallback,
    this.showArrow = false,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.titleSpacing = 0,
    this.appBarHeight,
  }) : super(key: key) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    this.bottom =
        bottom ??
        PreferredSize(
          preferredSize: Size.fromHeight(1.toAutoScaledHeight),
          child: Container(
            height: 1.toAutoScaledHeight,
            color: currentTheme.colors.secondary.shade95,
          ),
        );
  }

  void onBackButtonPressed() async {
    final res = (await onPopCallback?.call()) ?? true;

    if (res) {
      KAppX.router.maybePop();
    }
  }

  double get _appBarHeight =>
      (appBarHeight ?? 65.toAutoScaledHeight) +
      (bottom?.preferredSize.height ?? 0.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    return SafeArea(
      child: AppBar(
        toolbarHeight: _appBarHeight,
        leading: !automaticallyImplyLeading
            ? null
            : leading ??
                  () {
                    // Detect if Scaffold has a drawer
                    final hasDrawer =
                        Scaffold.maybeOf(context)?.hasDrawer ?? false;

                    // If screen can pop → show back button
                    if (canPop) {
                      return KBackButton(
                        cancel: useCloseButton,
                        onPressed: onBackButtonPressed,
                        color: foregroundColor ?? currentTheme.colors.secondary,
                      );
                    }

                    // If it can't pop but has a drawer → show hamburger
                    if (hasDrawer) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        color: foregroundColor ?? currentTheme.colors.secondary,
                      );
                    }

                    // Nothing to show
                    return null;
                  }(),

        backgroundColor: backgroundColor ?? currentTheme.colors.background,
        elevation: elevation ?? 0,
        title: title,
        centerTitle: centerTitle ?? false,
        actions: actions,
        foregroundColor: foregroundColor ?? currentTheme.colors.secondary,

        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        //   systemNavigationBarColor: Colors.transparent,
        // ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5), // light grey like in your screenshot
          ),
        ),

        leadingWidth: leadingWidth,
        automaticallyImplyLeading: automaticallyImplyLeading,
        titleSpacing: titleSpacing,
        shadowColor: Colors.black.withValues(alpha: 0.05),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
