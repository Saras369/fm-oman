class BehalfOfUserModel {
  final String? status;
  final List<BehalfOfUserItem>? data;
  final int? totalCount;

  BehalfOfUserModel({this.status, this.data, this.totalCount});

  factory BehalfOfUserModel.fromJson(Map<String, dynamic> json) {
    return BehalfOfUserModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => BehalfOfUserItem.fromJson(e as Map<String, dynamic>))
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

class BehalfOfUserItem {
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
  final int? department;
  final int? section;
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
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final int? civilEmployeeId;
  final String? qualification;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? languagePreferences;
  final String? category;
  final String? createdAt;
  final String? updatedAt;

  BehalfOfUserItem({
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
    this.faxNumber,
    this.diplomaticName,
    this.civilEmployeeId,
    this.qualification,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.languagePreferences,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory BehalfOfUserItem.fromJson(Map<String, dynamic> json) {
    return BehalfOfUserItem(
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
      mobile: json['mobile'] as String?,
      officeNumber: json['office_number'] as String?,
      department: json['department'] as int?,
      section: json['section'] as int?,
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
      extensionNumber: json['extension_number'] as int?,
      faxNumber: json['fax_number'] as String?,
      diplomaticName: json['diplomatic_name'] as String?,
      civilEmployeeId: json['civil_employee_id'] as int?,
      qualification: json['qualification'] as String?,
      fatherName: json['father_name'] as String?,
      spouseName: json['spouse_name'] as String?,
      children1Name: json['children1_name'] as String?,
      children2Name: json['children2_name'] as String?,
      languagePreferences: json['language_preferences'] as String?,
      category: json['category'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
      'department': department,
      'section': section,
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
      'fax_number': faxNumber,
      'diplomatic_name': diplomaticName,
      'civil_employee_id': civilEmployeeId,
      'qualification': qualification,
      'father_name': fatherName,
      'spouse_name': spouseName,
      'children1_name': children1Name,
      'children2_name': children2Name,
      'language_preferences': languagePreferences,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
