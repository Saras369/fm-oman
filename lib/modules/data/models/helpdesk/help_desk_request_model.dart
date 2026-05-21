class HelpDeskRequestModel {
  final bool? success;
  final String? message;
  final List<HelpDeskRequestItem>? data;
  final int? total;
  final String? page;
  final String? limit;
  final bool? hasMore;

  HelpDeskRequestModel({
    this.success,
    this.message,
    this.data,
    this.total,
    this.page,
    this.limit,
    this.hasMore,
  });

  factory HelpDeskRequestModel.fromJson(Map<String, dynamic> json) {
    return HelpDeskRequestModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => HelpDeskRequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int?,
      page: json['page']?.toString(),
      limit: json['limit']?.toString(),
      hasMore: json['hasMore'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'hasMore': hasMore,
    };
  }
}

class HelpDeskRequestItem {
  final String? createdBy;
  final String? updatedBy;
  final HelpDeskRequestStatusItem? id;
  final int? userId;
  final String? requestDate;
  final String? requestStatus;
  final int? serviceId;
  final int? subServiceId;
  final int? sectionId;
  final String? createdAt;
  final String? updatedAt;
  final String? contactNumber;
  final String? personName;
  final String? requestCloseDate;
  final String? problem;
  final String? workflowExecutionId;
  final int? issueTypeId;
  final int? assignedGroupId;
  final String? groupName;
  final int? categoryId;
  final int? subcategoryId;
  final int? currentAssigneeGroupId;
  final int? currentAssigneeUserId;
  final String? closureReason;
  final String? description;
  final String? extensionNumber;
  final String? priority;

  HelpDeskRequestItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.userId,
    this.requestDate,
    this.requestStatus,
    this.serviceId,
    this.subServiceId,
    this.sectionId,
    this.createdAt,
    this.updatedAt,
    this.contactNumber,
    this.personName,
    this.requestCloseDate,
    this.problem,
    this.workflowExecutionId,
    this.issueTypeId,
    this.assignedGroupId,
    this.groupName,
    this.categoryId,
    this.subcategoryId,
    this.currentAssigneeGroupId,
    this.currentAssigneeUserId,
    this.closureReason,
    this.description,
    this.extensionNumber,
    this.priority,
  });

  factory HelpDeskRequestItem.fromJson(Map<String, dynamic> json) {
    return HelpDeskRequestItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by']?.toString(),
      id: json['id'] == null
          ? null
          : HelpDeskRequestStatusItem.fromJson(
              json['id'] as Map<String, dynamic>,
            ),
      userId: json['user_id'] as int?,
      requestDate: json['request_date'] as String?,
      requestStatus: json['request_status'] as String?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      sectionId: json['section_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      contactNumber: json['contact_number'] as String?,
      personName: json['person_name'] as String?,
      requestCloseDate: json['request_close_date'] as String?,
      problem: json['problem'] as String?,
      workflowExecutionId: json['workflow_execution_id']?.toString(),
      issueTypeId: json['issue_type_id'] as int?,
      assignedGroupId: json['assigned_group_id'] as int?,
      groupName: json['group_name'] as String?,
      categoryId: json['category_id'] as int?,
      subcategoryId: json['subcategory_id'] as int?,
      currentAssigneeGroupId: json['current_assignee_group_id'] as int?,
      currentAssigneeUserId: json['current_assignee_user_id'] as int?,
      closureReason: json['closure_reason'] as String?,
      description: json['description'] as String?,
      extensionNumber: json['extension_number'] as String?,
      priority: json['priority'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id?.toJson(),
      'user_id': userId,
      'request_date': requestDate,
      'request_status': requestStatus,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'section_id': sectionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'contact_number': contactNumber,
      'person_name': personName,
      'request_close_date': requestCloseDate,
      'problem': problem,
      'workflow_execution_id': workflowExecutionId,
      'issue_type_id': issueTypeId,
      'assigned_group_id': assignedGroupId,
      'group_name': groupName,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'current_assignee_group_id': currentAssigneeGroupId,
      'current_assignee_user_id': currentAssigneeUserId,
      'closure_reason': closureReason,
      'description': description,
      'extension_number': extensionNumber,
      'priority': priority,
    };
  }
}

class HelpDeskRequestStatusItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? requestId;
  final String? status;
  final int? approvedByUserId;
  final int? approvedByRoleId;
  final String? content;
  final String? date;
  final int? serviceId;
  final int? subServiceId;
  final String? createdAt;
  final String? updatedAt;
  final int? approvalId;
  final String? closureReason;

  HelpDeskRequestStatusItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.requestId,
    this.status,
    this.approvedByUserId,
    this.approvedByRoleId,
    this.content,
    this.date,
    this.serviceId,
    this.subServiceId,
    this.createdAt,
    this.updatedAt,
    this.approvalId,
    this.closureReason,
  });

  factory HelpDeskRequestStatusItem.fromJson(Map<String, dynamic> json) {
    return HelpDeskRequestStatusItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by']?.toString(),
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      status: json['status'] as String?,
      approvedByUserId: json['approved_by_user_id'] as int?,
      approvedByRoleId: json['approved_by_role_id'] as int?,
      content: json['content'] as String?,
      date: json['date'] as String?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      approvalId: json['approval_id'] as int?,
      closureReason: json['closure_reason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'request_id': requestId,
      'status': status,
      'approved_by_user_id': approvedByUserId,
      'approved_by_role_id': approvedByRoleId,
      'content': content,
      'date': date,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'approval_id': approvalId,
      'closure_reason': closureReason,
    };
  }
}
