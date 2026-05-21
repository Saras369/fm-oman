import 'dart:developer';

import 'package:code_setup/modules/data/models/financial_services/allownace_type_model.dart';
import 'package:code_setup/modules/data/models/financial_services/bank_name_model.dart';
import 'package:code_setup/modules/data/models/financial_services/currency_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_service_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_request_details_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/financial_services_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class FinancialServicesRepoImpl implements FinancialServicesRepo {
  @override
  Future<void> createPaySlipRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.payslipRequest,
          data: data,
        );
        if (response.statusCode == 200 && response.data != null) {
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
      log('error creating pay slip requset $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createSalaryCertificateRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.salaryCertificateRequest,
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
      log('error creating salary certificate requset $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createBankAccountChangeRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.createChangeBaankAccountRequest,
          data: data,
        );
        if (response.statusCode == 200 && response.data != null) {
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
      log('error changing bank account $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesStatsData?> fetchFinancialServicesStats(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServiceStats,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final statsData = FinancialServicesStatsData.fromJson(
            jsonMap['data'] ?? {},
          );
          return statsData;
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
      log('error fetching service stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?> fetchFinancialServicesStatusBreakdown(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServicesStatusBreakdown,
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
  Future<FinancialServicesTrendBreakdownData?>
  fetchFinancialServicesTrendBreakdown(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServicesTrendBreakdown,
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
  Future<FinancialServicesStatsData?> fetchFinancialServicesApproverStats(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServiceApproverStats,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final statsData = FinancialServicesStatsData.fromJson(
            jsonMap['data'] ?? {},
          );
          return statsData;
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
      log('error fetching approver service stats $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialStatusBreakdownData?>
  fetchFinancialServicesApproverStatusBreakdown(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServicesApproverStatusBreakdown,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
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
      log('error fetching approver status breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<FinancialServicesTrendBreakdownData?>
  fetchFinancialServicesApproverTrendBreakdown(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServicesApproverTrendBreakdown,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
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
      log('error fetching approver trend breakdown $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<AllowanceTypeItem>?> fetchAllowanceTypes() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.allownaceTypes);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final allowanceList = AllowanceTypeModel.fromJson(jsonMap).data;
          return allowanceList;
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
      log('error fetching allowance types $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<BankNameItem>?> fetchBankNames() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.bankNames);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final bankList = BankNameModel.fromJson(jsonMap).data;
          return bankList;
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
      log('error fetching bank names $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<CurrencyItem>?> fetchCurrrencyList() async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(ApiEndPoint.getCurrency);
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final currencyList = CurrencyModel.fromJson(jsonMap).data;
          return currencyList;
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
      log('error fetching currencies $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> createAllownaceRequest(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.requestForAllowance,
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
      log('error creating allowance requset $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<FinancialServiceRequestItem>?> fetchFinancialServiceMyRequests(
    Map<String, dynamic> data,
  ) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServiceMyRequests,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final finServiceRequest = FinancialServiceRequestModel.fromJson(
            jsonMap,
          ).data;
          return finServiceRequest;
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
      log('error fetching financial service my requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<FinancialServiceRequestItem>?>
  fetchFinancialServiceApprovalRequests(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServiceApproveRequestsList,
          queryParameters: data,
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final finServiceRequest = FinancialServiceRequestModel.fromJson(
            jsonMap,
          ).data;
          return finServiceRequest;
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
      log('error fetching financial service approval requests $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<FinancialServiceRequestDetailsItem>?>
  fetchFinancialServiveiceRequestDetailsById(int id) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.financialServiceRequestDetailsById(id),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          // Construct AttendanceData from JSON
          final finServiceRequest =
              FinancialServicesRequestDetailsModel.fromJson(jsonMap).data;
          return finServiceRequest;
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
      log('error fetching financial service request details $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> addCommentInFinRequest(int id, Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.financeComment(id),
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
      log('error creating allowance requset $e');
      throw ApiException(e.toString());
    }
  }
}
