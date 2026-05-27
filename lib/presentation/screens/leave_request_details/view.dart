import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_request_details_model.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_details_tab_shell.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_request_information_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'widgets/employee_info_panel.dart';
part 'widgets/tab_view_leave.dart';
part 'widgets/request_details.dart';
part 'widgets/comments_list.dart';
part 'controller.dart';

@RoutePage()
class LeaveRequestDetailsScreen extends ConsumerWidget {
  final int requestId;
  final bool isFromActionItems;
  late final _VSControllerParams params;

  LeaveRequestDetailsScreen({
    super.key,
    required this.requestId,
    this.isFromActionItems = false,
  }) {
    params = _VSControllerParams(
      requestId: requestId,
      isFromActionItems: isFromActionItems,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(params));
    final controller = ref.read(_vsProvider(params).notifier);
    final requestItem = state.requestDetails?.data?.request;
    final createdByUser = requestItem?.createdByUser;

    return KScaffold(
      appBar: KAppBar(
        title: const Text(
          'Leave Request Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.requestDetails == null
          ? const Center(child: Text('Unable to load request details'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;
                  final employeePanel = EmployeeInfoPanel(
                    requestId: requestId.toString(),
                    isLeaveRequest: true,
                    contactNumber:
                        requestItem?.contactNumberDuringLeave ??
                        createdByUser?.mobile ??
                        '',
                    leaveType: requestItem?.subService?.subServiceName ?? '',
                    employeeId: createdByUser?.employeeId,
                    jobTitle: createdByUser?.designationName,
                    email: createdByUser?.email,
                    departmentName:
                        requestItem?.department?.departmentName ??
                        createdByUser?.department?.departmentName,
                    statusLabel: requestItem?.status,
                  );

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: employeePanel),
                        Expanded(
                          flex: 3,
                          child: TabViewLeave(
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
                      TabViewLeave(
                        state: state,
                        stateController: controller,
                        mobileMiddleWidget: employeePanel,
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
