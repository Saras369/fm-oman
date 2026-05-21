import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/security_services/security_request_model.dart';
import 'package:code_setup/repository/data/security_services_repo_impl.dart';

abstract class SecurityServicesRepo {
  factory SecurityServicesRepo() => SecurityServicesRepoImpl();

  Future<void> createRequest(String slug, Map<String, dynamic> data);
  Future<List<SecurityRequestItem>?> fetchMyRequests(String slug);
  Future<List<SecurityRequestItem>?> fetchApprovalRequests(String slug);
  Future<Map<String, dynamic>?> fetchRequestDetails(String slug, int id);
  Future<FinancialServicesStatsData?> fetchKPIStats(String slug);
  Future<FinancialServicesStatsData?> fetchApprovalKPIStats(String slug);
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    String slug,
    Map<String, dynamic> data,
  );
  Future<FinancialStatusBreakdownData?> fetchApprovalStatusBreakdown(
    String slug,
    Map<String, dynamic> data,
  );
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    String slug,
    Map<String, dynamic> data,
  );
  Future<FinancialServicesTrendBreakdownData?> fetchApprovalMonthlyTrend(
    String slug,
    Map<String, dynamic> data,
  );
}
