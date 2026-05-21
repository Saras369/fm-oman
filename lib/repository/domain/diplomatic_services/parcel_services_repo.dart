import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/repository/data/diplomatic_services/parcel_services_repo_impl.dart';

abstract class ParcelServicesRepo {
  factory ParcelServicesRepo() => ParcelServicesRepoImpl();

  // Future<List<StationeryMyRequestItem>?> fetchTransferToMissionMyRequests();
  // Future<List<StationeryMyRequestItem>?> fetchPendingApprovalRequests();

  Future<void> createParcelRequest(Map<String, dynamic> data);
  Future<void> createParcelApproveRequest(Map<String, dynamic> data);

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
