class HolidayModel {
  final String? status;
  final List<Holiday>? data;

  HolidayModel({this.status, this.data});

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      status: json['status'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => Holiday.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Holiday {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? title;
  final String? holidayDate;
  final String? description;
  final String? region;
  final bool? isOptional;
  final String? holidayType;
  final int? year;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Holiday({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.title,
    this.holidayDate,
    this.description,
    this.region,
    this.isOptional,
    this.holidayType,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      holidayDate: json['holiday_date'] as String?,
      description: json['description'] as String?,
      region: json['region'] as String?,
      isOptional: json['is_optional'] as bool?,
      holidayType: json['holiday_type'] as String?,
      year: json['year'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'title': title,
    'holiday_date': holidayDate,
    'description': description,
    'region': region,
    'is_optional': isOptional,
    'holiday_type': holidayType,
    'year': year,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
