import 'package:auto_route/annotations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_request_details_model.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/reuest_info_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request_details/view.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/financial_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

// part 'widgets/fin_request_details_tab.dart';
part 'widgets/tab_view_help_desk.dart';
part 'widgets/request_details.dart';
part 'widgets/comments_list.dart';
part 'controller.dart';

@RoutePage()
class HelpDeskDetailsScreen extends ConsumerWidget {
  final int requestId;
  late final _VSControllerParams params;

  HelpDeskDetailsScreen({Key? key, required this.requestId}) : super(key: key) {
    params = _VSControllerParams(requestId: requestId);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(params));
    final stateController = ref.watch(_vsProvider(params).notifier);
    final requestDetail = state.requestDetails.isNotEmpty
        ? state.requestDetails[0]
        : null;
    return KScaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 19,
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
                requestId: requestId.toString(),
                isLeaveRequest: false,
                leaveType: null,
                contactNumber: requestDetail?.contactNumber ?? '1234567890',
              ),
              // Tab bar and views
              20.toVerticalSizedBox,
              TabViewHelpDesk(state: state, stateController: stateController),
            ],
          ),
        ),
      ),
    );
  }
}
