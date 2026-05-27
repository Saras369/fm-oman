import 'dart:developer';

import 'package:code_setup/modules/data/models/financial_services/financial_json_read.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_request_details_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/security_services/security_request_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/security_services_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class SecurityServicesRepoImpl implements SecurityServicesRepo {
  @override
  Future<void> createRequest(String slug, Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.securityCreateRequest(slug),
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
      log('error creating security request $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<SecurityRequestItem>?> fetchMyRequests(String slug) {
    return _fetchRequestList(ApiEndPoint.securityMyRequests(slug));
  }

  @override
  Future<List<SecurityRequestItem>?> fetchApprovalRequests(String slug) {
    return _fetchRequestList(ApiEndPoint.securityApprovalRequests(slug));
  }

  @override
  Future<FinancialServiceRequestDetailsItem?> fetchRequestDetails(
    String slug,
    int id,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.securityDetailsById(slug, id),
        );
        if (response.statusCode == 200 && response.data != null) {
          final detailMap = _extractSecurityDetailMap(response.data);
          if (detailMap == null) return null;
          return FinancialServiceRequestDetailsItem.fromJson(
            _normalizeSecurityDetailJson(detailMap),
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
      log('error fetching security request details $e');
      throw ApiException(e.toString());
    }
  }

  Map<String, dynamic>? _extractSecurityDetailMap(dynamic responseData) {
    if (responseData is! Map) return null;
    final jsonMap = Map<String, dynamic>.from(responseData);
    final rawData = jsonMap['data'];

    if (rawData is List && rawData.isNotEmpty) {
      final first = rawData.first;
      if (first is List && first.isNotEmpty) {
        final item = readJsonMap(first.first);
        if (item != null) return item;
      }
      final item = readJsonMap(first);
      if (item != null) return item;
    }

    if (rawData is Map) {
      return Map<String, dynamic>.from(rawData);
    }

    return jsonMap;
  }

  Map<String, dynamic> _normalizeSecurityDetailJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    if (normalized['approvals'] == null && normalized['approval_details'] != null) {
      normalized['approvals'] = normalized['approval_details'];
    }
    if (normalized['chats'] == null && normalized['chat_messages'] != null) {
      normalized['chats'] = normalized['chat_messages'];
    }

    return normalized;
  }

  @override
  Future<void> addCommentInSecurityRequest(
    String slug,
    int id,
    Map<String, dynamic> data,
  ) async {
    await _postSecurityAction(ApiEndPoint.securityRequestChat(slug, id), data);
  }

  @override
  Future<void> approveSecurityRequest(
    String slug,
    int id,
    Map<String, dynamic> data,
  ) async {
    await _postSecurityAction(
      ApiEndPoint.securityRequestApprove(slug, id),
      data,
    );
  }

  @override
  Future<void> rejectSecurityRequest(
    String slug,
    int id,
    Map<String, dynamic> data,
  ) async {
    await _postSecurityAction(
      ApiEndPoint.securityRequestReject(slug, id),
      data,
    );
  }

  Future<void> _postSecurityAction(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(endpoint, data: data);
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data != null) {
          ShowFlutterToast().showFlutterToastSuccess(
            response.data['message'] ?? 'Success',
          );
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
      log('error posting security action $e');
      throw ApiException(e.toString());
    }
  }

  Future<List<SecurityRequestItem>?> _fetchRequestList(String endpoint) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint);
        if (response.statusCode == 200 && response.data != null) {
          return SecurityRequestModel.fromJson(
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
      log('error fetching security requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchKPIStats(String slug) {
    return _fetchStats(ApiEndPoint.securityKPIStats(slug));
  }

  @override
  Future<FinancialServicesStatsData?> fetchApprovalKPIStats(String slug) {
    return _fetchStats(ApiEndPoint.securityApprovalKPIStats(slug));
  }

  Future<FinancialServicesStatsData?> _fetchStats(String endpoint) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(endpoint);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          return FinancialServicesStatsModel.fromJson(jsonMap).data ??
              FinancialServicesStatsData.fromJson(jsonMap['data'] ?? {});
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
      log('error fetching security stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    String slug,
    Map<String, dynamic> data,
  ) {
    return _fetchStatus(ApiEndPoint.securityStatusBreakdown(slug), data);
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchApprovalStatusBreakdown(
    String slug,
    Map<String, dynamic> data,
  ) {
    return _fetchStatus(
      ApiEndPoint.securityApprovalStatusBreakdown(slug),
      data,
    );
  }

  Future<FinancialStatusBreakdownData?> _fetchStatus(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
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
      log('error fetching security status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    String slug,
    Map<String, dynamic> data,
  ) {
    return _fetchTrend(ApiEndPoint.securityMonthlyTrend(slug), data);
  }

  @override
  Future<FinancialServicesTrendBreakdownData?> fetchApprovalMonthlyTrend(
    String slug,
    Map<String, dynamic> data,
  ) {
    return _fetchTrend(ApiEndPoint.securityApprovalMonthlyTrend(slug), data);
  }

  Future<FinancialServicesTrendBreakdownData?> _fetchTrend(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
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
      log('error fetching security monthly trend $e');
      throw ApiException(e.toString());
    }
  }
}
