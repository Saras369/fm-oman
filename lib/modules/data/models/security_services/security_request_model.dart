import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';

class SecurityRequestModel {
  final List<SecurityRequestItem>? data;
  final int? totalCount;

  SecurityRequestModel({this.data, this.totalCount});

  factory SecurityRequestModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final nestedData = readJsonMap(rawData);
    final requestList = rawData is List
        ? rawData
        : nestedData?['requests'] ??
              nestedData?['items'] ??
              nestedData?['rows'] ??
              nestedData?['data'];
    return SecurityRequestModel(
      data: requestList is List
          ? requestList
                .map(readJsonMap)
                .whereType<Map<String, dynamic>>()
                .map(SecurityRequestItem.fromJson)
                .toList()
          : [],
      totalCount: readJsonInt(
        json['total_count'] ??
            json['totalCount'] ??
            nestedData?['total_count'] ??
            nestedData?['totalCount'],
      ),
    );
  }
}

class SecurityRequestItem {
  final int? id;
  final int? serviceId;
  final int? subServiceId;
  final String? subServiceName;
  final String? requestName;
  final String? requestStatus;
  final String? requestDate;
  final String? assignedTo;
  final String? requesterName;

  SecurityRequestItem({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.subServiceName,
    this.requestName,
    this.requestStatus,
    this.requestDate,
    this.assignedTo,
    this.requesterName,
  });

  factory SecurityRequestItem.fromJson(Map<String, dynamic> json) {
    final subServiceMap =
        readJsonMap(json['sub_service']) ?? readJsonMap(json['sub_service_id']);
    final employeeCardMap = readJsonMap(
      json['employeeCardRequest'] ?? json['employee_card_request'],
    );
    final retiredCardMap = readJsonMap(
      json['retiredCardRequest'] ?? json['retired_card_request'],
    );
    final gatePassMap = readJsonMap(
      json['gatePassRequest'] ?? json['gate_pass_request'],
    );
    final approvalDetails = json['approval_details'];
    final approvalMap = approvalDetails is List
        ? approvalDetails
              .map(readJsonMap)
              .whereType<Map<String, dynamic>>()
              .firstWhere((item) {
                final status =
                    readJsonString(item['approval_status'])?.toLowerCase() ??
                    '';
                return status == 'in progress' || status == 'pending';
              }, orElse: () => const {})
        : null;
    final approvalDepartmentMap = readJsonMap(approvalMap?['department']);
    final approvalSectionMap = readJsonMap(approvalMap?['section']);
    final requestDepartmentMap = readJsonMap(json['req_department']);
    final requestSectionMap = readJsonMap(json['req_section']);
    final assignedDepartment =
        readJsonString(approvalDepartmentMap?['department_name']) ??
        readJsonString(requestDepartmentMap?['department_name']) ??
        readJsonString(json['group_name']);
    final assignedSection =
        readJsonString(approvalSectionMap?['section_name']) ??
        readJsonString(requestSectionMap?['section_name']);

    final requestName =
        readJsonString(subServiceMap?['sub_service_name']) ??
        readJsonString(subServiceMap?['name']) ??
        readJsonString(json['request_name']) ??
        readJsonString(json['requestName']) ??
        readJsonString(json['title']) ??
        readJsonString(employeeCardMap?['name']) ??
        readJsonString(retiredCardMap?['ex_job_title']) ??
        readJsonString(gatePassMap?['serial_number']) ??
        readJsonString(json['serial_number']) ??
        readJsonString(json['reason_for_request']) ??
        readJsonString(json['name']);
    final assignedTo = [
      assignedDepartment,
      assignedSection,
    ].where((value) => value != null && value.trim().isNotEmpty).join(' - ');

    return SecurityRequestItem(
      id: readJsonInt(json['id'] ?? json['request_id']),
      serviceId: readJsonInt(json['service_id']),
      subServiceId: readJsonInt(json['sub_service_id']),
      subServiceName: readJsonString(
        subServiceMap?['sub_service_name'] ?? subServiceMap?['name'],
      ),
      requestName: requestName,
      requestStatus: readJsonString(
        json['request_status'] ?? json['status'] ?? json['approval_status'],
      ),
      requestDate: readJsonString(
        json['request_date'] ??
            json['requestDate'] ??
            json['date'] ??
            json['created_at'] ??
            json['createdAt'],
      ),
      assignedTo: assignedTo.isNotEmpty
          ? assignedTo
          : readJsonString(
              json['assigned_to'] ??
                  json['current_approver'] ??
                  json['reporting_manager'],
            ),
      requesterName:
          readJsonString(json['employee_name']) ??
          readJsonString(json['requested_by']) ??
          readJsonString(employeeCardMap?['name']) ??
          readJsonString(json['name']),
    );
  }
}
