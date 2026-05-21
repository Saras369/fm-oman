import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';

class MyLeaveRequestsModel {
  final String? status;
  final List<MyLeaveRequestItem>? data;

  MyLeaveRequestsModel({this.status, this.data});

  factory MyLeaveRequestsModel.fromJson(Map<String, dynamic> json) {
    return MyLeaveRequestsModel(
      status: json['status'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map(
                  (e) => MyLeaveRequestItem.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class MyLeaveRequestItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? userId;
  final String? leaveFor;
  final LeaveTypeItem? leaveType;
  final int? studyLeaveDegree;
  final String? department;
  final String? status;
  final String? leaveStartDate;
  final String? leaveEndDate;
  final int? leaveDuration;
  final int? remainingLeaveBalance;
  final String? contactNumberDuringLeave;
  final String? addressDuringLeave;
  final String? notes;
  final String? delegatedTo;
  final int? numberOfEscortInstancesPerYear;
  final bool? accompanyingThePatient;
  final String? treatmentPlace;
  final int? emergencyLeavesAvailable;
  final String? unpaidLeaveType;
  final String? countryOrStateBeingVisited;
  final String? leaveBalanceSummary;
  final String? representation;
  final String? activityTitle;
  final String? relationship;
  final int? mounringLeaveRelation;
  final int? serviceId;
  final int? subServiceId;
  final String? workflowExecutionId;
  final String? createdAt;
  final String? updatedAt;
  final LeaveUser? user;
  final List<ApprovalDetail>? approvalDetails;

  MyLeaveRequestItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.userId,
    this.leaveFor,
    this.leaveType,
    this.studyLeaveDegree,
    this.department,
    this.status,
    this.leaveStartDate,
    this.leaveEndDate,
    this.leaveDuration,
    this.remainingLeaveBalance,
    this.contactNumberDuringLeave,
    this.addressDuringLeave,
    this.notes,
    this.delegatedTo,
    this.numberOfEscortInstancesPerYear,
    this.accompanyingThePatient,
    this.treatmentPlace,
    this.emergencyLeavesAvailable,
    this.unpaidLeaveType,
    this.countryOrStateBeingVisited,
    this.leaveBalanceSummary,
    this.representation,
    this.activityTitle,
    this.relationship,
    this.mounringLeaveRelation,
    this.serviceId,
    this.subServiceId,
    this.workflowExecutionId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.approvalDetails,
  });

  factory MyLeaveRequestItem.fromJson(Map<String, dynamic> json) {
    return MyLeaveRequestItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      leaveFor: json['leave_for'] as String?,
      leaveType:
          json['leave_type'] != null &&
              json['leave_type'] is Map<String, dynamic>
          ? LeaveTypeItem.fromJson(json['leave_type'])
          : null,
      studyLeaveDegree: json['study_leave_degree'] as int?,
      department: json['department'] as String?,
      status: json['status'] as String?,
      leaveStartDate: json['leave_start_date'] as String?,
      leaveEndDate: json['leave_end_date'] as String?,
      leaveDuration: json['leave_duration'] as int?,
      remainingLeaveBalance: json['remaining_leave_balance'] as int?,
      contactNumberDuringLeave: json['contact_number_during_leave'] as String?,
      addressDuringLeave: json['address_during_leave'] as String?,
      notes: json['notes'] as String?,
      delegatedTo: json['delegated_to'] as String?,
      numberOfEscortInstancesPerYear:
          json['number_of_escort_instances_per_year'] as int?,
      accompanyingThePatient: json['accompanying_the_patient'] as bool?,
      treatmentPlace: json['treatment_place'] as String?,
      emergencyLeavesAvailable: json['emergency_leaves_available'] as int?,
      unpaidLeaveType: json['unpaid_leave_type'] as String?,
      countryOrStateBeingVisited:
          json['country_or_state_being_visited'] as String?,
      leaveBalanceSummary: json['leave_balance_summary'] as String?,
      representation: json['representation'] as String?,
      activityTitle: json['activity_title'] as String?,
      relationship: json['relationship'] as String?,
      mounringLeaveRelation: json['mounring_leave_relation'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      workflowExecutionId: json['workflow_execution_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? LeaveUser.fromJson(json['user'])
          : null,
      approvalDetails: json['approval_details'] != null
          ? (json['approval_details'] as List)
                .map((e) => ApprovalDetail.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'user_id': userId,
      'leave_for': leaveFor,
      'leave_type': leaveType,
      'study_leave_degree': studyLeaveDegree,
      'department': department,
      'status': status,
      'leave_start_date': leaveStartDate,
      'leave_end_date': leaveEndDate,
      'leave_duration': leaveDuration,
      'remaining_leave_balance': remainingLeaveBalance,
      'contact_number_during_leave': contactNumberDuringLeave,
      'address_during_leave': addressDuringLeave,
      'notes': notes,
      'delegated_to': delegatedTo,
      'number_of_escort_instances_per_year': numberOfEscortInstancesPerYear,
      'accompanying_the_patient': accompanyingThePatient,
      'treatment_place': treatmentPlace,
      'emergency_leaves_available': emergencyLeavesAvailable,
      'unpaid_leave_type': unpaidLeaveType,
      'country_or_state_being_visited': countryOrStateBeingVisited,
      'leave_balance_summary': leaveBalanceSummary,
      'representation': representation,
      'activity_title': activityTitle,
      'relationship': relationship,
      'mounring_leave_relation': mounringLeaveRelation,
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'workflow_execution_id': workflowExecutionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
      'approval_details': approvalDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class LeaveUser {
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
  final String? extensionNumber;
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

  LeaveUser({
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

  factory LeaveUser.fromJson(Map<String, dynamic> json) {
    return LeaveUser(
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
      extensionNumber: json['extension_number'] as String?,
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

class ApprovalDetail {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final int? leaveRequestId;
  final int? approverUserId;
  final int? approverRoleId;
  final int? departmentId;
  final int? sectionId;
  final String? comment;
  final String? approvalStatus;
  final int? level;
  final String? createdAt;
  final String? updatedAt;
  final int? delegateUserId;
  final int? approvedBy;

  ApprovalDetail({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.leaveRequestId,
    this.approverUserId,
    this.approverRoleId,
    this.departmentId,
    this.sectionId,
    this.comment,
    this.approvalStatus,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.delegateUserId,
    this.approvedBy,
  });

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) {
    return ApprovalDetail(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      leaveRequestId: json['leave_request_id'] as int?,
      approverUserId: json['approver_user_id'] as int?,
      approverRoleId: json['approver_role_id'] as int?,
      departmentId: json['department_id'] as int?,
      sectionId: json['section_id'] as int?,
      comment: json['comment'] as String?,
      approvalStatus: json['approval_status'] as String?,
      level: json['level'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      delegateUserId: json['delegate_user_id'] as int?,
      approvedBy: json['approved_by'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'leave_request_id': leaveRequestId,
      'approver_user_id': approverUserId,
      'approver_role_id': approverRoleId,
      'department_id': departmentId,
      'section_id': sectionId,
      'comment': comment,
      'approval_status': approvalStatus,
      'level': level,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'delegate_user_id': delegateUserId,
      'approved_by': approvedBy,
    };
  }
}
