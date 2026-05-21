class CountryModel {
  final String? status;
  final List<CountryItem>? data;
  final int? total;

  const CountryModel({this.status, this.data, this.total});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => CountryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}

class CountryItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? countryName;
  final bool? isActive;
  final int? displayOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? countryNameArabic;
  final String? countryCode;
  final String? phoneCode;
  final String? description;

  const CountryItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.countryName,
    this.isActive,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.countryNameArabic,
    this.countryCode,
    this.phoneCode,
    this.description,
  });

  factory CountryItem.fromJson(Map<String, dynamic> json) {
    return CountryItem(
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      id: (json['id'] as num?)?.toInt(),
      countryName: json['country_name'] as String?,
      isActive: json['is_active'] as bool?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      countryNameArabic: json['country_name_arabic'] as String?,
      countryCode: json['country_code'] as String?,
      phoneCode: json['phone_code']?.toString(),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'country_name': countryName,
      'is_active': isActive,
      'display_order': displayOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_name_arabic': countryNameArabic,
      'country_code': countryCode,
      'phone_code': phoneCode,
      'description': description,
    };
  }
}
