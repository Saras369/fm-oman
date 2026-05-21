import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/diplomatic_services/passport_request_details_model.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_details_tab_shell.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_request_information_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request_details/view.dart';
import 'package:code_setup/repository/domain/diplomatic_services/request_for_passport_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/repository/data/diplomatic_services/request_for_passport_repo_impl.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';

part 'controller.dart';
part 'widgets/tab_view_passport.dart';
part 'widgets/request_details.dart';
part 'widgets/comments_list.dart';

@RoutePage()
class PassportServiceDetailsScreen extends ConsumerWidget {
  final int requestId;
  late final _VSControllerParams params;

  PassportServiceDetailsScreen({super.key, required this.requestId}) {
    params = _VSControllerParams(requestId: requestId);
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
          'Passport Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: state.isLoading || state.requestDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: EmployeeInfoPanel(
                            requestId: requestId.toString(),
                            contactNumber: createdByUser?.mobile ?? '',
                            isLeaveRequest: false,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TabViewPassport(
                            state: state,
                            stateController: controller,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TabViewPassport(
                          state: state,
                          stateController: controller,
                          mobileMiddleWidget: EmployeeInfoPanel(
                            requestId: requestId.toString(),
                            contactNumber: createdByUser?.mobile ?? '',
                            isLeaveRequest: false,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
    );
  }
}
