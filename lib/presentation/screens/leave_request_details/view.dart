import 'package:auto_route/annotations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/reuest_info_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

part 'models/employee_info.dart';
part 'widgets/employee_info_panel.dart';
part 'widgets/request_tab_panel.dart';
part 'widgets/request_details_tab.dart';

@RoutePage()
class LeaveRequestDetailsScreen extends StatelessWidget {
  final EmployeeInfo employeeInfo;

  const LeaveRequestDetailsScreen({super.key, required this.employeeInfo});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return KScaffold(
      appBar: KAppBar(
        title: Text(
          "Request Details",
          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 16.toAutoScaledHeight,
            bottom: 12,
            left: 16.toAutoScaledWidth,
            right: 16.toAutoScaledWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EmployeeInfoPanel(
                requestId: '',
                isLeaveRequest: true,
                contactNumber: '',
              ),
              // Tab bar and views
              20.toVerticalSizedBox,
              RequestTabsPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
