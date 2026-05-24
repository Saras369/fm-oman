import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_details_tab_shell.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_request_information_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request_details/view.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/security_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
part 'widgets/comments_list.dart';
part 'widgets/request_details.dart';
part 'widgets/tab_view_security.dart';

@RoutePage()
class SecurityServicesDetailsScreen extends ConsumerWidget {
  final int requestId;
  final String slug;
  final String title;
  late final _SecurityDetailsControllerParams _params;

  SecurityServicesDetailsScreen({
    super.key,
    required this.requestId,
    required this.slug,
    required this.title,
  }) {
    _params = _SecurityDetailsControllerParams(
      requestId: requestId,
      slug: slug,
      title: title,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_securityDetailsProvider(_params));
    final controller = ref.read(_securityDetailsProvider(_params).notifier);

    return KScaffold(
      appBar: KAppBar(
        title: const Text(
          'Security Request Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 800;
                    final employeePanel = EmployeeInfoPanel(
                      requestId: requestId.toString(),
                      isLeaveRequest: false,
                      leaveType: null,
                      contactNumber: controller.contactNumber,
                    );

                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: employeePanel),
                          Expanded(
                            flex: 3,
                            child: _TabViewSecurity(
                              state: state,
                              stateController: controller,
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _TabViewSecurity(
                          state: state,
                          stateController: controller,
                          mobileMiddleWidget: employeePanel,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
