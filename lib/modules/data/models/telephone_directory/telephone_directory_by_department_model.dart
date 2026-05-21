// telephone_directory_by_department_model.dart

class TelephoneDirectoryByDepartmentModel {
  final String? status;
  final List<TelephoneDirectoryItem>? data;
  final int? totalCount;

  TelephoneDirectoryByDepartmentModel({
    this.status,
    this.data,
    this.totalCount,
  });

  factory TelephoneDirectoryByDepartmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TelephoneDirectoryByDepartmentModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) => TelephoneDirectoryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      totalCount: json['total_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'total_count': totalCount,
    };
  }
}

// telephone_directory_item.dart

class TelephoneDirectoryItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? category;
  final String? name;
  final String? position;
  final String? diplomaticTitle;
  final String? embassyName;
  final String? email;
  final String? contactNumber;
  final String? extensionNumber;
  final String? location;
  final int? departmentId;
  final int? employeeId;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final String? photoUrl;
  final String? createdAt;
  final String? updatedAt;
  final TelephoneDepartmentInfo? department;
  final TelephoneEmployeeInfo? employee;

  TelephoneDirectoryItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.category,
    this.name,
    this.position,
    this.diplomaticTitle,
    this.embassyName,
    this.email,
    this.contactNumber,
    this.extensionNumber,
    this.location,
    this.departmentId,
    this.employeeId,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
    this.department,
    this.employee,
  });

  factory TelephoneDirectoryItem.fromJson(Map<String, dynamic> json) {
    return TelephoneDirectoryItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by']?.toString(),
      id: json['id'] as int?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      diplomaticTitle: json['diplomatic_title'] as String?,
      embassyName: json['embassy_name'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      extensionNumber: json['extension_number'] as String?,
      location: json['location'] as String?,
      departmentId: json['department_id'] as int?,
      employeeId: json['employee_id'] == null
          ? null
          : (json['employee_id'] is int
                ? json['employee_id'] as int
                : int.tryParse(json['employee_id'].toString())),
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      country: json['country'] as String?,
      photoUrl: json['photo_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      department: json['department'] == null
          ? null
          : TelephoneDepartmentInfo.fromJson(
              json['department'] as Map<String, dynamic>,
            ),
      employee: json['employee'] == null
          ? null
          : TelephoneEmployeeInfo.fromJson(
              json['employee'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'category': category,
      'name': name,
      'position': position,
      'diplomatic_title': diplomaticTitle,
      'embassy_name': embassyName,
      'email': email,
      'contact_number': contactNumber,
      'extension_number': extensionNumber,
      'location': location,
      'department_id': departmentId,
      'employee_id': employeeId,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'country': country,
      'photo_url': photoUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'department': department?.toJson(),
      'employee': employee?.toJson(),
    };
  }
}

/// Minimal department nested model
class TelephoneDepartmentInfo {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  TelephoneDepartmentInfo({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory TelephoneDepartmentInfo.fromJson(Map<String, dynamic> json) {
    return TelephoneDepartmentInfo(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by']?.toString(),
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCode: json['department_code'] as String?,
      departmentDescription: json['department_description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'department_name': departmentName,
      'department_code': departmentCode,
      'department_description': departmentDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

/// Minimal employee nested model (nullable)
class TelephoneEmployeeInfo {
  final int? id;
  final String? employeeId;
  final String? employeeName;
  // add more fields if your employee object contains them

  TelephoneEmployeeInfo({this.id, this.employeeId, this.employeeName});

  factory TelephoneEmployeeInfo.fromJson(Map<String, dynamic> json) {
    return TelephoneEmployeeInfo(
      id: json['id'] as int?,
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'employee_id': employeeId, 'employee_name': employeeName};
  }
}
