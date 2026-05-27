part of '../view.dart';

void _putNonEmpty(Map<String, dynamic> out, String key, String? value) {
  final t = value?.trim() ?? '';
  if (t.isNotEmpty) out[key] = t;
}

void _mergeSecuritySubtypeFields(
  FinancialServiceRequestDetailsItem d,
  Map<String, dynamic> out,
) {
  // Security-specific nested payloads vary by slug; show remarks when present.
  _putNonEmpty(out, 'Remarks', d.remarks);
}

Map<String, dynamic> _securityRequestInfoMap(
  FinancialServiceRequestDetailsItem? d,
  String title,
) {
  if (d == null) return {};
  final m = <String, dynamic>{
    'Request For': title,
    'Service Type': 'Security Services',
    'Department': d.departmentId?.departmentName ?? 'N/A',
    'Designation': d.designationId?.name ?? 'N/A',
    'Section': d.sectionId?.toString() ?? 'N/A',
    'Employee': d.employeeName ?? 'N/A',
    'Email': d.emailAddress ?? 'N/A',
    'Contact number': d.contactNumber ?? 'N/A',
  };
  _mergeSecuritySubtypeFields(d, m);
  return m;
}

String _assignedDepartmentSection(ApprovalDetails? approval) {
  final departmentName = approval?.departmentDetails?.departmentName?.trim();
  final sectionName = approval?.sectionDetails?.sectionName?.trim();
  final parts = [
    if (departmentName != null && departmentName.isNotEmpty) departmentName,
    if (sectionName != null && sectionName.isNotEmpty) sectionName,
  ];
  return parts.isEmpty ? '' : parts.join(' - ');
}

class _SecurityRequestDetailsTab extends StatelessWidget {
  final _SecurityDetailsState state;
  final String title;

  const _SecurityRequestDetailsTab({
    required this.state,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final requestItem = state.detail;
    final approvals = requestItem?.approvals ?? [];

    ApprovalDetails? activeStep;
    if (approvals.isNotEmpty) {
      final inProgress = approvals
          .where((s) => s.approvalStatus == 'In Progress')
          .toList();
      activeStep = inProgress.isNotEmpty ? inProgress.first : approvals.first;
    }

    var assignedToName = 'N/A';
    var approverName = '';
    var approverEmail = '';

    if (activeStep != null) {
      final departmentSectionName = _assignedDepartmentSection(activeStep);
      if (departmentSectionName.isNotEmpty) {
        assignedToName = departmentSectionName;
      } else if ((activeStep.approverRoleName ?? '').trim().isNotEmpty) {
        assignedToName = activeStep.approverRoleName!.trim();
      } else if ((activeStep.approverUserName ?? '').trim().isNotEmpty) {
        assignedToName = activeStep.approverUserName!.trim();
      }

      if ((activeStep.approverUserName ?? '').trim().isNotEmpty) {
        approverName = activeStep.approverUserName!.trim();
        approverEmail = (activeStep.approverUserEmail ?? '').trim();
      }
    }

    String requestedDate = 'N/A';
    if ((requestItem?.requestDate ?? '').isNotEmpty) {
      try {
        requestedDate =
            DateTime.parse(requestItem!.requestDate!).formattedDate;
      } catch (_) {
        requestedDate = requestItem!.requestDate!;
      }
    }

    String? endDate;
    if ((requestItem?.requestCloseDate ?? '').trim().isNotEmpty) {
      try {
        endDate =
            DateTime.parse(requestItem!.requestCloseDate!).formattedDate;
      } catch (_) {
        endDate = requestItem!.requestCloseDate;
      }
    }

    final statusInfoMap = <String, Object>{
      'Assigned To': assignedToName,
      'Status': requestItem?.requestStatus ?? 'N/A',
      'Approver': <String, String>{
        'name': approverName,
        'email': approverEmail,
      },
      'Requested Date': requestedDate,
      if (endDate != null) 'End Date': endDate,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatusInfoCard(
          infoData: statusInfoMap,
          assignedTo: statusInfoMap['Assigned To'] as String? ?? '',
          status: statusInfoMap['Status'] as String? ?? '',
          requestDate: statusInfoMap['Requested Date'] as String? ?? '',
          endDate: statusInfoMap['End Date'] as String?,
          approver:
              (statusInfoMap['Approver'] as Map?)?['name'] as String? ?? '',
          approverEmail:
              (statusInfoMap['Approver'] as Map?)?['email'] as String?,
        ),
        const SizedBox(height: 16),
        ServiceRequestInformationCard(
          infoData: _securityRequestInfoMap(requestItem, title),
        ),
      ],
    );
  }
}
