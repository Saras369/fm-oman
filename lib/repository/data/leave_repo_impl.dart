import 'dart:convert';
import 'dart:developer';

import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/hr_services/stay_after_hours_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_count_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_request_details_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_user_balance_model.dart';
import 'package:code_setup/modules/data/models/leave_request/leave_type_model.dart';
import 'package:code_setup/modules/data/models/leave_request/mourning_leave_relation_model.dart';
import 'package:code_setup/modules/data/models/leave_request/my_leave_request_model.dart';
import 'package:code_setup/modules/data/models/leave_request/unpaid_leave_category_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class LeaveRepoImpl implements LeaveRepo {
  @override
  Future<LeaveTypeModel?> fetchLeaveTypes(String leaveType) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.leaveTypes(leaveType));
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveTypeModel = LeaveTypeModel.fromJson(jsonMap);
          return leaveTypeModel;
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
  Future<LeaveCountModel?> fetchLeaveCount() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveCountAsPerFinancialGradeAndEmpType,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveCountData = LeaveCountModel.fromJson(jsonMap);
          return leaveCountData;
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
  Future<void> createLeaveRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createLeaveRequest,
          data: jsonEncode(data),
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          final successMessage = _extractApiMessage(
            response.data,
            fallback: 'Leave request created successfully',
          );
          ShowFlutterToast().showFlutterToastSuccess(successMessage);
        } else {
          final errorMessage = _extractApiMessage(
            response.data,
            fallback: 'Unexpected error occurred',
          );
          throw ApiException(errorMessage);
        }
      }
    } on DioException catch (error) {
      final message = _extractApiMessage(
        error.response?.data,
        fallback: error.message ?? 'Unexpected error occurred',
      );
      throw ApiException(message);
    } catch (e) {
      log('error creating leave request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<MyLeaveRequestItem>?> fetchMyLeaveRequests() async {
    final user = KAppX.globalProvider.read(userProvider);
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveMyRequests(user?.userId ?? 0),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveRequest = MyLeaveRequestsModel.fromJson(jsonMap).data;
          return leaveRequest;
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
      log('error fetching my leave requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<LeaveRequestDetailsModel?> fetchLeaveRequestDetailsById(int id) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.leaveRequestDetailsById(id));
        if (response.statusCode == 200 && response.data != null) {
          return LeaveRequestDetailsModel.fromJson(
            Map<String, dynamic>.from(response.data),
          );
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
      log('error fetching leave request details $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> approveOrRejectLeaveRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.leaveApproveRequest,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          final successMessage = _extractApiMessage(
            response.data,
            fallback: 'Leave request updated successfully',
          );
          ShowFlutterToast().showFlutterToastSuccess(successMessage);
          return;
        }
        throw ApiException(
          _extractApiMessage(response.data, fallback: 'Unexpected error occurred'),
        );
      }
    } on DioException catch (error) {
      final message = _extractApiMessage(
        error.response?.data,
        fallback: error.message ?? 'Unexpected error occurred',
      );
      throw ApiException(message);
    } catch (e) {
      log('error approving/rejecting leave request $e');
      throw ApiException(e.toString());
    }
  }

  String _extractApiMessage(dynamic data, {required String fallback}) {
    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString();
      if (message != null && message.trim().isNotEmpty) return message;
    } else if (data is Map) {
      final message = data['message']?.toString();
      if (message != null && message.trim().isNotEmpty) return message;
    } else if (data is String && data.trim().isNotEmpty) {
      return data;
    }
    return fallback;
  }

  @override
  Future<List<MyLeaveRequestItem>?> fetchLeaveApprovalRequests({
    int offset = 0,
    int limit = 100,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveApprovalRequests,
          queryParameters: {
            'offset': offset,
            'limit': limit,
            ...?queryParameters,
          },
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          return MyLeaveRequestsModel.fromJson(jsonMap).data;
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
      log('error fetching leave approval requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchLeaveKPIStats(
    Map<String, dynamic> data, {
    bool isMyRequest = true,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveKPIStats,
          queryParameters: data,
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
      log('error fetching leave kpi stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ApprovalKpiStatsItem?> fetchLeaveApproverKPIStats(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveApproverKPIStats,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          return ApprovalKpiStatsModel.fromJson(
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
      log('error fetching leave approver kpi stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchLeaveStatusBreakdown(
    Map<String, dynamic> data, {
    bool isMyRequest = true,
  }) async {
    final endpoint = isMyRequest
        ? ApiEndPoint.leaveStatusBreakdown
        : ApiEndPoint.leaveApproverStatusBreakdown;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          return FinancialStatusBreakdownData.fromJson(jsonMap['data'] ?? {});
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
      log('error fetching leave status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesTrendBreakdownData?> fetchLeaveTrendBreakdown(
    Map<String, dynamic> data, {
    bool isMyRequest = true,
  }) async {
    final endpoint = isMyRequest
        ? ApiEndPoint.leaveTrendBreakdown
        : ApiEndPoint.leaveApproverTrendBreakdown;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          return FinancialServicesTrendBreakdownData.fromJson(
            jsonMap['data'] ?? {},
          );
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
      log('error fetching leave trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<LeaveUserBalanceItem>?> fetchLeaveUserBalances(
    int userId, {
    int? year,
  }) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.leaveUserBalances(userId),
          queryParameters: {if (year != null) 'year': year},
        );
        if (response.statusCode == 200 && response.data != null) {
          return LeaveUserBalanceModel.fromJson(
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
      log('error fetching leave user balances $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<UnpaidLeaveCategoryItem>?> fetchUnpaidLeaveCategories() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.unpaidLeavecategories);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final unpaidLeave = UnpaidLeaveCategoryModel.fromJson(jsonMap).data;
          return unpaidLeave;
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
      log('error fetching unpaid leave categories $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<MourningLeaveRelationItem>?> fetchMourningLeaveRelation() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.mourningLeaveRelation);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final leaveRelation = MourningLeaveRelationModel.fromJson(
            jsonMap,
          ).data;
          return leaveRelation;
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
      log('error fetching mourning leave relation $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createStayAfterHoursRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.stayAfterHoursCreateRequest,
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(response.data['message']);
          return;
        }
        throw ApiException(
          response.data?['message'] ?? 'Unexpected error occurred',
        );
      }
    } on DioException catch (error) {
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating stay after hours request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<StayAfterHoursRequestItem>?> fetchStayAfterHoursRequests(
    Map<String, dynamic> data, {
    bool isApprover = false,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.stayAfterHoursApprovalRequests
        : ApiEndPoint.stayAfterHoursMyRequests;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
        if (response.statusCode == 200 && response.data != null) {
          return StayAfterHoursRequestModel.fromJson(
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
      log('error fetching stay after hours requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> fetchStayAfterHoursDetails(int id) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.stayAfterHoursDetailsById(id),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final rawData = jsonMap['data'];
          if (rawData is Map<String, dynamic>) return rawData;
          if (rawData is Map) return Map<String, dynamic>.from(rawData);
          return jsonMap;
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
      log('error fetching stay after hours details $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchStayAfterHoursStats(
    Map<String, dynamic> data, {
    bool isApprover = false,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.stayAfterHoursApproverKPIStats
        : ApiEndPoint.stayAfterHoursKPIStats;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
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
      log('error fetching stay after hours stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchStayAfterHoursStatusBreakdown(
    Map<String, dynamic> data, {
    bool isApprover = false,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.stayAfterHoursApproverStatusBreakdown
        : ApiEndPoint.stayAfterHoursStatusBreakdown;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
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
      log('error fetching stay after hours status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesTrendBreakdownData?>
  fetchStayAfterHoursTrendBreakdown(
    Map<String, dynamic> data, {
    bool isApprover = false,
  }) async {
    final endpoint = isApprover
        ? ApiEndPoint.stayAfterHoursApproverTrendBreakdown
        : ApiEndPoint.stayAfterHoursTrendBreakdown;
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint, queryParameters: data);
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
      log('error fetching stay after hours trend $e');
      throw ApiException(e.toString());
    }
  }
}
