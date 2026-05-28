part of '../view.dart';

class _RequestDetailsAttendanceServices extends StatelessWidget {
  final _AttendanceDetailsState state;

  const _RequestDetailsAttendanceServices({required this.state});

  @override
  Widget build(BuildContext context) {
    final requestItem = state.requestDetail;
    final approvals = requestItem?.approvalDetails ?? [];

    ApprovalDetail? activeStep;
    if (approvals.isNotEmpty) {
      activeStep = approvals.firstWhere(
        (step) =>
            step.approvalStatus?.toLowerCase() == 'in progress' ||
            step.approvalStatus?.toLowerCase() == 'pending',
        orElse: () => approvals.first,
      );
    }

    var assignedToName = 'N/A';
    var approverName = '';
    var approverEmail = '';

    if (activeStep != null) {
      assignedToName =
          activeStep.approverRole?.name ??
          activeStep.approverUser?.employeeName ??
          requestItem?.reqDepartment?.departmentName ??
          'N/A';
      approverName = activeStep.approverUser?.employeeName ?? '';
      approverEmail = activeStep.approverUser?.email ?? '';
    }

    final requestedDate = requestItem?.createdAt != null
        ? requestItem!.createdAt!.formattedDate
        : 'N/A';

    final serviceName = requestItem?.service?.name?.trim();
    final subServiceName = requestItem?.subService?.subServiceName?.trim();

    final statusInfoMap = {
      'Assigned To': assignedToName,
      'Status': requestItem?.status ?? 'N/A',
      'Approver': {'name': approverName, 'email': approverEmail},
      'Requested Date': requestedDate,
    };

    final requestInfoMap = <String, dynamic>{
      'Request For': 'Self',
      'Service Type': (serviceName == null || serviceName.isEmpty)
          ? 'HR Services'
          : serviceName,
      'Sub Service Type': (subServiceName == null || subServiceName.isEmpty)
          ? 'Update Attendance'
          : subServiceName,
      'Department': requestItem?.reqDepartment?.departmentName ?? 'N/A',
      'Section': requestItem?.reqSection?.sectionName ?? 'N/A',
      'From Date': requestItem?.fromDate ?? 'N/A',
      'To Date': requestItem?.toDate ?? 'N/A',
      'From Time': requestItem?.fromTime ?? 'N/A',
      'To Time': requestItem?.toTime ?? 'N/A',
      'Reason': requestItem?.reason ?? 'N/A',
      'Comments': (requestItem?.comments?.trim().isEmpty ?? true)
          ? 'N/A'
          : requestItem!.comments!.trim(),
      'Created By': requestItem?.createdByUser?.employeeName ?? 'N/A',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatusInfoCard(
          infoData: statusInfoMap,
          assignedTo: assignedToName,
          status: requestItem?.status ?? 'N/A',
          requestDate: requestedDate,
          approver: approverName,
        ),
        const SizedBox(height: 15),
        ServiceRequestInformationCard(infoData: requestInfoMap),
      ],
    );
  }
}
