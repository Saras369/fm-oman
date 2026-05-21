// stationery_material_model.dart

class StationeryMaterialModel {
  final String? status;
  final String? message;
  final List<StationeryMaterialItem>? data;
  final int? totalCount;

  StationeryMaterialModel({
    this.status,
    this.message,
    this.data,
    this.totalCount,
  });

  factory StationeryMaterialModel.fromJson(Map<String, dynamic> json) {
    return StationeryMaterialModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => StationeryMaterialItem.fromJson(e))
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
    'total_count': totalCount,
  };
}

/// stationery_material_item.dart

class StationeryMaterialItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? materialType;
  final String? materialName;
  final bool? isActive;
  final int? displayOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? materialCode;
  final String? description;
  final String? unitOfMeasure;

  StationeryMaterialItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.materialType,
    this.materialName,
    this.isActive,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.materialCode,
    this.description,
    this.unitOfMeasure,
  });

  factory StationeryMaterialItem.fromJson(Map<String, dynamic> json) {
    return StationeryMaterialItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      materialType: json['material_type'] as String?,
      materialName: json['material_name'] as String?,
      isActive: json['is_active'] as bool?,
      displayOrder: json['display_order'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      materialCode: json['material_code'] as String?,
      description: json['description'] as String?,
      unitOfMeasure: json['unit_of_measure'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'material_type': materialType,
    'material_name': materialName,
    'is_active': isActive,
    'display_order': displayOrder,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'material_code': materialCode,
    'description': description,
    'unit_of_measure': unitOfMeasure,
  };
}
