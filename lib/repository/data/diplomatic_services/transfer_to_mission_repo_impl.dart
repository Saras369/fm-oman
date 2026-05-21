import 'dart:developer';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/domain/diplomatic_services/transfer_to_mission_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class TransferToMissionRepoImpl implements TransferToMissionRepo {
  @override
  Future<ApprovalKpiStatsItem?> fetchApproverKPIStats() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.missionTransferApproverKPIStats,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final trendBreakdownData = ApprovalKpiStatsModel.fromJson(
            jsonMap,
          ).data;
          return trendBreakdownData;
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
      log('error fetching trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    Map<String, dynamic> data,
    bool isMyRequest,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          isMyRequest
              ? ApiEndPoint.missionTransferMonthlyTrend
              : ApiEndPoint.missionTransferApproverMonthlyTrend,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final trendBreakdownData =
              FinancialServicesTrendBreakdownData.fromJson(
                jsonMap['data'] ?? {},
              );
          return trendBreakdownData;
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
      log('error fetching trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    Map<String, dynamic> data,
    bool isMyRequest,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          isMyRequest
              ? ApiEndPoint.missionTransferStatusBreakdown
              : ApiEndPoint.missionTransferApproverStatusBreakdown,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final breakdownData = FinancialStatusBreakdownData.fromJson(
            jsonMap['data'] ?? {},
          );
          return breakdownData;
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
      log('error fetching status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchMyKPIStats() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.missionTransferKPIStats);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final stats = FinancialServicesStatsModel.fromJson(jsonMap).data;
          return stats;
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
      log('error fetching kpi $e');
      throw ApiException(e.toString());
    }
  }

  // @override
  // Future<List<StationeryMyRequestItem>?> fetchPendingApprovalRequests() async {
  //   try {
  //     final client = await KAppX.network.secureClient();
  //     if (client != null) {
  //       final response = await client.get(
  //         ApiEndPoint.stationeryPendingApproval,
  //       );
  //       if (response.statusCode == 200 && response.data != null) {
  //         final jsonMap = Map<String, dynamic>.from(response.data);
  //         // Construct AttendanceData from JSON
  //         final myRequests = StationeryMyRequestsModel.fromJson(jsonMap).data;
  //         return myRequests;
  //       } else {
  //         final errorMessage =
  //             response.data?['message'] ?? 'Unexpected error occurred';
  //         throw ApiException(errorMessage);
  //       }
  //     }
  //     return null;
  //   } on DioException catch (error) {
  //     log('caught error');
  //     final message = error.response?.data['message'] ?? error.message;
  //     throw ApiException(message);
  //   } catch (e) {
  //     log('error fetching pending approval $e');
  //     throw ApiException(e.toString());
  //   }
  // }

  // @override
  // Future<List<StationeryMyRequestItem>?> fetchStationeryMyRequests() async {
  //   try {
  //     final client = await KAppX.network.secureClient();
  //     if (client != null) {
  //       final response = await client.get(ApiEndPoint.stationeryMyRequests);
  //       if (response.statusCode == 200 && response.data != null) {
  //         final jsonMap = Map<String, dynamic>.from(response.data);
  //         // Construct AttendanceData from JSON
  //         final myRequests = StationeryMyRequestsModel.fromJson(jsonMap).data;
  //         return myRequests;
  //       } else {
  //         final errorMessage =
  //             response.data?['message'] ?? 'Unexpected error occurred';
  //         throw ApiException(errorMessage);
  //       }
  //     }
  //     return null;
  //   } on DioException catch (error) {
  //     log('caught error');
  //     final message = error.response?.data['message'] ?? error.message;
  //     throw ApiException(message);
  //   } catch (e) {
  //     log('error fetching my stationery requests $e');
  //     throw ApiException(e.toString());
  //   }
  // }

  @override
  Future<void> createTransferToMissionApproveRequest(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.missionTransferApproveReject,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          // Construct AttendanceData from JSON
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
      log('error creating helpdesk  requset $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createTransferToMissionRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.missionTransferCreateRequest,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          // Construct AttendanceData from JSON
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
      log('error creating helpdesk  requset $e');
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
