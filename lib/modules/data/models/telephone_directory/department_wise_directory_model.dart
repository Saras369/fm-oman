class DepartmentWiseDirectoryModel {
  final String? status;
  final DepartmentCategoryItem? data;
  final Map<String, int>? totalCount; // e.g. { "FM": 14, "Embassy": 14 }

  DepartmentWiseDirectoryModel({this.status, this.data, this.totalCount});

  factory DepartmentWiseDirectoryModel.fromJson(Map<String, dynamic> json) {
    return DepartmentWiseDirectoryModel(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : DepartmentCategoryItem.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      totalCount: (json['total_count'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as int),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
      'total_count': totalCount,
    };
  }
}

class DepartmentCategoryItem {
  final List<DepartmentItem>? fm;
  final List<DepartmentItem>? embassy;

  DepartmentCategoryItem({this.fm, this.embassy});

  factory DepartmentCategoryItem.fromJson(Map<String, dynamic> json) {
    return DepartmentCategoryItem(
      fm: (json['FM'] as List?)
          ?.map((e) => DepartmentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      embassy: (json['Embassy'] as List?)
          ?.map((e) => DepartmentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FM': fm?.map((e) => e.toJson()).toList(),
      'Embassy': embassy?.map((e) => e.toJson()).toList(),
    };
  }
}

class DepartmentItem {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final String? createdAt;
  final String? updatedAt;
  final int? count;
  final String? category;

  DepartmentItem({
    this.id,
    this.name,
    this.description,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.count,
    this.category,
  });

  factory DepartmentItem.fromJson(Map<String, dynamic> json) {
    return DepartmentItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      count: json['count'] as int?,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'code': code,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'count': count,
      'category': category,
    };
  }
}
