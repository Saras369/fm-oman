part of '../view.dart';

String _fmtNum(num? n) {
  if (n == null) return '';
  if (n == n.roundToDouble()) return n.toInt().toString();
  return n.toString();
}

void _putNonEmpty(Map<String, dynamic> out, String key, String? value) {
  final t = value?.trim() ?? '';
  if (t.isNotEmpty) out[key] = t;
}

/// Subtype-specific rows merged into [ServiceRequestInformationCard] data.
void _mergeFinancialSubtypeFields(
  FinancialServiceRequestDetailsItem d,
  Map<String, dynamic> out,
) {
  final bank = d.bankAccountChangeRequest;
  if (bank != null) {
    _putNonEmpty(out, 'Old bank name', bank.oldBankName);
    _putNonEmpty(out, 'Old account number', bank.oldAccountNumber);
    _putNonEmpty(out, 'New bank name', bank.newBankName);
    _putNonEmpty(out, 'New account name', bank.newAccountName);
    _putNonEmpty(out, 'New account number', bank.newAccountNumber);
    _putNonEmpty(out, 'IFSC / branch code', bank.newBranchIfscCode);
    _putNonEmpty(out, 'Effective from', bank.effectiveFromDate);
    _putNonEmpty(out, 'Reason for change', bank.reasonForChange);
    return;
  }

  final reimb = d.reimbursementRequest;
  if (reimb != null) {
    final itemLines = reimb.items
        .map((it) {
          final desc = (it.itemDescription ?? '').trim();
          final line =
              '${desc.isEmpty ? 'Item' : desc}: Qty ${_fmtNum(it.qty)} × ${_fmtNum(it.price)} = ${_fmtNum(it.amount)}';
          return line.trim();
        })
        .where((s) => s.isNotEmpty)
        .join('\n');

    final totalParts = <String>[];
    if (reimb.totalAmount != null) {
      totalParts.add(_fmtNum(reimb.totalAmount));
    }
    if ((reimb.currency ?? '').trim().isNotEmpty) {
      totalParts.add(reimb.currency!.trim());
    }

    _putNonEmpty(out, 'Payment date', reimb.paymentDate);
    _putNonEmpty(out, 'Payment mode', reimb.paymentMode);
    if (totalParts.isNotEmpty) {
      out['Total amount'] = totalParts.join(' ');
    }
    _putNonEmpty(out, 'Line items', itemLines.isEmpty ? null : itemLines);
    return;
  }

  final allowance = d.allowanceRequest;
  if (allowance != null) {
    if (allowance.allowanceTypeId != null) {
      out['Allowance type ID'] = allowance.allowanceTypeId.toString();
    }
    _putNonEmpty(out, 'Amount', allowance.allowanceAmount);
    _putNonEmpty(out, 'Approved amount', allowance.approvedAllowanceAmount);
    _putNonEmpty(out, 'Currency', allowance.currency);
    _putNonEmpty(out, 'Contact number', allowance.contactNumber);
    _putNonEmpty(out, 'Description', allowance.description);
    return;
  }

  final cert = d.salaryCertificateRequest;
  if (cert != null) {
    _putNonEmpty(out, 'Certificate purpose', cert.certificatePurpose);
    _putNonEmpty(out, 'Certificate document', cert.certificateUrl);
    return;
  }

  final payslip = d.payslipRequest;
  if (payslip != null) {
    _putNonEmpty(out, 'Payslip month', payslip.payslipMonth);
    if (payslip.payslipYear != null) {
      out['Payslip year'] = payslip.payslipYear.toString();
    }
    _putNonEmpty(out, 'Payslip document', payslip.payslipUrl);
  }
}

Map<String, dynamic> _financialRequestInfoMap(
  FinancialServiceRequestDetailsItem? d,
) {
  if (d == null) return {};
  final m = <String, dynamic>{
    'Request For': d.subServiceId?.toString() ?? 'N/A',
    'Service Type': 'Financial Services',
    'Department': d.departmentId?.departmentName ?? 'N/A',
    'Designation': d.designationId?.name ?? 'N/A',
    'Section ID': d.sectionId?.toString() ?? 'N/A',
    'Employee': d.employeeName ?? 'N/A',
    'Email': d.emailAddress ?? 'N/A',
    'Contact number': d.contactNumber ?? 'N/A',
    'Remarks': (d.remarks ?? '').trim().isEmpty ? 'N/A' : d.remarks!.trim(),
  };
  _mergeFinancialSubtypeFields(d, m);
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

class _RequestDetailsFinServices extends StatelessWidget {
  final _ViewState state;
  const _RequestDetailsFinServices({required this.state});

  @override
  Widget build(BuildContext context) {
    final reqDetails = state.requestDetails;
    final isData = reqDetails.isNotEmpty;
    final requestItem = isData ? reqDetails[0] : null;

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
      final roleName = activeStep.approverRoleName;
      final userName = activeStep.approverUserName;
      final departmentSectionName = _assignedDepartmentSection(activeStep);

      if (departmentSectionName.isNotEmpty) {
        assignedToName = departmentSectionName;
      } else if (roleName != null && roleName.trim().isNotEmpty) {
        assignedToName = roleName.trim();
      } else if (userName != null && userName.trim().isNotEmpty) {
        assignedToName = userName.trim();
      }

      if (userName != null && userName.trim().isNotEmpty) {
        approverName = userName.trim();
        approverEmail = (activeStep.approverUserEmail ?? '').trim();
      }
    }

    String requestedDate = 'N/A';
    if (isData && (requestItem!.requestDate ?? '').isNotEmpty) {
      requestedDate = DateTime.parse(requestItem.requestDate!).formattedDate;
    }

    String? endDate;
    if (isData && (requestItem!.requestCloseDate ?? '').trim().isNotEmpty) {
      endDate = DateTime.parse(requestItem.requestCloseDate!).formattedDate;
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

    final requestInfoMap = _financialRequestInfoMap(requestItem);

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
        ServiceRequestInformationCard(infoData: requestInfoMap),
      ],
    );
  }
}
