import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/bookmarks_model.dart';
import 'package:code_setup/modules/locale/app_locale_provider.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/all_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
part 'widgets/custom_info_card.dart';

@RoutePage()
class AllServicesPage extends ConsumerStatefulWidget {
  const AllServicesPage({super.key});

  @override
  ConsumerState<AllServicesPage> createState() => _AllServicesPageState();
}

class _AllServicesPageState extends ConsumerState<AllServicesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final stateController = ref.read(allServicesVSProvider.notifier);
        stateController.onTabChanged(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(allServicesVSProvider);
    final stateController = ref.read(allServicesVSProvider.notifier);
    final isArabic = ref.watch(appLocaleProvider).languageCode == 'ar';
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: KScaffold(
        appBar: KAppBar(
          title: Text(
            '     ${l10n?.servicesPageTitle}    ' ?? 'Services',
            style: TextStyle(
              fontWeight: currentTheme.fontWeights.wBold,
              fontSize: currentTheme.fontSizes.s18,
            ),
          ),
        ),

        backgroundColor: currentTheme.colors.background,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              /// 🔹 Modern segmented TabBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: currentTheme.colors.onPrimary,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300, width: 0.7),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicator: BoxDecoration(
                      color: currentTheme.colors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: currentTheme.colors.primary,
                    unselectedLabelColor: Colors.grey.shade600,
                    labelStyle: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: FontWeight.w500,
                    ),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: l10n?.servicesTabAllServices ?? 'All Services'),
                      Tab(text: l10n?.servicesTabBookmarked ?? 'Bookmarked'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// Thin divider to separate header from content
              Divider(height: 1, color: Colors.grey.shade200),

              /// 🔹 Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // ✅ Tab 1: All Services
                    Builder(
                      builder: (context) {
                        final services = state.services;

                        if (state.isLoading && services?.isEmpty == true) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // if (services.isEmpty) {
                        //   final hasBookmarks =
                        //       state.bookmarks?.isNotEmpty ?? false;
                        //   return Center(
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 24,
                        //       ),
                        //       child: Text(
                        //         hasBookmarks
                        //             ? 'No services are assigned to your role. Try the Bookmarked tab, or contact your administrator.'
                        //             : 'No services available',
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     ),
                        //   );
                        // }

                        return RefreshIndicator(
                          onRefresh: () async =>
                              stateController.fetchServices(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: services!.length,
                            itemBuilder: (context, index) {
                              final data = services[index];
                              return CustomInfoCard(
                                title: isArabic
                                    ? data.arabicName ?? 'No Name'
                                    : data.name ?? 'No Name',
                                subtitle: data.description ?? 'No Description',
                                icon: Icons.miscellaneous_services,
                                iconColor: Colors.blueAccent,
                                subServices: data.subServices ?? [],
                                onBookmarkToggle: () {
                                  stateController.updateBookmark(
                                    data.id ?? 0,
                                    onSuccess: () {
                                      _tabController.animateTo(1);
                                    },
                                  );
                                },
                                isBookmarked: false,
                                serviceId: data.id ?? 0,
                              );
                            },
                          ),
                        );
                      },
                    ),

                    // ✅ Tab 2: Bookmarked
                    Builder(
                      builder: (context) {
                        final bookmarks = state.bookmarks ?? [];

                        if (state.isLoading && bookmarks.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (bookmarks.isEmpty) {
                          return const Center(
                            child: Text('No bookmarked services yet'),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async =>
                              stateController.fetchBookmarks(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: bookmarks.length,
                            itemBuilder: (context, index) {
                              final data = bookmarks[index];
                              final serviceId = data.serviceId != null
                                  ? int.tryParse(data.serviceId!)
                                  : null;

                              return CustomInfoCard(
                                title: data.serviceName ?? 'No Name',
                                subtitle:
                                    data.serviceDescription ?? 'No Description',
                                icon: Icons.miscellaneous_services,
                                iconColor: Colors.blueAccent,
                                subServices: data.subServices ?? [],
                                onBookmarkToggle: () {
                                  stateController.updateBookmark(
                                    serviceId ?? 0,
                                  );
                                },
                                isBookmarked: true,
                                serviceId: serviceId ?? 0,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
