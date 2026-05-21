import 'package:code_setup/modules/data/models/diplomatic_services/club_card_diplomatic_title_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/repository/data/diplomatic_services/diplomatic_club_card_repo_impl.dart';

abstract class DiplomaticClubCardRepo {
  factory DiplomaticClubCardRepo() => DiplomaticClubCardRepoImpl();

  // Future<List<StationeryMyRequestItem>?> fetchTransferToMissionMyRequests();
  // Future<List<StationeryMyRequestItem>?> fetchPendingApprovalRequests();

  Future<void> createDiplomaticClubCardRequest(Map<String, dynamic> data);
  Future<void> createDiplomaticClubCardApproveRequest(
    Map<String, dynamic> data,
  );

  Future<FinancialServicesStatsData?> fetchMyKPIStats();
  Future<ApprovalKpiStatsItem?> fetchApproverKPIStats();
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
  Future<List<ClubCardDiplomaticTitleItem>?> fetchDiplomaticTitles(
    Map<String, dynamic> queryParams,
  );
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
}
