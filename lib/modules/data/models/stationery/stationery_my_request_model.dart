// stationery_my_requests_model.dart
class StationeryMyRequestsModel {
  final String? status;
  final List<StationeryMyRequestItem>? data;
  final int? totalCount;

  StationeryMyRequestsModel({this.status, this.data, this.totalCount});

  factory StationeryMyRequestsModel.fromJson(Map<String, dynamic> json) {
    return StationeryMyRequestsModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) => StationeryMyRequestItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((e) => e.toJson()).toList(),
    'total_count': totalCount,
  };
}

// stationery_my_request_item.dart
class StationeryMyRequestItem {
  final int? id;
  final int? reqUserDepartmentId;
  final int? reqUserSectionId;
  final int? serviceId;
  final int? subServiceId;
  final int? userId;

  final String? dateOfRequestPreparation;
  final String? office;
  final String? materialType;
  final String? materialName;

  final int? quantityRequired;
  final String? comments;
  final String? status;

  final String? workflowExecutionId;
  final bool? stockAvailable;
  final String? poNumber;
  final String? stockAvailableDate;

  final String? createdAt;
  final String? updatedAt;

  final SubServiceInfo? subService; // <- newly added

  StationeryMyRequestItem({
    this.id,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.dateOfRequestPreparation,
    this.office,
    this.materialType,
    this.materialName,
    this.quantityRequired,
    this.comments,
    this.status,
    this.workflowExecutionId,
    this.stockAvailable,
    this.poNumber,
    this.stockAvailableDate,
    this.createdAt,
    this.updatedAt,
    this.subService,
  });

  factory StationeryMyRequestItem.fromJson(Map<String, dynamic> json) {
    return StationeryMyRequestItem(
      id: json['id'] as int?,
      reqUserDepartmentId: json['req_user_department_id'] as int?,
      reqUserSectionId: json['req_user_section_id'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      userId: json['user_id'] as int?,
      dateOfRequestPreparation: json['date_of_request_preparation'] as String?,
      office: json['office'] as String?,
      materialType: json['material_type'] as String?,
      materialName: json['material_name'] as String?,
      quantityRequired: json['quantity_required'] as int?,
      comments: json['comments'] as String?,
      status: json['status'] as String?,
      workflowExecutionId: json['workflow_execution_id'] as String?,
      stockAvailable: json['stock_available'] as bool?,
      poNumber: json['po_number'] as String?,
      stockAvailableDate: json['stock_available_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      subService: json['sub_service'] == null
          ? null
          : SubServiceInfo.fromJson(
              json['sub_service'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'req_user_department_id': reqUserDepartmentId,
    'req_user_section_id': reqUserSectionId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'user_id': userId,
    'date_of_request_preparation': dateOfRequestPreparation,
    'office': office,
    'material_type': materialType,
    'material_name': materialName,
    'quantity_required': quantityRequired,
    'comments': comments,
    'status': status,
    'workflow_execution_id': workflowExecutionId,
    'stock_available': stockAvailable,
    'po_number': poNumber,
    'stock_available_date': stockAvailableDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'sub_service': subService?.toJson(),
  };
}

/// Minimal model for `sub_service` (nullable)
class SubServiceInfo {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;
  final String? createdAt;
  final String? updatedAt;

  SubServiceInfo({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.logoUrl,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory SubServiceInfo.fromJson(Map<String, dynamic> json) {
    return SubServiceInfo(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      subServiceName: json['sub_service_name'] as String?,
      description: json['description'] as String?,
      serviceId: json['service_id'] as int?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'sub_service_name': subServiceName,
    'description': description,
    'service_id': serviceId,
    'logo_url': logoUrl,
    'code': code,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
