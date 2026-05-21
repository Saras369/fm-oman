import 'package:auto_route/annotations.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home/view.dart';
import 'package:code_setup/presentation/screens/leave_request/models/leave_form_model.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

// part 'widgets/personal_details.dart';

@RoutePage()
class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        foregroundColor: currentTheme.colors.onPrimary,
        title: Text(
          '   Profile Detials',
          style: TextStyle(color: currentTheme.colors.onPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyProfileWidget(isProfileDetail: true),
            // Tab bar and views
            20.toVerticalSizedBox,

            SingleChildScrollView(
              child: DefaultTabController(
                length: 3,
                child: Card(
                  color: currentTheme.colors.onPrimary,
                  // margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: currentTheme.colors.onPrimary,
                            ),
                            child: TabBar(
                              tabAlignment: TabAlignment.start,

                              isScrollable: true,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              dividerColor: Colors.transparent,
                              unselectedLabelColor: const Color(0xFF6B6E7E),
                              labelColor: Colors.white,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.redAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              tabs: [
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 12.toAutoScaledWidth,
                                  ),
                                  child: Tab(
                                    child: Text(
                                      "Personal Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 12.toAutoScaledWidth,
                                  ),

                                  child: Tab(
                                    child: Text(
                                      "Employment & Job",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 12.toAutoScaledWidth,
                                  ),

                                  child: Tab(
                                    child: Text(
                                      "Family Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // If height: 900 is for demo, use Expanded/Flexible here for real app use
                          SizedBox(
                            height: 300,
                            child: TabBarView(
                              children: [Container(), Container(), Container()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
