import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/drawer_item_widget.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';
part 'widgets/drawer_items.dart';

@RoutePage()
class KBottomNavigatorScreen extends ConsumerWidget {
  const KBottomNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final stateController = ref.read(bottomNavigatorVsProvider.notifier);

    return AutoTabsRouter.builder(
      routes: [
        UpdateAttendanceRecordRoute(),
        LeaveRequestRoute(subServicesList: [], serviceId: 0),
        HolidaysRoute(),
        AppointmentsRoute(),
      ],
      // 👇 CORRECT builder signature for AutoTabsRouter.builder
      builder: (tabsContext, children, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;

        return Scaffold(
          backgroundColor: currentTheme.colors.background,
          appBar: KAppBar(
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),

            title: Text(
              stateController.titleForIndex(activeIndex),
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s16,
                fontWeight: currentTheme.fontWeights.wBold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => KAppX.router.pop(),
              ),
            ],
          ),
          drawer: KDrawer(
            child: _DrawerMenu(
              currentTheme: currentTheme,
              activeIndex: activeIndex,
              onItemTap: (index) {
                if (index == activeIndex) {
                  KAppX.router.pop(); // just close drawer
                  return;
                }

                tabsRouter.setActiveIndex(index);
                stateController.onTabChanged(index);
                KAppX.router.pop(); // close drawer after nav
              },
            ),
          ),
          // Nice, smooth transition between tabs
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: KeyedSubtree(
              key: ValueKey(activeIndex),
              child: children[activeIndex],
            ),
          ),
        );
      },
    );
  }
}
