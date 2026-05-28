import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/models/attendance_data_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';

abstract class AttendanceRepository {
  factory AttendanceRepository() => AttendanceRepositoryImpl();

  Future<AttendanceData?> fetchAttendanceRecord({
    required int month,
    required int year,
  });
  Future<List<WorkScheduleItem>?> fetchWorkSchedules({
    required int month,
    required int year,
  });
  Future<List<HolidayRangeItem>?> fetchHolidays({required int year});

  Future<List<AttendanceRequestItem>?> fetchMyAttendanceRequests();

  Future<List<AttendanceRequestItem>?> fetchAttendanceApprovalRequests();

  Future<AttendanceRequestItem?> fetchAttendanceRequestDetailsById(int id);

  Future<void> createUpdateAttendanceRequest(Map<String, dynamic> data);

  Future<void> addCommentInAttendanceRequest(
    int id,
    Map<String, dynamic> data,
  );

  Future<void> approveAttendanceRequest(int id, Map<String, dynamic> data);

  Future<void> rejectAttendanceRequest(int id, Map<String, dynamic> data);

  Future<FinancialServicesStatsData?> fetchAttendanceStats({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  });

  Future<FinancialStatusBreakdownData?> fetchAttendanceStatusBreakdown({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  });

  Future<FinancialServicesTrendBreakdownData?> fetchAttendanceTrendBreakdown({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  });
}
