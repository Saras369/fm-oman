import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';

class FinancialServicesRequestDetailsModel {
  final bool? success;
  final String? message;
  final List<FinancialServiceRequestDetailsItem>? data;
  final int? count;

  FinancialServicesRequestDetailsModel({
    this.success,
    this.message,
    this.data,
    this.count,
  });

  factory FinancialServicesRequestDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<FinancialServiceRequestDetailsItem>? detailItems;
    int? count;

    final rawData = json['data'];
    if (rawData is List && rawData.isNotEmpty) {
      // If first element is a list, parse as the actual details
      if (rawData[0] is List) {
        detailItems = (rawData[0] as List)
            .map(
              (item) => FinancialServiceRequestDetailsItem.fromJson(
                readJsonMap(item) ?? <String, dynamic>{},
              ),
            )
            .toList();
      } else {
        detailItems = null;
      }
      // If second element is int, use as count
      if (rawData.length > 1) {
        count = readJsonInt(rawData[1]);
      }
    }
    return FinancialServicesRequestDetailsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: detailItems,
      count:
          count ??
          readJsonInt(json['count']) ??
          readJsonInt(json['total_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      // You may want to wrap data in a list to re-create the same API structure
      'data': data != null ? [data] : null,
      'count': count,
    };
  }
}

class FinancialServiceRequestDetailsItem {
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
  final int? subServiceId;
  final int? sectionId;
  final String? reportingManager;
  final String? createdAt;
  final String? updatedAt;
  final String? grade;
  final DesignationDetails? designationId;
  final DepartmentDetails? departmentId;
  final String? requestCloseDate;
  final String? remarks;
  final int? currentApprovalLevel;
  final int? currentApproverId;
  final String? workflowExecutionId;
  final BankAccountChangeRequestDetails? bankAccountChangeRequest;
  final List<ApprovalDetails>? approvals;
  final List<WorkflowDetails>? workflows;
  final List<AttachmentDetails>? attachments;
  final List<ChatDetails>? chats;
  final PayslipRequestDetails? payslipRequest;
  final SalaryCertificateRequestDetails? salaryCertificateRequest;
  final AllowanceRequestDetails? allowanceRequest;
  final ReimbursementRequestBundle? reimbursementRequest;

  FinancialServiceRequestDetailsItem({
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
    this.bankAccountChangeRequest,
    this.approvals,
    this.workflows,
    this.attachments,
    this.chats,
    this.payslipRequest,
    this.salaryCertificateRequest,
    this.allowanceRequest,
    this.reimbursementRequest,
  });

  factory FinancialServiceRequestDetailsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinancialServiceRequestDetailsItem(
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
      subServiceId: readJsonInt(json['sub_service_id']),
      sectionId: readJsonInt(json['section_id']),
      reportingManager: json['reporting_manager'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      grade: json['grade'] as String?,
      designationId: readJsonMap(json['designation_id']) != null
          ? DesignationDetails.fromJson(readJsonMap(json['designation_id'])!)
          : null,
      departmentId: readJsonMap(json['department_id']) != null
          ? DepartmentDetails.fromJson(readJsonMap(json['department_id'])!)
          : null,
      requestCloseDate: json['request_close_date'] as String?,
      remarks: json['remarks'] as String?,
      currentApprovalLevel: readJsonInt(json['current_approval_level']),
      currentApproverId: readJsonInt(json['current_approver_id']),
      workflowExecutionId: json['workflow_execution_id'] as String?,
      bankAccountChangeRequest:
          readJsonMap(json['bankAccountChangeRequest']) != null
          ? BankAccountChangeRequestDetails.fromJson(
              readJsonMap(json['bankAccountChangeRequest'])!,
            )
          : null,
      approvals: json['approvals'] != null
          ? (json['approvals'] as List)
                .map(readJsonMap)
                .whereType<Map<String, dynamic>>()
                .map(ApprovalDetails.fromJson)
                .toList()
          : null,
      workflows: json['workflows'] != null
          ? (json['workflows'] as List)
                .map(readJsonMap)
                .whereType<Map<String, dynamic>>()
                .map(WorkflowDetails.fromJson)
                .toList()
          : null,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
                .map(readJsonMap)
                .whereType<Map<String, dynamic>>()
                .map(AttachmentDetails.fromJson)
                .toList()
          : null,
      chats: json['chats'] != null
          ? (json['chats'] as List)
                .map(readJsonMap)
                .whereType<Map<String, dynamic>>()
                .map(ChatDetails.fromJson)
                .toList()
          : null,
      payslipRequest: readJsonMap(json['payslipRequest']) != null
          ? PayslipRequestDetails.fromJson(readJsonMap(json['payslipRequest'])!)
          : null,
      salaryCertificateRequest:
          readJsonMap(json['salaryCertificateRequest']) != null
          ? SalaryCertificateRequestDetails.fromJson(
              readJsonMap(json['salaryCertificateRequest'])!,
            )
          : null,
      allowanceRequest: readJsonMap(json['allowanceRequest']) != null
          ? AllowanceRequestDetails.fromJson(
              readJsonMap(json['allowanceRequest'])!,
            )
          : null,
      reimbursementRequest: _parseReimbursementBundle(json),
    );
  }

  static ReimbursementRequestBundle? _parseReimbursementBundle(
    Map<String, dynamic> json,
  ) {
    final dynamic plural = json['reimbursementRequests'];
    final dynamic singular = json['reimbursementRequest'];
    if (plural is List) return null;
    final map = readJsonMap(plural) ?? readJsonMap(singular);
    if (map == null) return null;
    return ReimbursementRequestBundle.fromJson(map);
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
      'sub_service_id': subServiceId,
      'section_id': sectionId,
      'reporting_manager': reportingManager,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'grade': grade,
      'designation_id': designationId?.toJson(),
      'department_id': departmentId?.toJson(),
      'request_close_date': requestCloseDate,
      'remarks': remarks,
      'current_approval_level': currentApprovalLevel,
      'current_approver_id': currentApproverId,
      'workflow_execution_id': workflowExecutionId,
      'bankAccountChangeRequest': bankAccountChangeRequest?.toJson(),
      'approvals': approvals?.map((e) => e.toJson()).toList(),
      'workflows': workflows?.map((e) => e.toJson()).toList(),
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      'chats': chats?.map((e) => e.toJson()).toList(),
      'payslipRequest': payslipRequest?.toJson(),
      'salaryCertificateRequest': salaryCertificateRequest?.toJson(),
      'allowanceRequest': allowanceRequest?.toJson(),
      'reimbursementRequest': reimbursementRequest?.toJson(),
    };
  }
}

class DesignationDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  DesignationDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory DesignationDetails.fromJson(Map<String, dynamic> json) {
    return DesignationDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class DepartmentDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  DepartmentDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory DepartmentDetails.fromJson(Map<String, dynamic> json) {
    return DepartmentDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      departmentName:
          readJsonString(json['department_name']) ??
          readJsonString(json['name']),
      departmentCode:
          readJsonString(json['department_code']) ??
          readJsonString(json['code']),
      departmentDescription: json['department_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class SectionDetails {
  final int? id;
  final String? sectionName;
  final String? sectionCode;

  SectionDetails({this.id, this.sectionName, this.sectionCode});

  factory SectionDetails.fromJson(Map<String, dynamic> json) {
    return SectionDetails(
      id: readJsonInt(json['id']),
      sectionName:
          readJsonString(json['section_name']) ?? readJsonString(json['name']),
      sectionCode:
          readJsonString(json['section_code']) ?? readJsonString(json['code']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'section_name': sectionName, 'section_code': sectionCode};
  }
}

class BankAccountChangeRequestDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? financialRequestId;
  final String? newBankName;
  final String? newAccountNumber;
  final String? newAccountName;
  final String? newBranchIfscCode;
  final String? reasonForChange;
  final String? effectiveFromDate;
  final String? createdAt;
  final String? updatedAt;
  final String? oldBankName;
  final String? oldAccountNumber;

  BankAccountChangeRequestDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.financialRequestId,
    this.newBankName,
    this.newAccountNumber,
    this.newAccountName,
    this.newBranchIfscCode,
    this.reasonForChange,
    this.effectiveFromDate,
    this.createdAt,
    this.updatedAt,
    this.oldBankName,
    this.oldAccountNumber,
  });

  factory BankAccountChangeRequestDetails.fromJson(Map<String, dynamic> json) {
    return BankAccountChangeRequestDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      newBankName: json['new_bank_name'] as String?,
      newAccountNumber: json['new_account_number'] as String?,
      newAccountName: json['new_account_name'] as String?,
      newBranchIfscCode: json['new_branch_ifsc_code'] as String?,
      reasonForChange: json['reason_for_change'] as String?,
      effectiveFromDate: json['effective_from_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      oldBankName: json['old_bank_name'] as String?,
      oldAccountNumber: json['old_account_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'financial_request_id': financialRequestId,
      'new_bank_name': newBankName,
      'new_account_number': newAccountNumber,
      'new_account_name': newAccountName,
      'new_branch_ifsc_code': newBranchIfscCode,
      'reason_for_change': reasonForChange,
      'effective_from_date': effectiveFromDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'old_bank_name': oldBankName,
      'old_account_number': oldAccountNumber,
    };
  }
}

class ApprovalDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? financialRequestId;
  final int? level;
  final int? approverRoleId;
  final String? approvalStatus;
  final int? departmentId;
  final int? sectionId;
  final int? approvedBy;
  final String? createdAt;
  final String? updatedAt;
  final int? approverUserId;
  final String? comment;
  final String? actionDate;
  final bool? isAllowed;
  final String? actionType;
  final int? delegateUserId;
  final String? approverRoleName;
  final String? approverUserName;
  final String? approverUserEmail;
  final DepartmentDetails? departmentDetails;
  final SectionDetails? sectionDetails;

  ApprovalDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.financialRequestId,
    this.level,
    this.approverRoleId,
    this.approvalStatus,
    this.departmentId,
    this.sectionId,
    this.approvedBy,
    this.createdAt,
    this.updatedAt,
    this.approverUserId,
    this.comment,
    this.actionDate,
    this.isAllowed,
    this.actionType,
    this.delegateUserId,
    this.approverRoleName,
    this.approverUserName,
    this.approverUserEmail,
    this.departmentDetails,
    this.sectionDetails,
  });

  factory ApprovalDetails.fromJson(Map<String, dynamic> json) {
    final approverUserMap = readJsonMap(json['approver_user_id']);
    final approverRoleMap = readJsonMap(json['approver_role_id']);
    final departmentMap = readJsonMap(json['department_id']);
    final sectionMap = readJsonMap(json['section_id']);
    return ApprovalDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      level: readJsonInt(json['level']),
      approverRoleId: readJsonInt(json['approver_role_id']),
      approvalStatus: json['approval_status'] as String?,
      departmentId: readJsonInt(json['department_id']),
      sectionId: readJsonInt(json['section_id']),
      approvedBy: readJsonInt(json['approved_by']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      approverUserId: readJsonInt(json['approver_user_id']),
      comment: json['comment'] as String?,
      actionDate: json['action_date'] as String?,
      isAllowed: readJsonBool(json['is_allowed']),
      actionType: json['action_type'] as String?,
      delegateUserId: readJsonInt(json['delegate_user_id']),
      approverRoleName: approverRoleMap?['name'] as String?,
      approverUserName: approverUserMap?['employee_name'] as String?,
      approverUserEmail: approverUserMap?['email'] as String?,
      departmentDetails: departmentMap != null
          ? DepartmentDetails.fromJson(departmentMap)
          : null,
      sectionDetails: sectionMap != null
          ? SectionDetails.fromJson(sectionMap)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'financial_request_id': financialRequestId,
      'level': level,
      'approver_role_id': approverRoleId,
      'approval_status': approvalStatus,
      'department_id': departmentId,
      'section_id': sectionId,
      'approved_by': approvedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'approver_user_id': approverUserId,
      'comment': comment,
      'action_date': actionDate,
      'is_allowed': isAllowed,
      'action_type': actionType,
      'delegate_user_id': delegateUserId,
      'approver_role_name': approverRoleName,
      'approver_user_name': approverUserName,
      'approver_user_email': approverUserEmail,
      'department_details': departmentDetails?.toJson(),
      'section_details': sectionDetails?.toJson(),
    };
  }
}

class WorkflowDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? financialRequestId;
  final String? status;
  final int? approvedByUserId;
  final String? content;
  final int? financialApprovalId;
  final String? activityDate;
  final String? createdAt;
  final String? updatedAt;
  final int? stepOrder;
  final String? action;
  final int? approvedByRoleId;

  WorkflowDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.financialRequestId,
    this.status,
    this.approvedByUserId,
    this.content,
    this.financialApprovalId,
    this.activityDate,
    this.createdAt,
    this.updatedAt,
    this.stepOrder,
    this.action,
    this.approvedByRoleId,
  });

  factory WorkflowDetails.fromJson(Map<String, dynamic> json) {
    return WorkflowDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      status: json['status'] as String?,
      approvedByUserId: readJsonInt(json['approved_by_user_id']),
      content: json['content'] as String?,
      financialApprovalId: readJsonInt(json['financial_approval_id']),
      activityDate: json['activity_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      stepOrder: readJsonInt(json['step_order']),
      action: json['action'] as String?,
      approvedByRoleId: readJsonInt(json['approved_by_role_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'financial_request_id': financialRequestId,
      'status': status,
      'approved_by_user_id': approvedByUserId,
      'content': content,
      'financial_approval_id': financialApprovalId,
      'activity_date': activityDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'step_order': stepOrder,
      'action': action,
      'approved_by_role_id': approvedByRoleId,
    };
  }
}

class AttachmentDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? financialRequestId;
  final String? fileUrl;
  final String? fileName;
  final String? fileType;
  final String? createdAt;
  final String? updatedAt;

  AttachmentDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.financialRequestId,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.createdAt,
    this.updatedAt,
  });

  factory AttachmentDetails.fromJson(Map<String, dynamic> json) {
    return AttachmentDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      fileUrl: json['file_url'] as String?,
      fileName: json['file_name'] as String?,
      fileType: json['file_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'financial_request_id': financialRequestId,
      'file_url': fileUrl,
      'file_name': fileName,
      'file_type': fileType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ChatDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? financialRequestId;
  final String? content;
  final SenderUserDetails? senderUserId;
  final String? createdAt;
  final String? updatedAt;

  ChatDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.financialRequestId,
    this.content,
    this.senderUserId,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatDetails.fromJson(Map<String, dynamic> json) {
    return ChatDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      content: json['content'] as String?,
      senderUserId: readJsonMap(json['sender_user_id']) != null
          ? SenderUserDetails.fromJson(readJsonMap(json['sender_user_id'])!)
          : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'financial_request_id': financialRequestId,
      'content': content,
      'sender_user_id': senderUserId?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class SenderUserDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? employeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String? gender;
  final String? maritalStatus;
  final String? nationality;
  final String? email;
  final String? bloodGroup;
  final String? nationalId;
  final String? mobile;
  final String? officeNumber;
  final int? department;
  final int? section;
  final int? grade;
  final String? location;
  final String? country;
  final bool? isAdmin;
  final int? division;
  final int? reportingTo;
  final String? address;
  final String? residentialStatus;
  final String? religion;
  final int? designation;
  final String? avatar;
  final String? passportNumber;
  final String? personalEmail;
  final String? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final int? civilEmployeeId;
  final String? qualification;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? languagePreferences;
  final String? category;
  final String? createdAt;
  final String? updatedAt;

  SenderUserDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.employeeId,
    this.employeeName,
    this.employeeArabicName,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    this.gender,
    this.maritalStatus,
    this.nationality,
    this.email,
    this.bloodGroup,
    this.nationalId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.section,
    this.grade,
    this.location,
    this.country,
    this.isAdmin,
    this.division,
    this.reportingTo,
    this.address,
    this.residentialStatus,
    this.religion,
    this.designation,
    this.avatar,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.civilEmployeeId,
    this.qualification,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.languagePreferences,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory SenderUserDetails.fromJson(Map<String, dynamic> json) {
    return SenderUserDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: readJsonInt(json['id']),
      employeeId: readJsonString(json['employee_id']),
      employeeName: json['employee_name'] as String?,
      employeeArabicName: json['employee_arabic_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      regionOfBirth: json['region_of_birth'] as String?,
      countryOfBirth: json['country_of_birth'] as String?,
      dateOfJoining: json['date_of_joining'] as String?,
      lastPromotionDate: json['last_promotion_date'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,
      nationality: readJsonString(json['nationality']),
      email: json['email'] as String?,
      bloodGroup: json['blood_group'] as String?,
      nationalId: readJsonString(json['national_id']),
      mobile: readJsonString(json['mobile']),
      officeNumber: readJsonString(json['office_number']),
      department: readJsonInt(json['department']),
      section: readJsonInt(json['section']),
      grade: readJsonInt(json['grade']),
      location: json['location'] as String?,
      country: readJsonString(json['country']),
      isAdmin: readJsonBool(json['is_admin']),
      division: readJsonInt(json['division']),
      reportingTo: readJsonInt(json['reporting_to']),
      address: json['address'] as String?,
      residentialStatus: json['residential_status'] as String?,
      religion: json['religion'] as String?,
      designation: readJsonInt(json['designation']),
      avatar: json['avatar'] as String?,
      passportNumber: json['passport_number'] as String?,
      personalEmail: json['personal_email'] as String?,
      extensionNumber: readJsonString(json['extension_number']),
      faxNumber: readJsonString(json['fax_number']),
      diplomaticName: readJsonString(json['diplomatic_name']),
      civilEmployeeId: readJsonInt(json['civil_employee_id']),
      qualification: json['qualification'] as String?,
      fatherName: json['father_name'] as String?,
      spouseName: json['spouse_name'] as String?,
      children1Name: json['children1_name'] as String?,
      children2Name: json['children2_name'] as String?,
      languagePreferences: json['language_preferences'] as String?,
      category: json['category'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'date_of_birth': dateOfBirth,
      'region_of_birth': regionOfBirth,
      'country_of_birth': countryOfBirth,
      'date_of_joining': dateOfJoining,
      'last_promotion_date': lastPromotionDate,
      'gender': gender,
      'marital_status': maritalStatus,
      'nationality': nationality,
      'email': email,
      'blood_group': bloodGroup,
      'national_id': nationalId,
      'mobile': mobile,
      'office_number': officeNumber,
      'department': department,
      'section': section,
      'grade': grade,
      'location': location,
      'country': country,
      'is_admin': isAdmin,
      'division': division,
      'reporting_to': reportingTo,
      'address': address,
      'residential_status': residentialStatus,
      'religion': religion,
      'designation': designation,
      'avatar': avatar,
      'passport_number': passportNumber,
      'personal_email': personalEmail,
      'extension_number': extensionNumber,
      'fax_number': faxNumber,
      'diplomatic_name': diplomaticName,
      'civil_employee_id': civilEmployeeId,
      'qualification': qualification,
      'father_name': fatherName,
      'spouse_name': spouseName,
      'language_preferences': languagePreferences,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PayslipRequestDetails {
  final int? id;
  final int? financialRequestId;
  final String? payslipMonth;
  final int? payslipYear;
  final String? payslipUrl;
  final String? createdAt;
  final String? updatedAt;

  PayslipRequestDetails({
    this.id,
    this.financialRequestId,
    this.payslipMonth,
    this.payslipYear,
    this.payslipUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory PayslipRequestDetails.fromJson(Map<String, dynamic> json) {
    return PayslipRequestDetails(
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      payslipMonth: json['payslip_month'] as String?,
      payslipYear: readJsonInt(json['payslip_year']),
      payslipUrl: json['payslip_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financial_request_id': financialRequestId,
    'payslip_month': payslipMonth,
    'payslip_year': payslipYear,
    'payslip_url': payslipUrl,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class SalaryCertificateRequestDetails {
  final int? id;
  final int? financialRequestId;
  final String? certificatePurpose;
  final String? certificateUrl;
  final String? createdAt;
  final String? updatedAt;

  SalaryCertificateRequestDetails({
    this.id,
    this.financialRequestId,
    this.certificatePurpose,
    this.certificateUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory SalaryCertificateRequestDetails.fromJson(Map<String, dynamic> json) {
    return SalaryCertificateRequestDetails(
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      certificatePurpose: json['certificate_purpose'] as String?,
      certificateUrl: json['certificate_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financial_request_id': financialRequestId,
    'certificate_purpose': certificatePurpose,
    'certificate_url': certificateUrl,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class AllowanceRequestDetails {
  final int? id;
  final int? financialRequestId;
  final int? allowanceTypeId;
  final String? allowanceAmount;
  final String? approvedAllowanceAmount;
  final String? currency;
  final String? contactNumber;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  AllowanceRequestDetails({
    this.id,
    this.financialRequestId,
    this.allowanceTypeId,
    this.allowanceAmount,
    this.approvedAllowanceAmount,
    this.currency,
    this.contactNumber,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory AllowanceRequestDetails.fromJson(Map<String, dynamic> json) {
    return AllowanceRequestDetails(
      id: readJsonInt(json['id']),
      financialRequestId: readJsonInt(json['financial_request_id']),
      allowanceTypeId: readJsonInt(json['allowance_type_id']),
      allowanceAmount: json['allowance_amount']?.toString(),
      approvedAllowanceAmount: json['approved_allowance_amount']?.toString(),
      currency: json['currency'] as String?,
      contactNumber: readJsonString(json['contact_number']),
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'financial_request_id': financialRequestId,
    'allowance_type_id': allowanceTypeId,
    'allowance_amount': allowanceAmount,
    'approved_allowance_amount': approvedAllowanceAmount,
    'currency': currency,
    'contact_number': contactNumber,
    'description': description,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class ReimbursementLineItem {
  final String? id;
  final String? itemDescription;
  final num? price;
  final num? qty;
  final num? amount;

  ReimbursementLineItem({
    this.id,
    this.itemDescription,
    this.price,
    this.qty,
    this.amount,
  });

  factory ReimbursementLineItem.fromJson(Map<String, dynamic> json) {
    return ReimbursementLineItem(
      id: readJsonString(json['id']),
      itemDescription: json['item_description'] as String?,
      price: readJsonNum(json['price']),
      qty: readJsonNum(json['qty']),
      amount: readJsonNum(json['amount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'item_description': itemDescription,
    'price': price,
    'qty': qty,
    'amount': amount,
  };
}

class ReimbursementRequestBundle {
  final List<ReimbursementLineItem> items;
  final String? paymentDate;
  final String? paymentMode;
  final num? totalAmount;
  final String? currency;

  ReimbursementRequestBundle({
    required this.items,
    this.paymentDate,
    this.paymentMode,
    this.totalAmount,
    this.currency,
  });

  factory ReimbursementRequestBundle.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final list = <ReimbursementLineItem>[];
    if (rawItems is List) {
      for (final e in rawItems) {
        final m = readJsonMap(e);
        if (m != null) list.add(ReimbursementLineItem.fromJson(m));
      }
    }
    return ReimbursementRequestBundle(
      items: list,
      paymentDate: json['payment_date'] as String?,
      paymentMode: json['payment_mode'] as String?,
      totalAmount: readJsonNum(json['total_amount']),
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
    'payment_date': paymentDate,
    'payment_mode': paymentMode,
    'total_amount': totalAmount,
    'currency': currency,
  };
}
