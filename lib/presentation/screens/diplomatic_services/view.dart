import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/common_widgets/drawer_item_widget.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/drawer/drawer.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/core_widgets/list_tile_divider.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home/view.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'controller.dart';
part 'widgets/drawer_items.dart';

@RoutePage()
class DiplomaticServicesScreen extends ConsumerWidget {
  final List<SubServices> subServicesList;
  final int serviceId;
  late final _VSControllerParams params;

  DiplomaticServicesScreen({
    super.key,
    required this.subServicesList,
    required this.serviceId,
  }) {
    params = _VSControllerParams(
      subServicesList: subServicesList,
      serviceId: serviceId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final stateController = ref.watch(_vsProvider(params).notifier);

    return AutoTabsRouter.builder(
      routes: [
        TransferToMissionRoute(
          subServicesList: subServicesList,
          serviceId: serviceId,
        ),
        RequestForPassportRoute(
          subServicesList: subServicesList,
          serviceId: serviceId,
        ),
        ParcelServicesRequestRoute(
          subServicesList: subServicesList,
          serviceId: serviceId,
        ),
        DiplomaticClubCardRoute(
          subServicesList: subServicesList,
          serviceId: serviceId,
        ),
        RegisterVacancyRoute(
          subServicesList: subServicesList,
          serviceId: serviceId,
        ),
      ],
      // 👇 CORRECT builder signature for AutoTabsRouter.builder
      builder: (tabsContext, children, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;

        return KScaffold(
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
