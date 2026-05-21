class PassportRequestDetailsModel {
  final String? status;
  final PassportRequestData? data;

  PassportRequestDetailsModel({
    this.status,
    this.data,
  });

  factory PassportRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return PassportRequestDetailsModel(
      status: json['status'] as String?,
      data: json['data'] != null ? PassportRequestData.fromJson(json['data']) : null,
    );
  }
}

class PassportRequestData {
  final PassportRequestItem? request;
  final List<PassportWorkflowDetails>? workflowDetails;
  final List<PassportApprovalDetails>? approvalDetails;
  final List<PassportChatDetails>? chatMessages;
  final List<PassportAttachmentDetails>? attachments;

  PassportRequestData({
    this.request,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory PassportRequestData.fromJson(Map<String, dynamic> json) {
    return PassportRequestData(
      request: json['request'] != null ? PassportRequestItem.fromJson(json['request']) : null,
      workflowDetails: json['workflow_details'] != null
          ? (json['workflow_details'] as List)
              .map((e) => PassportWorkflowDetails.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      approvalDetails: json['approval_details'] != null
          ? (json['approval_details'] as List)
              .map((e) => PassportApprovalDetails.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      chatMessages: json['chat_messages'] != null
          ? (json['chat_messages'] as List)
              .map((e) => PassportChatDetails.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((e) => PassportAttachmentDetails.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class PassportRequestItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? userId;
  final String? requestNumberForOfficialUse;
  final String? passportType;
  final String? applicantCivilId;
  final String? applicantName;
  final String? applicantPassportNumber;
  final String? applicationForType;
  final String? applicationType;
  final String? applicantJobOccupation;
  final String? purposeOfApplication;
  final String? approvedMissionTravelId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final PassportUserDetails? createdByUser;
  final PassportDepartmentDetails? reqDepartment;
  final PassportSectionDetails? reqSection;
  final PassportServiceDetails? service;
  final PassportSubServiceDetails? subService;

  PassportRequestItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.userId,
    this.requestNumberForOfficialUse,
    this.passportType,
    this.applicantCivilId,
    this.applicantName,
    this.applicantPassportNumber,
    this.applicationForType,
    this.applicationType,
    this.applicantJobOccupation,
    this.purposeOfApplication,
    this.approvedMissionTravelId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
  });

  factory PassportRequestItem.fromJson(Map<String, dynamic> json) {
    return PassportRequestItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      requestNumberForOfficialUse: json['request_number_for_official_use'] as String?,
      passportType: json['passport_type'] as String?,
      applicantCivilId: json['applicant_civil_id'] as String?,
      applicantName: json['applicant_name'] as String?,
      applicantPassportNumber: json['applicant_passport_number'] as String?,
      applicationForType: json['application_for_type'] as String?,
      applicationType: json['application_type'] as String?,
      applicantJobOccupation: json['applicant_job_occupation'] as String?,
      purposeOfApplication: json['purpose_of_application'] as String?,
      approvedMissionTravelId: json['approved_mission_travel_id']?.toString(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdByUser: json['created_by_user'] != null
          ? PassportUserDetails.fromJson(json['created_by_user'])
          : null,
      reqDepartment: json['req_department'] != null
          ? PassportDepartmentDetails.fromJson(json['req_department'])
          : null,
      reqSection: json['req_section'] != null
          ? PassportSectionDetails.fromJson(json['req_section'])
          : null,
      service: json['service'] != null
          ? PassportServiceDetails.fromJson(json['service'])
          : null,
      subService: json['sub_service'] != null
          ? PassportSubServiceDetails.fromJson(json['sub_service'])
          : null,
    );
  }
}

class PassportUserDetails {
  final String? employeeName;
  final String? email;
  final String? mobile;
  final String? passportNumber;

  PassportUserDetails({
    this.employeeName,
    this.email,
    this.mobile,
    this.passportNumber,
  });

  factory PassportUserDetails.fromJson(Map<String, dynamic> json) {
    return PassportUserDetails(
      employeeName: json['employee_name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      passportNumber: json['passport_number'] as String?,
    );
  }
}

class PassportDepartmentDetails {
  final String? departmentName;
  final String? departmentCode;

  PassportDepartmentDetails({this.departmentName, this.departmentCode});

  factory PassportDepartmentDetails.fromJson(Map<String, dynamic> json) {
    return PassportDepartmentDetails(
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
    );
  }
}

class PassportSectionDetails {
  final String? sectionName;
  final String? sectionCode;

  PassportSectionDetails({this.sectionName, this.sectionCode});

  factory PassportSectionDetails.fromJson(Map<String, dynamic> json) {
    return PassportSectionDetails(
      sectionName: json['section_name'] as String?,
      sectionCode: json['section_code'] as String?,
    );
  }
}

class PassportServiceDetails {
  final String? name;

  PassportServiceDetails({this.name});

  factory PassportServiceDetails.fromJson(Map<String, dynamic> json) {
    return PassportServiceDetails(
      name: json['name'] as String?,
    );
  }
}

class PassportSubServiceDetails {
  final String? subServiceName;

  PassportSubServiceDetails({this.subServiceName});

  factory PassportSubServiceDetails.fromJson(Map<String, dynamic> json) {
    return PassportSubServiceDetails(
      subServiceName: json['sub_service_name'] as String?,
    );
  }
}

class PassportWorkflowDetails {
  final String? status;
  final String? content;
  final String? createdAt;
  final int? roleId;
  final PassportApproverRole? role;

  PassportWorkflowDetails({this.status, this.content, this.createdAt, this.roleId, this.role});

  factory PassportWorkflowDetails.fromJson(Map<String, dynamic> json) {
    return PassportWorkflowDetails(
      status: json['status'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
      roleId: json['role_id'] as int?,
      role: json['role'] != null ? PassportApproverRole.fromJson(json['role']) : null,
    );
  }
}

class PassportApproverRole {
  final String? name;

  PassportApproverRole({this.name});

  factory PassportApproverRole.fromJson(Map<String, dynamic> json) {
    return PassportApproverRole(
      name: json['name'] as String?,
    );
  }
}

class PassportApprovalDetails {
  final String? approvalStatus;
  final String? comment;
  final String? createdAt;
  final int? approverRoleId;
  final PassportUserDetails? approverUser;
  final PassportApproverRole? approverRole;

  PassportApprovalDetails({
    this.approvalStatus,
    this.comment,
    this.createdAt,
    this.approverRoleId,
    this.approverUser,
    this.approverRole,
  });

  factory PassportApprovalDetails.fromJson(Map<String, dynamic> json) {
    return PassportApprovalDetails(
      approvalStatus: json['approval_status'] as String?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      approverRoleId: json['approver_role_id'] as int?,
      approverUser: json['approver_user'] != null
          ? PassportUserDetails.fromJson(json['approver_user'])
          : null,
      approverRole: json['approver_role'] != null
          ? PassportApproverRole.fromJson(json['approver_role'])
          : null,
    );
  }
}

class PassportChatDetails {
  final String? message;
  final String? status;
  final int? roleId;
  final String? createdAt;
  final PassportUserDetails? user;

  PassportChatDetails({this.message, this.status, this.roleId, this.createdAt, this.user});

  factory PassportChatDetails.fromJson(Map<String, dynamic> json) {
    return PassportChatDetails(
      message: json['message'] as String?,
      status: json['status'] as String?,
      roleId: json['role_id'] as int?,
      createdAt: json['created_at'] as String?,
      user: json['user'] != null ? PassportUserDetails.fromJson(json['user']) : null,
    );
  }
}

class PassportAttachmentDetails {
  final String? fileUrl;
  final String? fileName;
  final String? fileType;
  final String? createdAt;

  PassportAttachmentDetails({this.fileUrl, this.fileName, this.fileType, this.createdAt});

  factory PassportAttachmentDetails.fromJson(Map<String, dynamic> json) {
    return PassportAttachmentDetails(
      fileUrl: json['file_url'] as String?,
      fileName: json['file_name'] as String?,
      fileType: json['file_type'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}
