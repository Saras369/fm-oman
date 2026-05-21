import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/stationery/sationery_material_model.dart';
import 'package:code_setup/modules/data/models/stationery/stationery_my_request_model.dart';
import 'package:code_setup/modules/data/models/stationery/stationery_office_model.dart';
import 'package:code_setup/repository/data/stationery_repo_impl.dart';

abstract class StationeryRepo {
  factory StationeryRepo() => StationeryRepoImpl();

  Future<List<StationeryMyRequestItem>?> fetchStationeryMyRequests();
  Future<List<StationeryMyRequestItem>?> fetchPendingApprovalRequests();
  Future<List<StationeryMaterialItem>?> fetchStationeryMaterialItem();
  Future<List<StationeryOfficeItem>?> fetchStationeryOfficeItem();

  Future<void> createStationeryRequest(Map<String, dynamic> data);
  Future<void> createStationeryApproveRequest(Map<String, dynamic> data);
  Future<void> createStationeryApproveApproveByFinanceRequest(
    Map<String, dynamic> data,
  );
  Future<void> createStationeryAsssignToOfficeRequest(
    Map<String, dynamic> data,
  );

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
