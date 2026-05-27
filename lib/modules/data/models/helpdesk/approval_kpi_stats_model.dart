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

int? _readApprovalKpiInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
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
      totalAssignedToMe: _readApprovalKpiInt(json['total_approvals']),
      pendingMyApproval: _readApprovalKpiInt(json['pending']),
      approvedByMe: _readApprovalKpiInt(json['approved']),
      rejectedByMe: _readApprovalKpiInt(json['rejected']),
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
