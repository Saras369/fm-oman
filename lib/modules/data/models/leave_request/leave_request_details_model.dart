class LeaveRequestDetailsModel {
  final String? status;
  final LeaveRequestDetailsData? data;

  LeaveRequestDetailsModel({this.status, this.data});

  factory LeaveRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestDetailsModel(
      status: json['status'] as String?,
      data: json['data'] != null
          ? LeaveRequestDetailsData.fromJson(
              json['data'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class LeaveRequestDetailsData {
  final LeaveRequestDetailItem? request;
  final List<LeaveWorkflowDetail>? workflowDetails;
  final List<LeaveApprovalDetail>? approvalDetails;
  final List<LeaveChatMessage>? chatMessages;
  final List<LeaveAttachmentDetail>? attachments;

  LeaveRequestDetailsData({
    this.request,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory LeaveRequestDetailsData.fromJson(Map<String, dynamic> json) {
    return LeaveRequestDetailsData(
      request: json['request'] != null
          ? LeaveRequestDetailItem.fromJson(
              json['request'] as Map<String, dynamic>,
            )
          : null,
      workflowDetails: _mapList(json['workflow_details'], LeaveWorkflowDetail.fromJson),
      approvalDetails: _mapList(json['approval_details'], LeaveApprovalDetail.fromJson),
      chatMessages: _mapList(json['chat_messages'], LeaveChatMessage.fromJson),
      attachments: _mapList(json['attachments'], LeaveAttachmentDetail.fromJson),
    );
  }
}

List<T>? _mapList<T>(
  dynamic raw,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (raw is! List) return null;
  return raw
      .map((e) => fromJson(e as Map<String, dynamic>))
      .toList();
}

class LeaveRequestDetailItem {
  final int? id;
  final String? userId;
  final String? leaveFor;
  final int? leaveType;
  final String? status;
  final String? leaveStartDate;
  final String? leaveEndDate;
  final int? leaveDuration;
  final int? remainingLeaveBalance;
  final String? contactNumberDuringLeave;
  final String? addressDuringLeave;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final LeaveDepartmentDetail? department;
  final LeaveDetailUser? createdByUser;
  final LeaveServiceDetail? service;
  final LeaveSubServiceDetail? subService;

  LeaveRequestDetailItem({
    this.id,
    this.userId,
    this.leaveFor,
    this.leaveType,
    this.status,
    this.leaveStartDate,
    this.leaveEndDate,
    this.leaveDuration,
    this.remainingLeaveBalance,
    this.contactNumberDuringLeave,
    this.addressDuringLeave,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.department,
    this.createdByUser,
    this.service,
    this.subService,
  });

  factory LeaveRequestDetailItem.fromJson(Map<String, dynamic> json) {
    return LeaveRequestDetailItem(
      id: json['id'] as int?,
      userId: json['user_id']?.toString(),
      leaveFor: json['leave_for'] as String?,
      leaveType: json['leave_type'] as int?,
      status: json['status'] as String?,
      leaveStartDate: json['leave_start_date'] as String?,
      leaveEndDate: json['leave_end_date'] as String?,
      leaveDuration: json['leave_duration'] as int?,
      remainingLeaveBalance: json['remaining_leave_balance'] as int?,
      contactNumberDuringLeave: json['contact_number_during_leave'] as String?,
      addressDuringLeave: json['address_during_leave'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      department: json['department'] is Map<String, dynamic>
          ? LeaveDepartmentDetail.fromJson(
              json['department'] as Map<String, dynamic>,
            )
          : null,
      createdByUser: json['created_by_user'] is Map<String, dynamic>
          ? LeaveDetailUser.fromJson(
              json['created_by_user'] as Map<String, dynamic>,
            )
          : null,
      service: json['service'] is Map<String, dynamic>
          ? LeaveServiceDetail.fromJson(json['service'] as Map<String, dynamic>)
          : null,
      subService: json['sub_service'] is Map<String, dynamic>
          ? LeaveSubServiceDetail.fromJson(
              json['sub_service'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class LeaveDepartmentDetail {
  final int? id;
  final String? departmentName;

  LeaveDepartmentDetail({this.id, this.departmentName});

  factory LeaveDepartmentDetail.fromJson(Map<String, dynamic> json) {
    return LeaveDepartmentDetail(
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
    );
  }
}

class LeaveServiceDetail {
  final int? id;
  final String? name;

  LeaveServiceDetail({this.id, this.name});

  factory LeaveServiceDetail.fromJson(Map<String, dynamic> json) {
    return LeaveServiceDetail(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class LeaveSubServiceDetail {
  final int? id;
  final String? subServiceName;

  LeaveSubServiceDetail({this.id, this.subServiceName});

  factory LeaveSubServiceDetail.fromJson(Map<String, dynamic> json) {
    return LeaveSubServiceDetail(
      id: json['id'] as int?,
      subServiceName: json['sub_service_name'] as String?,
    );
  }
}

class LeaveDesignationDetail {
  final int? id;
  final String? name;

  LeaveDesignationDetail({this.id, this.name});

  factory LeaveDesignationDetail.fromJson(Map<String, dynamic> json) {
    return LeaveDesignationDetail(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class LeaveDetailUser {
  final int? id;
  final String? employeeId;
  final String? employeeName;
  final String? email;
  final String? mobile;
  final LeaveDesignationDetail? designation;
  final LeaveDepartmentDetail? department;

  LeaveDetailUser({
    this.id,
    this.employeeId,
    this.employeeName,
    this.email,
    this.mobile,
    this.designation,
    this.department,
  });

  factory LeaveDetailUser.fromJson(Map<String, dynamic> json) {
    LeaveDesignationDetail? designation;
    final designationRaw = json['designation'];
    if (designationRaw is Map<String, dynamic>) {
      designation = LeaveDesignationDetail.fromJson(designationRaw);
    }

    LeaveDepartmentDetail? department;
    final departmentRaw = json['department'];
    if (departmentRaw is Map<String, dynamic>) {
      department = LeaveDepartmentDetail.fromJson(departmentRaw);
    } else if (departmentRaw is int && json['department_name'] is String) {
      department = LeaveDepartmentDetail(
        id: departmentRaw,
        departmentName: json['department_name'] as String?,
      );
    }

    return LeaveDetailUser(
      id: json['id'] as int?,
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      designation: designation,
      department: department,
    );
  }

  String get designationName => designation?.name ?? '';
}

class LeaveWorkflowDetail {
  final int? id;
  final int? leaveRequestId;
  final String? content;
  final String? status;
  final int? roleId;
  final String? createdAt;
  final LeaveRoleDetail? role;

  LeaveWorkflowDetail({
    this.id,
    this.leaveRequestId,
    this.content,
    this.status,
    this.roleId,
    this.createdAt,
    this.role,
  });

  factory LeaveWorkflowDetail.fromJson(Map<String, dynamic> json) {
    return LeaveWorkflowDetail(
      id: json['id'] as int?,
      leaveRequestId: json['leave_request_id'] as int?,
      content: json['content'] as String?,
      status: json['status'] as String?,
      roleId: json['role_id'] as int?,
      createdAt: json['created_at'] as String?,
      role: json['role'] is Map<String, dynamic>
          ? LeaveRoleDetail.fromJson(json['role'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LeaveRoleDetail {
  final int? id;
  final String? name;

  LeaveRoleDetail({this.id, this.name});

  factory LeaveRoleDetail.fromJson(Map<String, dynamic> json) {
    return LeaveRoleDetail(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class LeaveApprovalDetail {
  final int? id;
  final int? leaveRequestId;
  final int? approverUserId;
  final int? approverRoleId;
  final int? departmentId;
  final int? sectionId;
  final String? comment;
  final String? approvalStatus;
  final int? level;
  final String? createdAt;
  final LeaveRoleDetail? approverRole;
  final LeaveDetailUser? approverUser;

  LeaveApprovalDetail({
    this.id,
    this.leaveRequestId,
    this.approverUserId,
    this.approverRoleId,
    this.departmentId,
    this.sectionId,
    this.comment,
    this.approvalStatus,
    this.level,
    this.createdAt,
    this.approverRole,
    this.approverUser,
  });

  factory LeaveApprovalDetail.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalDetail(
      id: json['id'] as int?,
      leaveRequestId: json['leave_request_id'] as int?,
      approverUserId: json['approver_user_id'] as int?,
      approverRoleId: json['approver_role_id'] as int?,
      departmentId: json['department_id'] as int?,
      sectionId: json['section_id'] as int?,
      comment: json['comment'] as String?,
      approvalStatus: json['approval_status'] as String?,
      level: json['level'] as int?,
      createdAt: json['created_at'] as String?,
      approverRole: json['approver_role'] is Map<String, dynamic>
          ? LeaveRoleDetail.fromJson(json['approver_role'] as Map<String, dynamic>)
          : null,
      approverUser: json['approver_user'] is Map<String, dynamic>
          ? LeaveDetailUser.fromJson(json['approver_user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LeaveChatMessage {
  final int? id;
  final int? leaveRequestId;
  final String? content;
  final int? senderUserId;
  final String? status;
  final int? roleId;
  final String? createdAt;
  final LeaveDetailUser? senderUser;

  LeaveChatMessage({
    this.id,
    this.leaveRequestId,
    this.content,
    this.senderUserId,
    this.status,
    this.roleId,
    this.createdAt,
    this.senderUser,
  });

  factory LeaveChatMessage.fromJson(Map<String, dynamic> json) {
    return LeaveChatMessage(
      id: json['id'] as int?,
      leaveRequestId: json['leave_request_id'] as int?,
      content: json['content'] as String?,
      senderUserId: json['sender_user_id'] as int?,
      status: json['status'] as String?,
      roleId: json['role_id'] as int?,
      createdAt: json['created_at'] as String?,
      senderUser: json['sender_user'] is Map<String, dynamic>
          ? LeaveDetailUser.fromJson(json['sender_user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LeaveAttachmentDetail {
  final String? fileName;
  final String? fileType;
  final String? createdAt;

  LeaveAttachmentDetail({this.fileName, this.fileType, this.createdAt});

  factory LeaveAttachmentDetail.fromJson(Map<String, dynamic> json) {
    return LeaveAttachmentDetail(
      fileName: json['file_name'] as String? ?? json['document_name'] as String?,
      fileType: json['file_type'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}
