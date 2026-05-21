class StationeryOfficeModel {
  final bool? status;
  final String? message;
  final List<StationeryOfficeItem>? data;
  final int? totalCount;

  StationeryOfficeModel({
    this.status,
    this.message,
    this.data,
    this.totalCount,
  });

  factory StationeryOfficeModel.fromJson(Map<String, dynamic> json) {
    return StationeryOfficeModel(
      status: json['status'],
      message: json['message'],
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StationeryOfficeItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'total_count': totalCount,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class StationeryOfficeItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? officeName;
  final bool? isActive;
  final int? displayOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? officeNameArabic;
  final String? officeCode;
  final String? description;
  final String? location;
  final String? address;

  StationeryOfficeItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.officeName,
    this.isActive,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.officeNameArabic,
    this.officeCode,
    this.description,
    this.location,
    this.address,
  });

  factory StationeryOfficeItem.fromJson(Map<String, dynamic> json) {
    return StationeryOfficeItem(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      officeName: json['office_name'],
      isActive: json['is_active'],
      displayOrder: json['display_order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      officeNameArabic: json['office_name_arabic'],
      officeCode: json['office_code'],
      description: json['description'],
      location: json['location'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'office_name': officeName,
      'is_active': isActive,
      'display_order': displayOrder,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'office_name_arabic': officeNameArabic,
      'office_code': officeCode,
      'description': description,
      'location': location,
      'address': address,
    };
  }
}
