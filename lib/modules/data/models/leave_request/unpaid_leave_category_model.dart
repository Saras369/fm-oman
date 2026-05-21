class UnpaidLeaveCategoryModel {
  final String? status;
  final String? message;
  final List<UnpaidLeaveCategoryItem>? data;
  final int? totalCount;

  UnpaidLeaveCategoryModel({
    this.status,
    this.message,
    this.data,
    this.totalCount,
  });

  factory UnpaidLeaveCategoryModel.fromJson(Map<String, dynamic> json) {
    return UnpaidLeaveCategoryModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) => UnpaidLeaveCategoryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_count': totalCount,
    };
  }
}

class UnpaidLeaveCategoryItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? unpaidLeaveCategory;
  final String? createdAt;
  final String? updatedAt;

  UnpaidLeaveCategoryItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.unpaidLeaveCategory,
    this.createdAt,
    this.updatedAt,
  });

  factory UnpaidLeaveCategoryItem.fromJson(Map<String, dynamic> json) {
    return UnpaidLeaveCategoryItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      unpaidLeaveCategory: json['unpaid_leave_category'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'unpaid_leave_category': unpaidLeaveCategory,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
