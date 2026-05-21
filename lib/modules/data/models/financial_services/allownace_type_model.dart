class AllowanceTypeModel {
  final bool? success;
  final String? message;
  final List<AllowanceTypeItem>? data;

  AllowanceTypeModel({this.success, this.message, this.data});

  factory AllowanceTypeModel.fromJson(Map<String, dynamic> json) {
    return AllowanceTypeModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map(
                  (e) => AllowanceTypeItem.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class AllowanceTypeItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? allowanceCode;
  final String? allowanceName;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final String? description;

  AllowanceTypeItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.allowanceCode,
    this.allowanceName,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  factory AllowanceTypeItem.fromJson(Map<String, dynamic> json) {
    return AllowanceTypeItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      allowanceCode: json['allowance_code'] as String?,
      allowanceName: json['allowance_name'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'allowance_code': allowanceCode,
      'allowance_name': allowanceName,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'description': description,
    };
  }
}
