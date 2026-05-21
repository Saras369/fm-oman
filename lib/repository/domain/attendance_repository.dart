import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/models/attendance_data_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';

abstract class AttendanceRepository {
  factory AttendanceRepository() => AttendanceRepositoryImpl();

  Future<AttendanceData?> fetchAttendanceRecord();

  Future<List<AttendanceRequestItem>?> fetchMyAttendanceRequests();

  Future<void> createUpdateAttendanceRequest(Map<String, dynamic> data);
}
