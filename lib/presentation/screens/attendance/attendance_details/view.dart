import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_details_tab_shell.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_request_information_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/attendance/attendance_dashboard_refresh.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/attendance_repository.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/attendance_details_tab_view.dart';
part 'widgets/request_details.dart';
part 'widgets/comments_list.dart';
part 'controller.dart';

@RoutePage()
class UpdateAttendanceDetailsScreen extends ConsumerWidget {
  final int requestId;

  const UpdateAttendanceDetailsScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = _AttendanceDetailsParams(requestId: requestId);
    final state = ref.watch(_attendanceDetailsProvider(params));
    final stateController = ref.watch(
      _attendanceDetailsProvider(params).notifier,
    );
    final requestDetail = state.requestDetail;
    final createdByUser = requestDetail?.createdByUser;

    return KScaffold(
      appBar: KAppBar(
        title: const Text(
          'Attendance Request Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : requestDetail == null
          ? const SafeArea(
              child: Center(child: Text('Unable to load request details')),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.toAutoScaledWidth),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 800;
                    final employeePanel = _AttendanceEmployeeInfoPanel(
                      requestId: requestId.toString(),
                      employeeId: createdByUser?.employeeId ?? '',
                      jobTitle: createdByUser?.designation?.name ?? '',
                      email: createdByUser?.email ?? '',
                      departmentName:
                          requestDetail.reqDepartment?.departmentName ?? '',
                      contactNumber: createdByUser?.mobile ?? '',
                      statusLabel: requestDetail.status ?? '',
                    );

                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: employeePanel),
                          Expanded(
                            flex: 3,
                            child: _AttendanceDetailsTabView(
                              state: state,
                              stateController: stateController,
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _AttendanceDetailsTabView(
                          state: state,
                          stateController: stateController,
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

class _AttendanceEmployeeInfoPanel extends StatelessWidget {
  final String requestId;
  final String employeeId;
  final String jobTitle;
  final String email;
  final String departmentName;
  final String contactNumber;
  final String statusLabel;

  const _AttendanceEmployeeInfoPanel({
    required this.requestId,
    required this.employeeId,
    required this.jobTitle,
    required this.email,
    required this.departmentName,
    required this.contactNumber,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    Widget infoRow(String label, IconData icon, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s13,
              color: const Color(0xFF757A90),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, color: const Color(0xFF23272F), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value.isEmpty ? 'N/A' : value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B4260),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFECECF0), width: 1),
      ),
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          leading: const Icon(
            Icons.people_alt_outlined,
            color: Color(0xFF23272F),
            size: 22,
          ),
          title: Text(
            'Employee Information',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: currentTheme.fontSizes.s16,
              color: const Color(0xFF23272F),
            ),
          ),
          children: [
            const Divider(color: Color(0xFFECECF0), height: 1, thickness: 1),
            const SizedBox(height: 16),
            infoRow('Request ID', Icons.badge_outlined, requestId),
            infoRow('Employee ID', Icons.person_outline, employeeId),
            infoRow('Job Title / Designation', Icons.work_outline, jobTitle),
            infoRow('Email Address', Icons.email_outlined, email),
            infoRow('Department', Icons.business_outlined, departmentName),
            infoRow('Contact Number', Icons.phone_outlined, contactNumber),
            infoRow('Status', Icons.info_outline, statusLabel),
          ],
        ),
      ),
    );
  }
}
