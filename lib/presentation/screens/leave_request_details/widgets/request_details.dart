part of '../view.dart';

class LeaveRequestDetailsTab extends StatelessWidget {
  final _ViewState state;

  const LeaveRequestDetailsTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final requestItem = state.requestDetails?.data?.request;
    final approvals = state.requestDetails?.data?.approvalDetails ?? [];

    LeaveApprovalDetail? activeStep;
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
          'N/A';
      approverName = activeStep.approverUser?.employeeName ?? '';
      approverEmail = activeStep.approverUser?.email ?? '';
    }

    final requestedDate = requestItem?.createdAt != null
        ? DateTime.tryParse(requestItem!.createdAt!)?.formattedDate ?? 'N/A'
        : 'N/A';

    final statusInfoMap = {
      'Assigned To': assignedToName,
      'Status': requestItem?.status ?? 'N/A',
      'Approver': {'name': approverName, 'email': approverEmail},
      'Requested Date': requestedDate,
    };

    final requestInfoMap = <String, dynamic>{
      'Request For': requestItem?.leaveFor ?? 'N/A',
      'Problem Statement':
          requestItem?.subService?.subServiceName ?? 'Leave Request',
      'Service Type': requestItem?.service?.name ?? 'N/A',
      'Sub Service Type': requestItem?.subService?.subServiceName ?? 'N/A',
      'Department': requestItem?.department?.departmentName ?? 'N/A',
      'Leave Start Date': requestItem?.leaveStartDate != null
          ? DateTime.tryParse(requestItem!.leaveStartDate!)?.formattedDate ??
                requestItem.leaveStartDate!
          : 'N/A',
      'Leave End Date': requestItem?.leaveEndDate != null
          ? DateTime.tryParse(requestItem!.leaveEndDate!)?.formattedDate ??
                requestItem.leaveEndDate!
          : 'N/A',
      'Leave Duration (Days)': '${requestItem?.leaveDuration ?? 0}',
      'Contact During Leave': requestItem?.contactNumberDuringLeave ?? 'N/A',
      'Address During Leave': (requestItem?.addressDuringLeave?.isNotEmpty == true)
          ? requestItem!.addressDuringLeave!
          : 'N/A',
      'Notes': (requestItem?.notes?.isNotEmpty == true)
          ? requestItem!.notes!
          : 'N/A',
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
          approverEmail: approverEmail.isNotEmpty ? approverEmail : null,
        ),
        const SizedBox(height: 16),
        ServiceRequestInformationCard(infoData: requestInfoMap),
      ],
    );
  }
}
