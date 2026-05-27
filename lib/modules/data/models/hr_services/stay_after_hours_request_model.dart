import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';

class StayAfterHoursRequestModel {
  final bool? success;
  final String? message;
  final List<StayAfterHoursRequestItem>? data;

  StayAfterHoursRequestModel({this.success, this.message, this.data});

  factory StayAfterHoursRequestModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return StayAfterHoursRequestModel(
      success: json['success'] as bool?,
      message: readJsonString(json['message']),
      data: rawData is List
          ? rawData
                .map(
                  (e) => StayAfterHoursRequestItem.fromJson(
                    Map<String, dynamic>.from(e as Map),
                  ),
                )
                .toList()
          : [],
    );
  }
}

class StayAfterHoursRequestItem {
  final int? id;
  final int? serviceId;
  final int? subServiceId;
  final String? requestName;
  final String? requestStatus;
  final String? requestDate;
  final String? permitNumber;
  final String? jobNumber;
  final String? dateFrom;
  final String? dateTo;
  final String? durationFrom;
  final String? durationTo;
  final String? assignedTo;

  StayAfterHoursRequestItem({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.requestName,
    this.requestStatus,
    this.requestDate,
    this.permitNumber,
    this.jobNumber,
    this.dateFrom,
    this.dateTo,
    this.durationFrom,
    this.durationTo,
    this.assignedTo,
  });

  factory StayAfterHoursRequestItem.fromJson(Map<String, dynamic> json) {
    final subService =
        readJsonMap(json['sub_service']) ?? readJsonMap(json['sub_service_id']);
    return StayAfterHoursRequestItem(
      id: readJsonInt(json['id']),
      serviceId: readJsonInt(json['service_id']),
      subServiceId: readJsonInt(json['sub_service_id']),
      requestName:
          readJsonString(subService?['sub_service_name']) ??
          readJsonString(json['request_name']) ??
          'Request for stay after working hours',
      requestStatus: readJsonString(json['status']),
      requestDate: _formatDate(readJsonString(json['created_at'])),
      permitNumber: readJsonString(json['permit_number']),
      jobNumber: readJsonString(json['job_number']),
      dateFrom: readJsonString(json['date_from']),
      dateTo: readJsonString(json['date_to']),
      durationFrom: readJsonString(json['duration_from']),
      durationTo: readJsonString(json['duration_to']),
      assignedTo: _assignedTo(json),
    );
  }

  static String? _assignedTo(Map<String, dynamic> json) {
    final approvalDetails = json['approval_details'];
    if (approvalDetails is! List || approvalDetails.isEmpty) {
      return readJsonString(json['group_name']);
    }

    Map<String, dynamic>? selected;
    for (final item in approvalDetails) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final status = readJsonString(map['approval_status'])?.toLowerCase();
      if (status == 'pending' || status == 'in progress') {
        selected = map;
        break;
      }
    }
    selected ??= Map<String, dynamic>.from(approvalDetails.first as Map);

    final department = readJsonMap(selected['department']);
    final section = readJsonMap(selected['section']);
    final departmentName = readJsonString(department?['department_name']);
    final sectionName = readJsonString(section?['section_name']);
    if ((departmentName ?? '').isEmpty && (sectionName ?? '').isEmpty) {
      return readJsonString(json['group_name']);
    }
    if ((sectionName ?? '').isEmpty) return departmentName;
    if ((departmentName ?? '').isEmpty) return sectionName;
    return '$departmentName - $sectionName';
  }

  static String? _formatDate(String? value) {
    if (value == null || value.isEmpty) return value;
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
