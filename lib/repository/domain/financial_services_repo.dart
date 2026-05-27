import 'package:code_setup/modules/data/models/financial_services/allownace_type_model.dart';
import 'package:code_setup/modules/data/models/financial_services/bank_name_model.dart';
import 'package:code_setup/modules/data/models/financial_services/currency_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_service_request_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_request_details_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_stats_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_status_breakdown_model.dart';
import 'package:code_setup/modules/data/models/financial_services/financial_services_trend_breakdown_model.dart';
import 'package:code_setup/repository/data/financial_services_repo_impl.dart';

abstract class FinancialServicesRepo {
  factory FinancialServicesRepo() => FinancialServicesRepoImpl();

  Future<void> createPaySlipRequest(Map<String, dynamic> data);
  Future<void> createSalaryCertificateRequest(Map<String, dynamic> data);
  Future<void> createBankAccountChangeRequest(Map<String, dynamic> data);
  Future<void> createAllownaceRequest(Map<String, dynamic> data);
  Future<FinancialServicesStatsData?> fetchFinancialServicesStats(
    Map<String, dynamic> data,
  );
  Future<FinancialStatusBreakdownData?> fetchFinancialServicesStatusBreakdown(
    Map<String, dynamic> data,
  );
  Future<FinancialServicesTrendBreakdownData?>
  fetchFinancialServicesTrendBreakdown(Map<String, dynamic> data);

  Future<FinancialServicesStatsData?> fetchFinancialServicesApproverStats(
    Map<String, dynamic> data,
  );
  Future<FinancialStatusBreakdownData?>
  fetchFinancialServicesApproverStatusBreakdown(Map<String, dynamic> data);
  Future<FinancialServicesTrendBreakdownData?>
  fetchFinancialServicesApproverTrendBreakdown(Map<String, dynamic> data);
  Future<List<BankNameItem>?> fetchBankNames();
  Future<List<AllowanceTypeItem>?> fetchAllowanceTypes();
  Future<List<CurrencyItem>?> fetchCurrrencyList();
  Future<List<FinancialServiceRequestItem>?> fetchFinancialServiceMyRequests(
    Map<String, dynamic> data,
  );
  Future<List<FinancialServiceRequestItem>?>
  fetchFinancialServiceApprovalRequests(Map<String, dynamic> data);
  Future<List<FinancialServiceRequestDetailsItem>?>
  fetchFinancialServiveiceRequestDetailsById(int id);
  Future<void> addCommentInFinRequest(int id, Map<String, dynamic> data);
  Future<void> approveFinancialRequest(int id, Map<String, dynamic> data);
  Future<void> rejectFinancialRequest(int id, Map<String, dynamic> data);
}
