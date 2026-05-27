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
import 'package:code_setup/repository/data/leave_repo_impl.dart';

abstract class LeaveRepo {
  factory LeaveRepo() => LeaveRepoImpl();

  Future<LeaveTypeModel?> fetchLeaveTypes(String leaveType);
  Future<LeaveCountModel?> fetchLeaveCount();
  Future<void> createLeaveRequest(Map<String, dynamic> data);
  Future<List<MyLeaveRequestItem>?> fetchMyLeaveRequests();
  Future<LeaveRequestDetailsModel?> fetchLeaveRequestDetailsById(int id);
  Future<void> approveOrRejectLeaveRequest(Map<String, dynamic> data);
  Future<List<MyLeaveRequestItem>?> fetchLeaveApprovalRequests({
    int offset,
    int limit,
    Map<String, dynamic>? queryParameters,
  });
  Future<FinancialServicesStatsData?> fetchLeaveKPIStats(
    Map<String, dynamic> data, {
    bool isMyRequest,
  });
  Future<ApprovalKpiStatsItem?> fetchLeaveApproverKPIStats(
    Map<String, dynamic> data,
  );
  Future<FinancialStatusBreakdownData?> fetchLeaveStatusBreakdown(
    Map<String, dynamic> data, {
    bool isMyRequest,
  });
  Future<FinancialServicesTrendBreakdownData?> fetchLeaveTrendBreakdown(
    Map<String, dynamic> data, {
    bool isMyRequest,
  });
  Future<List<LeaveUserBalanceItem>?> fetchLeaveUserBalances(
    int userId, {
    int? year,
  });
  Future<List<UnpaidLeaveCategoryItem>?> fetchUnpaidLeaveCategories();
  Future<List<MourningLeaveRelationItem>?> fetchMourningLeaveRelation();
  Future<void> createStayAfterHoursRequest(Map<String, dynamic> data);
  Future<List<StayAfterHoursRequestItem>?> fetchStayAfterHoursRequests(
    Map<String, dynamic> data, {
    bool isApprover = false,
  });
  Future<Map<String, dynamic>?> fetchStayAfterHoursDetails(int id);
  Future<FinancialServicesStatsData?> fetchStayAfterHoursStats(
    Map<String, dynamic> data, {
    bool isApprover = false,
  });
  Future<FinancialStatusBreakdownData?> fetchStayAfterHoursStatusBreakdown(
    Map<String, dynamic> data, {
    bool isApprover = false,
  });
  Future<FinancialServicesTrendBreakdownData?>
  fetchStayAfterHoursTrendBreakdown(
    Map<String, dynamic> data, {
    bool isApprover = false,
  });
}
