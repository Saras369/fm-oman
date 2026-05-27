class ShiftDetails {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? shiftName;
  final String? startTime;
  final String? endTime;
  final String? firstSessionStartTime;
  final String? firstSessionEndTime;
  final String? secondSessionStartTime;
  final String? secondSessionEndTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ShiftDetails({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.shiftName,
    this.startTime,
    this.endTime,
    this.firstSessionStartTime,
    this.firstSessionEndTime,
    this.secondSessionStartTime,
    this.secondSessionEndTime,
    this.createdAt,
    this.updatedAt,
  });

  factory ShiftDetails.fromJson(Map<String, dynamic> json) {
    return ShiftDetails(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      shiftName: json['shift_name'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      firstSessionStartTime: json['first_session_start_time'] as String?,
      firstSessionEndTime: json['first_session_end_time'] as String?,
      secondSessionStartTime: json['second_session_start_time'] as String?,
      secondSessionEndTime: json['second_session_end_time'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'shift_name': shiftName,
    'start_time': startTime,
    'end_time': endTime,
    'first_session_start_time': firstSessionStartTime,
    'first_session_end_time': firstSessionEndTime,
    'second_session_start_time': secondSessionStartTime,
    'second_session_end_time': secondSessionEndTime,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class AttendanceRecord {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? userId;
  final int? shiftId;
  final String? attendanceDate;
  final String? checkInTime;
  final String? checkOutTime;
  final String? firstHalfStatus;
  final String? secondHalfStatus;
  final String? attendanceStatus;
  final String? excessHours;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceRecord({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.userId,
    this.shiftId,
    this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    this.firstHalfStatus,
    this.secondHalfStatus,
    this.attendanceStatus,
    this.excessHours,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      shiftId: json['shift_id'] as int?,
      attendanceDate: json['attendance_date'] as String?,
      checkInTime: json['check_in_time'] as String?,
      checkOutTime: json['check_out_time'] as String?,
      firstHalfStatus: json['first_half_status'] as String?,
      secondHalfStatus: json['second_half_status'] as String?,
      attendanceStatus: json['attendance_status'] as String?,
      excessHours: json['excess_hours'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_by': createdBy,
    'updated_by': updatedBy,
    'id': id,
    'user_id': userId,
    'shift_id': shiftId,
    'attendance_date': attendanceDate,
    'check_in_time': checkInTime,
    'check_out_time': checkOutTime,
    'first_half_status': firstHalfStatus,
    'second_half_status': secondHalfStatus,
    'attendance_status': attendanceStatus,
    'excess_hours': excessHours,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class AttendanceData {
  final List<ShiftDetails>? shiftDetails;
  final double? actualShiftWorkingHours;
  final double? employeeAvgWorkingHours;
  final int? lateCheckinCount;
  final int? earlyCheckoutCount;
  final List<AttendanceRecord>? attendanceRecords;
  final String? month;
  final String? startDate;
  final String? endDate;
  final int? totalDays;

  AttendanceData({
    this.shiftDetails,
    this.actualShiftWorkingHours,
    this.employeeAvgWorkingHours,
    this.lateCheckinCount,
    this.earlyCheckoutCount,
    this.attendanceRecords,
    this.month,
    this.startDate,
    this.endDate,
    this.totalDays,
  });

  static List<dynamic>? _asList(dynamic v) {
    if (v is List) return v;
    return null;
  }

  static Map<String, dynamic>? _asMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return Map<String, dynamic>.from(v);
    return null;
  }

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    final shiftList = _asList(json['shift_details']);
    final recordList = _asList(json['attendance_records']);
    return AttendanceData(
      shiftDetails: shiftList
          ?.map((e) {
            final m = _asMap(e);
            return m == null ? null : ShiftDetails.fromJson(m);
          })
          .whereType<ShiftDetails>()
          .toList(),
      actualShiftWorkingHours: (json['actual_shift_working_hours'] as num?)
          ?.toDouble(),
      employeeAvgWorkingHours: (json['employee_avg_working_hours'] as num?)
          ?.toDouble(),
      lateCheckinCount: json['late_checkin_count'] is int
          ? json['late_checkin_count'] as int
          : int.tryParse('${json['late_checkin_count']}'),
      earlyCheckoutCount: json['early_checkout_count'] is int
          ? json['early_checkout_count'] as int
          : int.tryParse('${json['early_checkout_count']}'),
      attendanceRecords: recordList
          ?.map((e) {
            final m = _asMap(e);
            return m == null ? null : AttendanceRecord.fromJson(m);
          })
          .whereType<AttendanceRecord>()
          .toList(),
      month: json['month'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      totalDays: json['total_days'] is int
          ? json['total_days'] as int
          : int.tryParse('${json['total_days']}'),
    );
  }

  Map<String, dynamic> toJson() => {
    'shift_details': shiftDetails?.map((e) => e.toJson()).toList(),
    'actual_shift_working_hours': actualShiftWorkingHours,
    'employee_avg_working_hours': employeeAvgWorkingHours,
    'late_checkin_count': lateCheckinCount,
    'early_checkout_count': earlyCheckoutCount,
    'attendance_records': attendanceRecords?.map((e) => e.toJson()).toList(),
    'month': month,
    'start_date': startDate,
    'end_date': endDate,
    'total_days': totalDays,
  };
}
