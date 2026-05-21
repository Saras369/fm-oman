class ApprovalKpiStatsModel {
  final bool? success;
  final String? message;
  final ApprovalKpiStatsItem? data;

  ApprovalKpiStatsModel({this.success, this.message, this.data});

  factory ApprovalKpiStatsModel.fromJson(Map<String, dynamic> json) {
    return ApprovalKpiStatsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ApprovalKpiStatsItem.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class ApprovalKpiStatsItem {
  final int? totalAssignedToMe;
  final int? pendingMyApproval;
  final int? approvedByMe;
  final int? rejectedByMe;

  ApprovalKpiStatsItem({
    this.totalAssignedToMe,
    this.pendingMyApproval,
    this.approvedByMe,
    this.rejectedByMe,
  });

  factory ApprovalKpiStatsItem.fromJson(Map<String, dynamic> json) {
    return ApprovalKpiStatsItem(
      totalAssignedToMe: json['total_approvals'] as int?,
      pendingMyApproval: json['pending'] as int?,
      approvedByMe: json['approved'] as int?,
      rejectedByMe: json['rejected'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_approvals': totalAssignedToMe,
      'pending': pendingMyApproval,
      'approved': approvedByMe,
      'rejected': rejectedByMe,
    };
  }
}
