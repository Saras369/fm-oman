import 'package:code_setup/modules/data/models/all_services_model.dart';

/// Top-level model
class AttendanceRequestModel {
  String? status;
  List<AttendanceRequestItem>? data;
  int? totalCount;

  AttendanceRequestModel({this.status, this.data, this.totalCount});

  factory AttendanceRequestModel.fromJson(Map<String, dynamic> json) =>
      AttendanceRequestModel(
        status: json['status'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map(
              (e) => AttendanceRequestItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        totalCount: json['total_count'] is int
            ? json['total_count'] as int
            : (json['total_count'] != null
                  ? int.tryParse('${json['total_count']}')
                  : null),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((e) => e.toJson()).toList(),
    'total_count': totalCount,
  };
}

/// Each attendance request item
class AttendanceRequestItem {
  String? createdBy;
  String? updatedBy;
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? reqUserDepartmentId;
  int? reqUserSectionId;
  int? serviceId;
  int? subServiceId;
  int? userId;
  String?
  fromDate; // "2025-11-21" kept as String (date-only); change to DateTime? if you prefer
  String? toDate;
  String? fromTime; // "08:00:00"
  String? toTime;
  String? reason;
  String? comments;
  String? status;
  String? workflowExecutionId;

  CreatedByUser? createdByUser;
  ReqDepartment? reqDepartment;
  ReqSection? reqSection;
  Service? service;
  SubServices? subService;

  List<ChatMessage>? chatMessages;
  List<WorkflowLog>? workflowLogs;
  List<ApprovalDetail>? approvalDetails;

  AttendanceRequestItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.reason,
    this.comments,
    this.status,
    this.workflowExecutionId,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.service,
    this.subService,
    this.chatMessages,
    this.workflowLogs,
    this.approvalDetails,
  });

  factory AttendanceRequestItem.fromJson(Map<String, dynamic> json) =>
      AttendanceRequestItem(
        createdBy: json['created_by'] as String?,
        updatedBy: json['updated_by'] as String?,
        id: json['id'] is int
            ? json['id'] as int
            : (json['id'] != null ? int.tryParse('${json['id']}') : null),
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'] as String)
            : null,
        reqUserDepartmentId: json['req_user_department_id'] is int
            ? json['req_user_department_id'] as int
            : (json['req_user_department_id'] != null
                  ? int.tryParse('${json['req_user_department_id']}')
                  : null),
        reqUserSectionId: json['req_user_section_id'] is int
            ? json['req_user_section_id'] as int
            : (json['req_user_section_id'] != null
                  ? int.tryParse('${json['req_user_section_id']}')
                  : null),
        serviceId: json['service_id'] is int
            ? json['service_id'] as int
            : (json['service_id'] != null
                  ? int.tryParse('${json['service_id']}')
                  : null),
        subServiceId: json['sub_service_id'] is int
            ? json['sub_service_id'] as int
            : (json['sub_service_id'] != null
                  ? int.tryParse('${json['sub_service_id']}')
                  : null),
        userId: json['user_id'] is int
            ? json['user_id'] as int
            : (json['user_id'] != null
                  ? int.tryParse('${json['user_id']}')
                  : null),
        fromDate: json['from_date'] as String?,
        toDate: json['to_date'] as String?,
        fromTime: json['from_time'] as String?,
        toTime: json['to_time'] as String?,
        reason: json['reason'] as String?,
        comments: json['comments'] as String?,
        status: json['status'] as String?,
        workflowExecutionId: json['workflow_execution_id'] as String?,
        createdByUser: json['created_by_user'] == null
            ? null
            : CreatedByUser.fromJson(
                json['created_by_user'] as Map<String, dynamic>,
              ),
        reqDepartment: json['req_department'] == null
            ? null
            : ReqDepartment.fromJson(
                json['req_department'] as Map<String, dynamic>,
              ),
        reqSection: json['req_section'] == null
            ? null
            : ReqSection.fromJson(json['req_section'] as Map<String, dynamic>),
        service: json['service'] == null
            ? null
            : Service.fromJson(json['service'] as Map<String, dynamic>),
        subService: json['sub_service'] == null
            ? null
            : SubServices.fromJson(json['sub_service'] as Map<String, dynamic>),
        chatMessages: (json['chat_messages'] as List<dynamic>?)
            ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
        workflowLogs: (json['workflow_logs'] as List<dynamic>?)
            ?.map((e) => WorkflowLog.fromJson(e as Map<String, dynamic>))
            .toList(),
        approvalDetails: (json['approval_details'] as List<dynamic>?)
            ?.map((e) => ApprovalDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'req_user_department_id': reqUserDepartmentId,
    'req_user_section_id': reqUserSectionId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'user_id': userId,
    'from_date': fromDate,
    'to_date': toDate,
    'from_time': fromTime,
    'to_time': toTime,
    'reason': reason,
    'comments': comments,
    'status': status,
    'workflow_execution_id': workflowExecutionId,
    'created_by_user': createdByUser?.toJson(),
    'req_department': reqDepartment?.toJson(),
    'req_section': reqSection?.toJson(),
    'service': service?.toJson(),
    'sub_service': subService?.toJson(),
    'chat_messages': chatMessages?.map((e) => e.toJson()).toList(),
    'workflow_logs': workflowLogs?.map((e) => e.toJson()).toList(),
    'approval_details': approvalDetails?.map((e) => e.toJson()).toList(),
  };
}

/// CreatedByUser (nested)
class CreatedByUser {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? employeeId;
  String? employeeName;
  String? employeeArabicName;
  String? dateOfBirth;
  String? regionOfBirth;
  String? countryOfBirth;
  String? dateOfJoining;
  String? lastPromotionDate;
  String? gender;
  String? maritalStatus;
  String? nationality;
  String? email;
  String? bloodGroup;
  String? nationalId;
  String? mobile;
  String? officeNumber;
  int? department;
  int? section;
  int? grade;
  String? location;
  String? country;
  bool? isAdmin;
  int? division;
  int? reportingTo;
  String? address;
  String? residentialStatus;
  String? religion;
  Designation? designation;
  String? avatar;
  String? passportNumber;
  String? personalEmail;
  String? extensionNumber;
  String? faxNumber;
  String? diplomaticName;
  int? civilEmployeeId;
  String? qualification;
  String? fatherName;
  String? spouseName;
  String? children1Name;
  String? children2Name;
  String? languagePreferences;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreatedByUser({
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

  factory CreatedByUser.fromJson(Map<String, dynamic> json) => CreatedByUser(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
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
    department: json['department'] is int
        ? json['department'] as int
        : (json['department'] != null
              ? int.tryParse('${json['department']}')
              : null),
    section: json['section'] is int
        ? json['section'] as int
        : (json['section'] != null ? int.tryParse('${json['section']}') : null),
    grade: json['grade'] is int
        ? json['grade'] as int
        : (json['grade'] != null ? int.tryParse('${json['grade']}') : null),
    location: json['location'] as String?,
    country: json['country'] as String?,
    isAdmin: json['is_admin'] as bool?,
    division: json['division'] is int
        ? json['division'] as int
        : (json['division'] != null
              ? int.tryParse('${json['division']}')
              : null),
    reportingTo: json['reporting_to'] is int
        ? json['reporting_to'] as int
        : (json['reporting_to'] != null
              ? int.tryParse('${json['reporting_to']}')
              : null),
    address: json['address'] as String?,
    residentialStatus: json['residential_status'] as String?,
    religion: json['religion'] as String?,
    designation: json['designation'] == null
        ? null
        : Designation.fromJson(json['designation'] as Map<String, dynamic>),
    avatar: json['avatar'] as String?,
    passportNumber: json['passport_number'] as String?,
    personalEmail: json['personal_email'] as String?,
    extensionNumber: json['extension_number'] as String?,
    faxNumber: json['fax_number'] as String?,
    diplomaticName: json['diplomatic_name'] as String?,
    civilEmployeeId: json['civil_employee_id'] is int
        ? json['civil_employee_id'] as int
        : (json['civil_employee_id'] != null
              ? int.tryParse('${json['civil_employee_id']}')
              : null),
    qualification: json['qualification'] as String?,
    fatherName: json['father_name'] as String?,
    spouseName: json['spouse_name'] as String?,
    children1Name: json['children1_name'] as String?,
    children2Name: json['children2_name'] as String?,
    languagePreferences: json['language_preferences'] as String?,
    category: json['category'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
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
    'designation': designation?.toJson(),
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
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class Designation {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Designation({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    name: json['name'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'name': name,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ReqDepartment {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? departmentName;
  String? departmentCode;
  String? departmentDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReqDepartment({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory ReqDepartment.fromJson(Map<String, dynamic> json) => ReqDepartment(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    departmentName: json['department_name'] as String?,
    departmentCode: json['department_code'] as String?,
    departmentDescription: json['department_description'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'department_name': departmentName,
    'department_code': departmentCode,
    'department_description': departmentDescription,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ReqSection {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? sectionName;
  String? sectionCode;
  String? sectionDescription;
  String? departmentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReqSection({
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

  factory ReqSection.fromJson(Map<String, dynamic> json) => ReqSection(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    sectionName: json['section_name'] as String?,
    sectionCode: json['section_code'] as String?,
    sectionDescription: json['section_description'] as String?,
    departmentId: json['department_id']?.toString(),
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'section_name': sectionName,
    'section_code': sectionCode,
    'section_description': sectionDescription,
    'department_id': departmentId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class Service {
  String? createdBy;
  String? updatedBy;
  int? id;
  String? name;
  String? description;
  String? logoUrl;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.description,
    this.logoUrl,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    name: json['name'] as String?,
    description: json['description'] as String?,
    logoUrl: json['logo_url'] as String?,
    code: json['code'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'name': name,
    'description': description,
    'logo_url': logoUrl,
    'code': code,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ChatMessage {
  // Your sample had empty array; keep minimal fields or adapt as needed
  ChatMessage();

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage();

  Map<String, dynamic> toJson() => {};
}

class WorkflowLog {
  String? createdBy;
  String? updatedBy;
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  String? content;
  String? status;

  WorkflowLog({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.content,
    this.status,
  });

  factory WorkflowLog.fromJson(Map<String, dynamic> json) => WorkflowLog(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
    requestId: json['request_id'] is int
        ? json['request_id'] as int
        : (json['request_id'] != null
              ? int.tryParse('${json['request_id']}')
              : null),
    serviceId: json['service_id'] is int
        ? json['service_id'] as int
        : (json['service_id'] != null
              ? int.tryParse('${json['service_id']}')
              : null),
    subServiceId: json['sub_service_id'] is int
        ? json['sub_service_id'] as int
        : (json['sub_service_id'] != null
              ? int.tryParse('${json['sub_service_id']}')
              : null),
    content: json['content'] as String?,
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'content': content,
    'status': status,
  };
}

class ApprovalDetail {
  String? createdBy;
  String? updatedBy;
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? requestId;
  int? serviceId;
  int? subServiceId;
  int? level;
  int? approverRoleId;
  int? departmentId;
  int? sectionId;
  int? approverUserId;
  int? delegateUserId;
  String? approvedBy;
  String? comment;
  String? approvalStatus;

  ApprovalDetail({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.level,
    this.approverRoleId,
    this.departmentId,
    this.sectionId,
    this.approverUserId,
    this.delegateUserId,
    this.approvedBy,
    this.comment,
    this.approvalStatus,
  });

  factory ApprovalDetail.fromJson(Map<String, dynamic> json) => ApprovalDetail(
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    id: json['id'] is int
        ? json['id'] as int
        : (json['id'] != null ? int.tryParse('${json['id']}') : null),
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
    requestId: json['request_id'] is int
        ? json['request_id'] as int
        : (json['request_id'] != null
              ? int.tryParse('${json['request_id']}')
              : null),
    serviceId: json['service_id'] is int
        ? json['service_id'] as int
        : (json['service_id'] != null
              ? int.tryParse('${json['service_id']}')
              : null),
    subServiceId: json['sub_service_id'] is int
        ? json['sub_service_id'] as int
        : (json['sub_service_id'] != null
              ? int.tryParse('${json['sub_service_id']}')
              : null),
    level: json['level'] is int
        ? json['level'] as int
        : (json['level'] != null ? int.tryParse('${json['level']}') : null),
    approverRoleId: json['approver_role_id'] is int
        ? json['approver_role_id'] as int
        : (json['approver_role_id'] != null
              ? int.tryParse('${json['approver_role_id']}')
              : null),
    departmentId: json['department_id'] is int
        ? json['department_id'] as int
        : (json['department_id'] != null
              ? int.tryParse('${json['department_id']}')
              : null),
    sectionId: json['section_id'] is int
        ? json['section_id'] as int
        : (json['section_id'] != null
              ? int.tryParse('${json['section_id']}')
              : null),
    approverUserId: json['approver_user_id'] is int
        ? json['approver_user_id'] as int
        : (json['approver_user_id'] != null
              ? int.tryParse('${json['approver_user_id']}')
              : null),
    delegateUserId: json['delegate_user_id'] is int
        ? json['delegate_user_id'] as int
        : (json['delegate_user_id'] != null
              ? int.tryParse('${json['delegate_user_id']}')
              : null),
    approvedBy: json['approved_by'] as String?,
    comment: json['comment'] as String?,
    approvalStatus: json['approval_status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'level': level,
    'approver_role_id': approverRoleId,
    'department_id': departmentId,
    'section_id': sectionId,
    'approver_user_id': approverUserId,
    'delegate_user_id': delegateUserId,
    'approved_by': approvedBy,
    'comment': comment,
    'approval_status': approvalStatus,
  };
}
