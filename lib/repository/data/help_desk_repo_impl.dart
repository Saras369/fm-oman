import 'dart:developer';

import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/help_desk_request_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_category_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_issue_type_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_sub_category_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/domain/help_desk_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class HelpDeskRepoImpl implements HelpDeskRepo {
  @override
  Future<void> createHelpDeskRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.helpDeskCreateNGetRequest,
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
  Future<List<HelpDeskCategoryItem>?> fetchHelpDeskCategory() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.helpDeskCategories);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final categories = HelpDeskCategoryModel.fromJson(jsonMap).data;
          return categories;
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
      log('error fetching helpdesk categories $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<HelpDeskIssueTypeItem>?> fetchHelpDeskIssueType(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.helpDeskIssueTypes,
          queryParameters: queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final issueType = HelpDeskIssueTypeModel.fromJson(jsonMap).data;
          return issueType;
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
      log('error fetching helpdesk issue types $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<HelpDeskSubCategoryItem>?> fetchHelpDeskSubCategory(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.helpDeskSubCategories,
          queryParameters: queryParams,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final subCategories = HelpdeskSubCategoryModel.fromJson(jsonMap).data;
          return subCategories;
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
      log('error fetching sub categories $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ApprovalKpiStatsItem?> fetchApproverKPIStats() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.helpDeskApprovalKpiStats);
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
              ? ApiEndPoint.helpDeskmonthlyTrend
              : ApiEndPoint.helpDeskApprovalMonthlyTrend,
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
              ? ApiEndPoint.helpDeskStatusBreakdown
              : ApiEndPoint.helpDeskApprovalStatusBreakDown,
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
  Future<List<HelpDeskRequestItem>?> fetchHelpDeskMyRequests() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.helpDeskCreateNGetRequest,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final myRequests = HelpDeskRequestModel.fromJson(jsonMap).data;
          return myRequests;
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
      log('error fetching helpdesk my requests $e');
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
