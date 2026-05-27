import 'dart:developer';

import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/models/attendance_data_model.dart';
import 'package:code_setup/repository/domain/attendance_repository.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<AttendanceData?> fetchAttendanceRecord() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.attendanceRecords);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final attendanceData = AttendanceData.fromJson(jsonMap['data'] ?? {});
          return attendanceData;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance records $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createUpdateAttendanceRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createUpdateAttendanceRequest,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(response.data['message']);
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating update attendance request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<AttendanceRequestItem>?> fetchMyAttendanceRequests() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.myAttendanceReuqests);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final attendanceRequest = AttendanceRequestModel.fromJson(
            jsonMap,
          ).data;
          return attendanceRequest;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching my attendance requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<AttendanceRequestItem>?> fetchAttendanceApprovalRequests() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.attendanceApprovalRequests);
        if (response.statusCode == 200 && response.data != null) {
          return AttendanceRequestModel.fromJson(
            Map<String, dynamic>.from(response.data),
          ).data;
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
      return null;
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance approval requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<AttendanceRequestItem?> fetchAttendanceRequestDetailsById(
    int id,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.updateAttendanceRequestById(id),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final rawData = jsonMap['data'];
          if (rawData is Map<String, dynamic>) {
            return AttendanceRequestItem.fromJson(rawData);
          }
          if (rawData is Map) {
            return AttendanceRequestItem.fromJson(
              Map<String, dynamic>.from(rawData),
            );
          }
          if (rawData is List && rawData.isNotEmpty) {
            final first = rawData.first;
            if (first is Map<String, dynamic>) {
              return AttendanceRequestItem.fromJson(first);
            }
            if (first is Map) {
              return AttendanceRequestItem.fromJson(
                Map<String, dynamic>.from(first),
              );
            }
          }
          return AttendanceRequestItem.fromJson(jsonMap);
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
      return null;
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance request details $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> addCommentInAttendanceRequest(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.updateAttendanceRequestChat(id),
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Message sent',
          );
        } else {
          throw ApiException(
            response.data?['message'] ?? 'Unexpected error occurred',
          );
        }
      }
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error adding attendance comment $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> approveAttendanceRequest(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.updateAttendanceRequestApprove(id),
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request approved successfully',
          );
        } else {
          throw ApiException(
            response.data?['message'] ?? 'Unexpected error occurred',
          );
        }
      }
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error approving attendance request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> rejectAttendanceRequest(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.updateAttendanceRequestReject(id),
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Request rejected successfully',
          );
        } else {
          throw ApiException(
            response.data?['message'] ?? 'Unexpected error occurred',
          );
        }
      }
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error rejecting attendance request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchAttendanceStats({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.updateAttendanceApproverKPIStats
        : ApiEndPoint.updateAttendanceKPIStats;
    return _fetchStats(endpoint, queryParams ?? const {});
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchAttendanceStatusBreakdown({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.updateAttendanceApproverStatusBreakdown
        : ApiEndPoint.updateAttendanceStatusBreakdown;
    return _fetchStatusBreakdown(endpoint, queryParams ?? const {});
  }

  @override
  Future<FinancialServicesTrendBreakdownData?> fetchAttendanceTrendBreakdown({
    bool isApprover = false,
    Map<String, dynamic>? queryParams,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.updateAttendanceApproverTrendBreakdown
        : ApiEndPoint.updateAttendanceTrendBreakdown;
    return _fetchTrendBreakdown(endpoint, queryParams ?? const {});
  }

  Future<FinancialServicesStatsData?> _fetchStats(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          endpoint,
          queryParameters: queryParams.isEmpty ? null : queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          return FinancialServicesStatsModel.fromJson(
            Map<String, dynamic>.from(response.data),
          ).data;
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
      return null;
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance stats $e');
      throw ApiException(e.toString());
    }
  }

  Future<FinancialStatusBreakdownData?> _fetchStatusBreakdown(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          endpoint,
          queryParameters: queryParams.isEmpty ? null : queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          return FinancialStatusBreakdownModel.fromJson(
            Map<String, dynamic>.from(response.data),
          ).data;
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
      return null;
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  Future<FinancialServicesTrendBreakdownData?> _fetchTrendBreakdown(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          endpoint,
          queryParameters: queryParams.isEmpty ? null : queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          return FinancialServicesTrendBreakdownModel.fromJson(
            Map<String, dynamic>.from(response.data),
          ).data;
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
      return null;
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching attendance trend breakdown $e');
      throw ApiException(e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
