import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/approval_kpi_stats_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/help_desk_request_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_category_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_issue_type_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_sub_category_model.dart';
import 'package:code_setup/repository/data/help_desk_repo_impl.dart';

abstract class HelpDeskRepo {
  factory HelpDeskRepo() => HelpDeskRepoImpl();

  Future<List<HelpDeskCategoryItem>?> fetchHelpDeskCategory();
  Future<List<HelpDeskRequestItem>?> fetchHelpDeskMyRequests();

  Future<List<HelpDeskSubCategoryItem>?> fetchHelpDeskSubCategory(
    Map<String, dynamic> queryParams,
  );
  Future<List<HelpDeskIssueTypeItem>?> fetchHelpDeskIssueType(
    Map<String, dynamic> queryParams,
  );

  Future<void> createHelpDeskRequest(Map<String, dynamic> data);

  Future<ApprovalKpiStatsItem?> fetchApproverKPIStats();
  Future<FinancialStatusBreakdownData?> fetchStatusBreakdown(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
  Future<FinancialServicesTrendBreakdownData?> fetchMonthlyTrend(
    Map<String, dynamic> data,
    bool isMyRequest,
  );
  //     Future<FinancialStatusBreakdownData?> fetchApproverStatusBreakdown(
  //   Map<String, dynamic> data,
  // );
  // Future<FinancialServicesTrendBreakdownData?>
  // fetchApproverMonthlyTrend(Map<String, dynamic> data);
}
