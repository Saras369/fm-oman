part of '../view.dart';

class PassportRequestDetailsTab extends StatelessWidget {
  final _ViewState state;

  const PassportRequestDetailsTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final requestItem = state.requestDetails?.data?.request;

    final approvals = state.requestDetails?.data?.approvalDetails ?? [];
    PassportApprovalDetails? activeStep;
    if (approvals.isNotEmpty) {
      activeStep = approvals.firstWhere(
        (step) => step.approvalStatus == 'In Progress',
        orElse: () => approvals.first,
      );
    }

    String assignedToName = 'N/A';
    String approverName = '';
    String approverEmail = '';

    if (activeStep != null) {
      final user = activeStep.approverUser;
      final role = activeStep.approverRole;

      if (role != null && role.name != null) {
        assignedToName = role.name!;
      } else if (user != null && user.employeeName != null) {
        assignedToName = user.employeeName!;
      }

      if (user != null && user.employeeName != null) {
        approverName = user.employeeName!;
        approverEmail = user.email ?? '';
      }
    }

    // Build the status information map
    final statusInfoMap = {
      'Assigned To': assignedToName,
      'Status': requestItem?.status ?? 'N/A',
      'Approver': {
        'name': approverName,
        'email': approverEmail,
      },
      'Requested Date': requestItem?.createdAt != null
          ? DateTime.parse(requestItem!.createdAt!).formattedDate
          : 'N/A',
      'End Date': requestItem?.updatedAt != null
          ? DateTime.parse(requestItem!.updatedAt!).formattedDate
          : 'N/A',
    };

    // Build the request information map
    final requestInfoMap = {
      'Request For': requestItem?.applicationForType ?? 'N/A',
      'Service Type': requestItem?.service?.name ?? 'N/A',
      'Sub Service Type': requestItem?.subService?.subServiceName ?? 'N/A',
      'Department Name': requestItem?.reqDepartment?.departmentName ?? 'N/A',
      'Section Name': requestItem?.reqSection?.sectionName ?? 'N/A',
      'Created By': requestItem?.createdByUser?.employeeName ?? 'N/A',
      'Request Number for Official Use':
          requestItem?.requestNumberForOfficialUse ?? 'N/A',
      'Passport Type': requestItem?.passportType ?? 'N/A',
      'Applicant Civil ID': requestItem?.applicantCivilId ?? 'N/A',
      'Applicant Name': requestItem?.applicantName ?? 'N/A',
      'Applicant Passport Number':
          requestItem?.applicantPassportNumber ?? 'N/A',
      'Application For Type': requestItem?.applicationForType ?? 'N/A',
      'Application Type': requestItem?.applicationType ?? 'N/A',
      'Application Job / Occupation':
          requestItem?.applicantJobOccupation ?? 'N/A',
      'Purpose of Application': requestItem?.purposeOfApplication ?? 'N/A',
      'Approved Mission Travel ID':
          requestItem?.approvedMissionTravelId ?? 'N/A',
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
          approver: (statusInfoMap['Approver'] as Map?)?['name'] as String? ?? '',
          approverEmail: (statusInfoMap['Approver'] as Map?)?['email'] as String?,
        ),
        const SizedBox(height: 16),
        ServiceRequestInformationCard(infoData: requestInfoMap),
      ],
    );
  }
}
