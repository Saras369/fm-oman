import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';

class FinancialServiceRequestModel {
  final bool? success;
  final String? message;
  final List<FinancialServiceRequestItem>? data;
  final int? totalCount;

  FinancialServiceRequestModel({
    this.success,
    this.message,
    this.data,
    this.totalCount,
  });

  factory FinancialServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return FinancialServiceRequestModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => readJsonMap(e))
                .whereType<Map<String, dynamic>>()
                .map(FinancialServiceRequestItem.fromJson)
                .toList()
          : null,
      totalCount: readJsonInt(json['total_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_count': totalCount,
    };
  }
}

class FinancialServiceRequestItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? userId;
  final String? employeeId;
  final String? employeeName;
  final String? emailAddress;
  final String? contactNumber;
  final String? requestDate;
  final String? requestStatus;
  final int? serviceId;
  final SubServiceItem? subServiceId;
  final int? sectionId;
  final String? reportingManager;
  final String? createdAt;
  final String? updatedAt;
  final String? grade;
  final int? designationId;
  final int? departmentId;
  final String? requestCloseDate;
  final String? remarks;
  final int? currentApprovalLevel;
  final int? currentApproverId;
  final String? workflowExecutionId;

  FinancialServiceRequestItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.userId,
    this.employeeId,
    this.employeeName,
    this.emailAddress,
    this.contactNumber,
    this.requestDate,
    this.requestStatus,
    this.serviceId,
    this.subServiceId,
    this.sectionId,
    this.reportingManager,
    this.createdAt,
    this.updatedAt,
    this.grade,
    this.designationId,
    this.departmentId,
    this.requestCloseDate,
    this.remarks,
    this.currentApprovalLevel,
    this.currentApproverId,
    this.workflowExecutionId,
  });

  factory FinancialServiceRequestItem.fromJson(Map<String, dynamic> json) {
    return FinancialServiceRequestItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      userId: readJsonInt(json['user_id']),
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      emailAddress: json['email_address'] as String?,
      contactNumber: json['contact_number'] as String?,
      requestDate: json['request_date'] as String?,
      requestStatus: json['request_status'] as String?,
      serviceId: readJsonInt(json['service_id']),
      subServiceId: SubServiceItem.tryParse(json['sub_service_id']),
      sectionId: readJsonInt(json['section_id']),
      reportingManager: json['reporting_manager'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      grade: json['grade'] as String?,
      designationId: readJsonInt(json['designation_id']),
      departmentId: readJsonInt(json['department_id']),
      requestCloseDate: json['request_close_date'] as String?,
      remarks: json['remarks'] as String?,
      currentApprovalLevel: readJsonInt(json['current_approval_level']),
      currentApproverId: readJsonInt(json['current_approver_id']),
      workflowExecutionId: json['workflow_execution_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'user_id': userId,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'email_address': emailAddress,
      'contact_number': contactNumber,
      'request_date': requestDate,
      'request_status': requestStatus,
      'service_id': serviceId,
      'sub_service_id': subServiceId?.toJson(),
      'section_id': sectionId,
      'reporting_manager': reportingManager,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'grade': grade,
      'designation_id': designationId,
      'department_id': departmentId,
      'request_close_date': requestCloseDate,
      'remarks': remarks,
      'current_approval_level': currentApprovalLevel,
      'current_approver_id': currentApproverId,
      'workflow_execution_id': workflowExecutionId,
    };
  }
}

class SubServiceItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;
  final String? createdAt;
  final String? updatedAt;

  SubServiceItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.logoUrl,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  static SubServiceItem? tryParse(dynamic v) {
    if (v == null) return null;
    final m = readJsonMap(v);
    if (m != null) return SubServiceItem.fromJson(m);
    final id = readJsonInt(v);
    if (id == null) return null;
    return SubServiceItem(id: id);
  }

  factory SubServiceItem.fromJson(Map<String, dynamic> json) {
    return SubServiceItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      subServiceName: json['sub_service_name'] as String?,
      description: json['description'] as String?,
      serviceId: readJsonInt(json['service_id']),
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'sub_service_name': subServiceName,
      'description': description,
      'service_id': serviceId,
      'logo_url': logoUrl,
      'code': code,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
