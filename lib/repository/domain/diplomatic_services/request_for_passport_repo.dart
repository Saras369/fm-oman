import 'package:code_setup/modules/data/models/diplomatic_services/passport_request_details_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/repository/data/diplomatic_services/request_for_passport_repo_impl.dart';
import 'package:code_setup/modules/data/models/diplomatic_services/passport_my_requests_model.dart';

abstract class RequestForPassportRepo {
  factory RequestForPassportRepo() => RequestForPassportRepoImpl();

  Future<List<PassportMyRequestItem>?> fetchPassportMyRequests(
    int offset,
    int limit,
  );
  Future<List<PassportMyRequestItem>?> fetchPassportApprovalRequests(
    int offset,
    int limit,
  );
  Future<PassportRequestDetailsModel?> fetchPassportRequestDetailsById(
    int requestId,
  );

  Future<void> createPassportRequest(Map<String, dynamic> data);
  Future<void> createPassportApproveRequest(Map<String, dynamic> data);

  Future<FinancialServicesStatsData?> fetchMyKPIStats();
  Future<ApprovalKpiStatsItem?> fetchApproverKPIStats();
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
}
