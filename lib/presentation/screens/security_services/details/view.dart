import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_request_details_model.dart';
import 'package:code_setup/presentation/common_widgets/services_details/attachment_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/chat_list_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/request_workflow_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_details_tab_shell.dart';
import 'package:code_setup/presentation/common_widgets/services_details/service_request_information_card.dart';
import 'package:code_setup/presentation/common_widgets/services_details/status_info_card.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/security_services/security_dashboard_refresh.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/repository/domain/security_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';
part 'widgets/tab_view_security.dart';
part 'widgets/request_details.dart';
part 'widgets/comments_list.dart';

@RoutePage()
class SecurityServicesDetailsScreen extends ConsumerWidget {
  final int requestId;
  final String slug;
  final String title;
  final bool isFromActionItems;

  const SecurityServicesDetailsScreen({
    super.key,
    required this.requestId,
    required this.slug,
    required this.title,
    this.isFromActionItems = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = _SecurityDetailsParams(
      requestId: requestId,
      slug: slug,
      title: title,
      isFromActionItems: isFromActionItems,
    );
    final state = ref.watch(_securityDetailsProvider(params));
    final controller = ref.read(_securityDetailsProvider(params).notifier);
    final requestDetail = state.detail;

    return KScaffold(
      appBar: KAppBar(
        title: Text(
          'Security Request Details',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 800;
                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _SecurityEmployeeInfoPanel(
                              requestId: requestId.toString(),
                              contactNumber: requestDetail?.contactNumber ?? '',
                            ),
                          ),
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
                          mobileMiddleWidget: _SecurityEmployeeInfoPanel(
                            requestId: requestId.toString(),
                            contactNumber: requestDetail?.contactNumber ?? '',
                          ),
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

class _SecurityEmployeeInfoPanel extends StatelessWidget {
  final String requestId;
  final String contactNumber;

  const _SecurityEmployeeInfoPanel({
    required this.requestId,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final user = KAppX.globalProvider.read(userProvider);

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
                  value,
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
            infoRow(
              'Employee ID',
              Icons.person_outline,
              user?.employeeId ?? '',
            ),
            infoRow(
              'Job Title / Designation',
              Icons.work_outline,
              user?.designationName ?? '',
            ),
            infoRow('Email Address', Icons.email_outlined, user?.email ?? ''),
            infoRow(
              'Department',
              Icons.business_outlined,
              user?.departmentName ?? '',
            ),
            infoRow('Contact Number', Icons.phone_outlined, contactNumber),
          ],
        ),
      ),
    );
  }
}
