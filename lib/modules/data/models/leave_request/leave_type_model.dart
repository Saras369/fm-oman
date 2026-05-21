class LeaveTypeModel {
  final String? status;
  final String? message;
  final List<LeaveTypeItem>? data;
  final int? count;

  LeaveTypeModel({this.status, this.message, this.data, this.count});

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => LeaveTypeItem.fromJson(e))
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

class LeaveTypeItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final bool? omaniOnly;
  final bool? nonOmaniMuslim;
  final bool? nonOmaniNonMuslim;
  final String? name;
  final String? nameInArabic;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeaveTypeItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.omaniOnly,
    this.nonOmaniMuslim,
    this.nonOmaniNonMuslim,
    this.name,
    this.nameInArabic,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveTypeItem.fromJson(Map<String, dynamic> json) {
    return LeaveTypeItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      omaniOnly: json['omani_only'] as bool?,
      nonOmaniMuslim: json['non_omani_muslim'] as bool?,
      nonOmaniNonMuslim: json['non_omani_non_muslim'] as bool?,
      name: json['name'] as String?,
      nameInArabic: json['name_in_arabic'] as String?,
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
      'omani_only': omaniOnly,
      'non_omani_muslim': nonOmaniMuslim,
      'non_omani_non_muslim': nonOmaniNonMuslim,
      'name': name,
      'name_in_arabic': nameInArabic,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
