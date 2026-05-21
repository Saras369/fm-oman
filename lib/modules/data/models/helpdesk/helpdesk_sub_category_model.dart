class HelpdeskSubCategoryModel {
  final bool? success;
  final String? message;
  final List<HelpDeskSubCategoryItem>? data;

  HelpdeskSubCategoryModel({this.success, this.message, this.data});

  factory HelpdeskSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return HelpdeskSubCategoryModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) => HelpDeskSubCategoryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
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

class HelpDeskSubCategoryItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final int? categoryId;
  final String? description;
  final String? code;
  final bool? isActive;
  final int? priority;
  final String? createdAt;
  final String? updatedAt;

  HelpDeskSubCategoryItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.categoryId,
    this.description,
    this.code,
    this.isActive,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  factory HelpDeskSubCategoryItem.fromJson(Map<String, dynamic> json) {
    return HelpDeskSubCategoryItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by']
          ?.toString(), // safe cast for null/int/string
      id: json['id'] as int?,
      name: json['name'] as String?,
      categoryId: json['category_id'] as int?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      isActive: json['is_active'] as bool?,
      priority: json['priority'] as int?,
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
      'category_id': categoryId,
      'description': description,
      'code': code,
      'is_active': isActive,
      'priority': priority,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
