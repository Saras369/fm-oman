class LeaveCountModel {
  final String? status;
  final String? message;
  final List<LeaveCountItem>? data;
  final int? count;

  LeaveCountModel({this.status, this.message, this.data, this.count});

  factory LeaveCountModel.fromJson(Map<String, dynamic> json) {
    return LeaveCountModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => LeaveCountItem.fromJson(e))
                .toList()
          : null,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'count': count,
    };
  }
}

class LeaveCountItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? diplomaticTitle;
  final String? financialGrade;
  final int? annualLeave;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeaveCountItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.diplomaticTitle,
    this.financialGrade,
    this.annualLeave,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveCountItem.fromJson(Map<String, dynamic> json) {
    return LeaveCountItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      diplomaticTitle: json['diplomatic_title'] as String?,
      financialGrade: json['financial_grade'] as String?,
      annualLeave: json['annual_leave'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'diplomatic_title': diplomaticTitle,
      'financial_grade': financialGrade,
      'annual_leave': annualLeave,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
