part of '../view.dart';

class _SecurityRequestDetails extends StatelessWidget {
  final _SecurityDetailsViewState state;

  const _SecurityRequestDetails({required this.state});

  @override
  Widget build(BuildContext context) {
    final details = state.requestDetails;
    final request = _requestMap(details);
    final approvals = _listFromAny(
      details['approval_details'] ??
          details['approvals'] ??
          request['approval_details'] ??
          request['approvals'],
    );
    final activeApproval = _activeApproval(approvals);
    final statusInfoMap = _securityStatusInfo(request, activeApproval);
    final requestInfoMap = _securityRequestInfo(request);

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

Map<String, dynamic>? _activeApproval(List<Map<String, dynamic>> approvals) {
  if (approvals.isEmpty) return null;
  final inProgress = approvals.where((approval) {
    final status = _stringValue(approval['approval_status'])?.toLowerCase();
    return status == 'in progress' || status == 'pending';
  }).toList();
  return inProgress.isNotEmpty ? inProgress.first : approvals.first;
}

Map<String, Object> _securityStatusInfo(
  Map<String, dynamic> request,
  Map<String, dynamic>? approval,
) {
  final approverUser = _mapFromAny(approval?['approver_user']);
  final approverRole = _mapFromAny(approval?['approver_role']);
  final department = _mapFromAny(approval?['department']);
  final section = _mapFromAny(approval?['section']);
  final assignedTo = [
    _stringValue(department?['department_name']),
    _stringValue(section?['section_name']),
  ].where((value) => value != null && value.isNotEmpty).join(' - ');
  final approverName =
      _stringValue(approverUser?['employee_name']) ??
      _stringValue(approverRole?['name']) ??
      '';

  final requestedDate = _formatDate(
    _stringValue(
      request['request_date'] ?? request['created_at'] ?? request['createdAt'],
    ),
  );
  final endDate = _formatDate(
    _stringValue(
      request['request_close_date'] ??
          request['closed_at'] ??
          request['updated_at'],
    ),
  );

  return {
    'Assigned To': assignedTo.isNotEmpty
        ? assignedTo
        : _stringValue(request['assigned_to']) ?? 'N/A',
    'Status':
        _stringValue(
          request['request_status'] ??
              request['status'] ??
              approval?['approval_status'],
        ) ??
        'N/A',
    'Approver': <String, String>{
      'name': approverName,
      'email': _stringValue(approverUser?['email']) ?? '',
    },
    'Requested Date': requestedDate.isEmpty ? 'N/A' : requestedDate,
    if (endDate.isNotEmpty) 'End Date': endDate,
  };
}

Map<String, dynamic> _securityRequestInfo(Map<String, dynamic> request) {
  final info = <String, dynamic>{};

  _put(info, 'Service Type', 'Security Services');
  _put(info, 'Request ID', _stringValue(request['id']));
  _put(info, 'Request For', _subServiceName(request));
  _put(info, 'Employee', _stringValue(request['employee_name']));
  _put(info, 'Employee ID', _stringValue(request['employee_id']));
  _put(info, 'Email', _stringValue(request['email_address']));
  _put(info, 'Contact number', _stringValue(request['contact_number']));
  _put(info, 'Department', _departmentName(request));
  _put(info, 'Section', _sectionName(request));
  _put(info, 'Designation', _designationName(request));
  _put(info, 'Reporting Manager', _stringValue(request['reporting_manager']));
  _put(info, 'Remarks', _stringValue(request['remarks']));

  _mergeNestedRequestFields(info, request);

  if (info.length <= 1) {
    for (final entry in request.entries) {
      if (entry.value == null || entry.value is Map || entry.value is List) {
        continue;
      }
      _put(info, _humanize(entry.key), _stringValue(entry.value));
    }
  }

  return info;
}

void _mergeNestedRequestFields(
  Map<String, dynamic> info,
  Map<String, dynamic> request,
) {
  final nested =
      _mapFromAny(request['gatePassRequest']) ??
      _mapFromAny(request['gate_pass_request']) ??
      _mapFromAny(request['employeeCardRequest']) ??
      _mapFromAny(request['employee_card_request']) ??
      _mapFromAny(request['retiredCardRequest']) ??
      _mapFromAny(request['retired_card_request']) ??
      request;

  final labels = <String, String>{
    'name': 'Name',
    'name_on_card': 'Name on Card',
    'civil_id': 'Civil ID',
    'visitor_name': 'Visitor Name',
    'visitor_phone_number': 'Visitor Phone Number',
    'visitor_id_passport_no': 'Visitor ID / Passport No',
    'visit_purpose': 'Visit Purpose',
    'reason_for_request': 'Reason for Request',
    'serial_number': 'Serial Number',
    'expiry_date': 'Expiry Date',
    'from_date': 'From Date',
    'to_date': 'To Date',
    'department_name': 'Department',
    'section_name': 'Section',
    'job_title': 'Job Title',
    'ex_job_title': 'Ex Job Title',
    'mobile_number': 'Mobile Number',
    'card_type': 'Card Type',
    'card_number': 'Card Number',
  };

  for (final entry in labels.entries) {
    _put(info, entry.value, _stringValue(nested[entry.key]));
  }
}

String? _subServiceName(Map<String, dynamic> request) {
  final subService =
      _mapFromAny(request['sub_service']) ??
      _mapFromAny(request['sub_service_id']);
  return _stringValue(
    subService?['sub_service_name'] ??
        subService?['name'] ??
        request['request_name'],
  );
}

String? _departmentName(Map<String, dynamic> request) {
  final department =
      _mapFromAny(request['department_id']) ??
      _mapFromAny(request['req_department']);
  return _stringValue(
    department?['department_name'] ?? request['department_name'],
  );
}

String? _sectionName(Map<String, dynamic> request) {
  final section =
      _mapFromAny(request['section_id']) ?? _mapFromAny(request['req_section']);
  return _stringValue(section?['section_name'] ?? request['section_name']);
}

String? _designationName(Map<String, dynamic> request) {
  final designation = _mapFromAny(request['designation_id']);
  return _stringValue(designation?['name'] ?? request['designation_name']);
}

void _put(Map<String, dynamic> out, String key, String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isNotEmpty) out[key] = trimmed;
}

String _humanize(String key) {
  return key
      .replaceAll('_', ' ')
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
