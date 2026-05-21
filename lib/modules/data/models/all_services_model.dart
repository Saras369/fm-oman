// ========================
// All Services Main Model
// ========================
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';

class AllServicesModel {
  String? status;
  List<AllServicesData>? data;

  AllServicesModel({this.status, this.data});

  factory AllServicesModel.fromJson(Map<String, dynamic> json) {
    return AllServicesModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => AllServicesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class AllServicesData {
  List<String>? jsonIgnore;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  bool? logicalDelete;
  int? id;
  String? name;
  String? description;
  String? logoUrl;
  String? code;
  String? arabicName;
  String? arabicDescription;
  String? createdAt;
  String? updatedAt;
  List<int>? subServiceIds;
  List<SubServices>? subServices;

  AllServicesData({
    this.jsonIgnore,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.logicalDelete,
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.code,
    this.arabicName,
    this.arabicDescription,
    this.createdAt,
    this.updatedAt,
    this.subServiceIds,
    this.subServices,
  });

  factory AllServicesData.fromJson(Map<String, dynamic> json) {
    return AllServicesData(
      jsonIgnore: (json['jsonIgnore'] as List?)
          ?.map((e) => e as String)
          .toList(),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      logicalDelete: json['logicalDelete'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      arabicName: json['arabic_name'] as String?,
      arabicDescription: json['arabic_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      subServiceIds: (json['sub_service_ids'] as List?)
          ?.map((e) => e as int)
          .toList(),
      subServices: (json['sub_services'] as List?)
          ?.map((e) => SubServices.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonIgnore': jsonIgnore,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'is_deleted': isDeleted,
      'logicalDelete': logicalDelete,
      'id': id,
      'name': name,
      'description': description,
      'logo_url': logoUrl,
      'code': code,
      'arabic_name': arabicName,
      'arabic_description': arabicDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sub_service_ids': subServiceIds,
      'sub_services': subServices?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubServices {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? subServiceName;
  String? description;
  int? serviceId;
  String? arabicName;
  String? arabicDescription;
  String? logoUrl;
  String? code;
  String? createdAt;
  String? updatedAt;

  SubServices({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.arabicName,
    this.arabicDescription,
    this.logoUrl,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory SubServices.fromJson(Map<String, dynamic> json) {
    return SubServices(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      subServiceName: json['sub_service_name'] as String?,
      description: json['description'] as String?,
      serviceId: json['service_id'] as int?,
      arabicName: json['arabic_name'] as String?,
      arabicDescription: json['arabic_description'] as String?,
      logoUrl: json['logo_url'] as String?,
      code: json['code'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'sub_service_name': subServiceName,
      'description': description,
      'service_id': serviceId,
      'arabic_name': arabicName,
      'arabic_description': arabicDescription,
      'logo_url': logoUrl,
      'code': code,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// ========================
// Role Summary
// ========================
class RoleSummary {
  int? roleId;
  String? roleName;

  RoleSummary({this.roleId, this.roleName});

  factory RoleSummary.fromJson(Map<String, dynamic> json) {
    return RoleSummary(
      roleId: json['role_id'] as int?,
      roleName: json['role_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'role_id': roleId, 'role_name': roleName};
  }
}

// ========================
// Role Details
// ========================
class RoleDetails {
  int? userRoleId;
  bool? isActive;
  Role? role;
  Department? department;
  Section? section;
  List<AllServicesItem>? services;

  RoleDetails({
    this.userRoleId,
    this.isActive,
    this.role,
    this.department,
    this.section,
    this.services,
  });

  factory RoleDetails.fromJson(Map<String, dynamic> json) {
    return RoleDetails(
      userRoleId: json['user_role_id'] as int?,
      isActive: json['is_active'] as bool?,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      section: json['section'] != null
          ? Section.fromJson(json['section'])
          : null,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => AllServicesItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_role_id': userRoleId,
      'is_active': isActive,
      'role': role?.toJson(),
      'department': department?.toJson(),
      'section': section?.toJson(),
      'services': services?.map((e) => e.toJson()).toList(),
    };
  }
}

// ========================
// Role Object
// ========================
class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// ========================
// Department Object
// ========================
class Department {
  int? id;
  String? departmentName;

  Department({this.id, this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'department_name': departmentName};
  }
}

// ========================
// Section Object
// ========================
class Section {
  int? id;
  String? sectionName;

  Section({this.id, this.sectionName});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as int?,
      sectionName: json['section_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'section_name': sectionName};
  }
}

// ========================
// MAIN CLASS REQUESTED BY YOU
// AllServicesItem (Each Service)
// ========================
class AllServicesItem {
  int? id;
  String? code;
  String? name;
  String? description;
  String? logoUrl;
  List<SubServices>? subservices;

  AllServicesItem({
    this.id,
    this.code,
    this.name,
    this.description,
    this.logoUrl,
    this.subservices,
  });

  factory AllServicesItem.fromJson(Map<String, dynamic> json) {
    return AllServicesItem(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      logoUrl: json['logo_url'] as String?,
      subservices: (json['subservices'] as List<dynamic>?)
          ?.map((e) => SubServices.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'logo_url': logoUrl,
      'subservices': subservices?.map((e) => e.toJson()).toList(),
    };
  }
}
