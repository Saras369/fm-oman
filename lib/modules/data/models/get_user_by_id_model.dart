class GetUserByIdModel {
  final String? status;
  final UserData? data;

  GetUserByIdModel({this.status, this.data});

  factory GetUserByIdModel.fromJson(Map<String, dynamic> json) {
    return GetUserByIdModel(
      status: json['status'] as String?,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.toJson()};
  }
}

class UserData {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? employeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String? gender;
  final String? maritalStatus;
  final String? nationality;
  final String? email;
  final String? bloodGroup;
  final String? nationalId;
  final String? mobile;
  final String? officeNumber;
  final String? faxNumber;
  final String? category;
  final Department? department;
  final Section? section;
  final int? grade;
  final String? location;
  final String? country;
  final bool? isAdmin;
  final int? division;
  final int? reportingTo;
  final String? address;
  final String? residentialStatus;
  final String? religion;
  final int? designation;
  final String? avatar;
  final String? passportNumber;
  final String? personalEmail;
  final String? extensionNumber;
  final String? diplomaticName;
  final int? civilEmployeeId;
  final String? qualification;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? languagePreferences;
  final String? createdAt;
  final String? updatedAt;
  final Position? position;
  final Manager? manager;
  final EmploymentDetails? employmentDetails;
  final DiplomaticTitleDetails? diplomaticTitleDetails;

  UserData({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.employeeId,
    this.employeeName,
    this.employeeArabicName,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    this.gender,
    this.maritalStatus,
    this.nationality,
    this.email,
    this.bloodGroup,
    this.nationalId,
    this.mobile,
    this.officeNumber,
    this.faxNumber,
    this.category,
    this.department,
    this.section,
    this.grade,
    this.location,
    this.country,
    this.isAdmin,
    this.division,
    this.reportingTo,
    this.address,
    this.residentialStatus,
    this.religion,
    this.designation,
    this.avatar,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.diplomaticName,
    this.civilEmployeeId,
    this.qualification,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.languagePreferences,
    this.createdAt,
    this.updatedAt,
    this.position,
    this.manager,
    this.employmentDetails,
    this.diplomaticTitleDetails,
  });

  String? get displayPhone =>
      _firstNonEmpty([mobile, officeNumber, extensionNumber]);

  String? get displayJobTitle => _firstNonEmpty([
    employmentDetails?.jobTitle,
    position?.name,
    diplomaticTitleDetails?.title,
  ]);

  String? get displayLocation => _firstNonEmpty([location]);

  static String? _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      employeeId: json['employee_id'] as String?,
      employeeName: json['employee_name'] as String?,
      employeeArabicName: json['employee_arabic_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      regionOfBirth: json['region_of_birth'] as String?,
      countryOfBirth: json['country_of_birth'] as String?,
      dateOfJoining: json['date_of_joining'] as String?,
      lastPromotionDate: json['last_promotion_date'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,
      nationality: json['nationality'] as String?,
      email: json['email'] as String?,
      bloodGroup: json['blood_group'] as String?,
      nationalId: json['national_id'] as String?,
      mobile: json['mobile']?.toString(),
      officeNumber: json['office_number']?.toString(),
      faxNumber: json['fax_number']?.toString(),
      category: json['category'] as String?,
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      section: json['section'] != null
          ? Section.fromJson(json['section'])
          : null,
      grade: json['grade'] as int?,
      location: json['location'] as String?,
      country: json['country'] as String?,
      isAdmin: json['is_admin'] as bool?,
      division: json['division'] as int?,
      reportingTo: json['reporting_to'] as int?,
      address: json['address'] as String?,
      residentialStatus: json['residential_status'] as String?,
      religion: json['religion'] as String?,
      designation: json['designation'] as int?,
      avatar: json['avatar'] as String?,
      passportNumber: json['passport_number'] as String?,
      personalEmail: json['personal_email'] as String?,
      extensionNumber: json['extension_number'] as String?,
      diplomaticName: json['diplomatic_name'] as String?,
      civilEmployeeId: json['civil_employee_id'] as int?,
      qualification: json['qualification'] as String?,
      fatherName: json['father_name'] as String?,
      spouseName: json['spouse_name'] as String?,
      children1Name: json['children1_name'] as String?,
      children2Name: json['children2_name'] as String?,
      languagePreferences: json['language_preferences'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      position: json['position'] != null
          ? Position.fromJson(json['position'])
          : null,
      manager: json['manager'] != null
          ? Manager.fromJson(json['manager'])
          : null,
      employmentDetails: json['employment_details'] != null
          ? EmploymentDetails.fromJson(json['employment_details'])
          : null,
      diplomaticTitleDetails: json['diplomatic_title_details'] != null
          ? DiplomaticTitleDetails.fromJson(json['diplomatic_title_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'date_of_birth': dateOfBirth,
      'region_of_birth': regionOfBirth,
      'country_of_birth': countryOfBirth,
      'date_of_joining': dateOfJoining,
      'last_promotion_date': lastPromotionDate,
      'gender': gender,
      'marital_status': maritalStatus,
      'nationality': nationality,
      'email': email,
      'blood_group': bloodGroup,
      'national_id': nationalId,
      'mobile': mobile,
      'office_number': officeNumber,
      'fax_number': faxNumber,
      'category': category,
      'department': department?.toJson(),
      'section': section?.toJson(),
      'grade': grade,
      'location': location,
      'country': country,
      'is_admin': isAdmin,
      'division': division,
      'reporting_to': reportingTo,
      'address': address,
      'residential_status': residentialStatus,
      'religion': religion,
      'designation': designation,
      'avatar': avatar,
      'passport_number': passportNumber,
      'personal_email': personalEmail,
      'extension_number': extensionNumber,
      'diplomatic_name': diplomaticName,
      'civil_employee_id': civilEmployeeId,
      'qualification': qualification,
      'father_name': fatherName,
      'spouse_name': spouseName,
      'children1_name': children1Name,
      'children2_name': children2Name,
      'language_preferences': languagePreferences,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'position': position?.toJson(),
      'manager': manager?.toJson(),
      'employment_details': employmentDetails?.toJson(),
      'diplomatic_title_details': diplomaticTitleDetails?.toJson(),
    };
  }
}

class EmploymentDetails {
  final int? id;
  final int? userId;
  final String? jobTitle;

  EmploymentDetails({this.id, this.userId, this.jobTitle});

  factory EmploymentDetails.fromJson(Map<String, dynamic> json) {
    return EmploymentDetails(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      jobTitle: json['job_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'job_title': jobTitle,
  };
}

class DiplomaticTitleDetails {
  final int? id;
  final String? title;
  final String? category;

  DiplomaticTitleDetails({this.id, this.title, this.category});

  factory DiplomaticTitleDetails.fromJson(Map<String, dynamic> json) {
    return DiplomaticTitleDetails(
      id: json['id'] as int?,
      title: json['title'] as String?,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
  };
}

// Nested models

class Department {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? createdAt;
  final String? updatedAt;

  Department({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    createdBy: json['created_by'],
    updatedBy: json['updated_by'],
    id: json['id'],
    departmentName: json['department_name'],
    departmentCode: json['department_code'],
    departmentDescription: json['department_description'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
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

class Section {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final String? departmentId;
  final String? createdAt;
  final String? updatedAt;

  Section({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    createdBy: json['created_by'],
    updatedBy: json['updated_by'],
    id: json['id'],
    sectionName: json['section_name'],
    sectionCode: json['section_code'],
    sectionDescription: json['section_description'],
    departmentId: json['department_id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'section_name': sectionName,
    'section_code': sectionCode,
    'section_description': sectionDescription,
    'department_id': departmentId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Position {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Position({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    createdBy: json['created_by'],
    updatedBy: json['updated_by'],
    id: json['id'],
    name: json['name'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Manager {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? employeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? email;
  final String? gender;
  Manager({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.employeeId,
    this.employeeName,
    this.employeeArabicName,
    this.email,
    this.gender,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    createdBy: json['created_by'],
    updatedBy: json['updated_by'],
    id: json['id'],
    employeeId: json['employee_id'],
    employeeName: json['employee_name'],
    employeeArabicName: json['employee_arabic_name'],
    email: json['email'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'employee_id': employeeId,
    'employee_name': employeeName,
    'employee_arabic_name': employeeArabicName,
    'email': email,
    'gender': gender,
  };
}
