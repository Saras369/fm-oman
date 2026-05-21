class ApiEndPoint {
  static const String authMobileSignin = "/auth/mobilesignin";
  static String getUserById(String userId) => '/v1/user-service/user/$userId';
  static String userRoles(int userId) =>
      '/v1/user-service/user/$userId/roles-services';
  static const String holidaysList = "/v1/hr-service/holidays/2025";
  static const String usersList =
      "/v1/user-service/users"; // using for on behalf of requests
  static String allServices(
    int userId,
    int roleId,
    int departmentId,
    int sectionId,
  ) =>
      "/v1/user-service/user/$userId/role/$roleId/services?department_id=$departmentId&section_id=$sectionId";

  static String bookmarks(int userId) =>
      "/v1/user-service/service/bookmarks/$userId";
  static const String createBookmarks = "/v1/user-service/service/bookmark";
  static String leaveTypes(String type) => '/v1/hr-service/leaves/types/$type';
  static String leaveCountAsPerFinancialGradeAndEmpType =
      '/v1/hr-service/leaves/financial-grades';
  static String fetchCountries = '/v1/user-service/master/countries/listing';

  /// Financial Services
  static String salaryCertificateRequest =
      '/v1/financial-service/salary-certificate-requests';
  static String payslipRequest = '/v1/financial-service/payslip-requests';
  static String createChangeBaankAccountRequest =
      '/v1/financial-service/bank-account-change-requests';
  static String financialServiceStats =
      '/v1/financial-service/my-requests/stats';
  static String financialServicesStatusBreakdown =
      '/v1/financial-service/analytics/financial/status-breakdown';
  static String financialServicesTrendBreakdown =
      '/v1/financial-service/analytics/financial/monthly-trend';
  static String financialServicesActivityFeed =
      '/v1/financial-service/analytics/financial/activity-feed';
  static String financialServiceApproverStats =
      '/v1/financial-service/approvals/stats';
  static String financialServicesApproverStatusBreakdown =
      '/v1/financial-service/analytics/financial/approver/status-breakdown';
  static String financialServicesApproverTrendBreakdown =
      '/v1/financial-service/analytics/financial/approver/monthly-trend';
  static String bankNames = '/v1/financial-service/bank-names';
  static String allownaceTypes = '/v1/financial-service/allowance-types';
  static String getCurrency = '/v1/financial-service/get-currency';
  static String requestForAllowance =
      '/v1/financial-service/allowance-requests';
  static String financialServiceMyRequests =
      '/v1/financial-service/my-requests';
  static String financialServiceApproveRequestsList =
      '/v1/financial-service/approvals/pending';
  static String financialServiceApproveRequest(int id) =>
      '/v1/financial-service/payslip-requests/$id/approve';
  static String financialServiceRejectRequest(int id) =>
      '/v1/financial-service/payslip-requests/1/reject';
  static String financialServiceRequestDetailsById(int id) =>
      '/v1/financial-service/requests/$id';
  static String financeComment(int id) =>
      '/v1/financial-service/financial-requests/$id/chat';

  /// Security Services
  static String securityCreateRequest(String slug) =>
      '/v1/security-services/$slug/create';
  static String securityMyRequests(String slug) =>
      '/v1/security-services/$slug/requests';
  static String securityDetailsById(String slug, int id) =>
      '/v1/security-services/$slug/request/$id';
  static String securityApprovalRequests(String slug) {
    if (slug == 'employee-card') {
      return '/v1/security-services/$slug/pending-approvals';
    }
    return '/v1/security-services/$slug/requests/for-approval';
  }

  static String securityKPIStats(String slug) =>
      '/v1/security-services/analytics/$slug/kpi-cards';
  static String securityStatusBreakdown(String slug) =>
      '/v1/security-services/analytics/$slug/status-breakdown';
  static String securityMonthlyTrend(String slug) =>
      '/v1/security-services/analytics/$slug/trend-breakdown';
  static String securityApprovalKPIStats(String slug) =>
      '/v1/security-services/analytics/$slug-approvals/kpi-cards';
  static String securityApprovalStatusBreakdown(String slug) =>
      '/v1/security-services/analytics/$slug-approvals/status-breakdown';
  static String securityApprovalMonthlyTrend(String slug) =>
      '/v1/security-services/analytics/$slug-approvals/trend-breakdown';

  /// leave requests
  static String leaveMyRequests(int id) =>
      '/v1/hr-service/leaves/leaverequests/$id';
  static String createLeaveRequest = '/v1/hr-service/leaves/addrequest';
  static String uploadFile = '/v1/user-service/upload';
  static String unpaidLeavecategories =
      '/v1/hr-service/leaves/unpaidleavecategories';
  static String mourningLeaveRelation = '/v1/hr-service/leaves/leaverelations';

  /// Attendance
  static String myAttendanceReuqests =
      '/v1/hr-service/update-attendance/requests';
  static const String attendanceRecords = "/v1/hr-service/Attendance/106/09";
  static const String createUpdateAttendanceRequest =
      "/v1/hr-service/update-attendance/request";

  /// general services- helpdesk
  static String helpDeskCategories = '/v1/general-service/helpdesk/categories';
  static String helpDeskSubCategories =
      '/v1/general-service/helpdesk/subcategories';
  static String helpDeskIssueTypes = '/v1/general-service/helpdesk/issue-types';
  static String helpDeskCreateNGetRequest =
      '/v1/general-service/helpdesk/requests';
  static String helpDeskPendingRequest =
      '/v1/general-service/helpdesk/approvals/pending';
  static String helpDeskApprovalKpiStats =
      '/v1/general-service/helpdesk/approvals/kpi-stats';
  static String helpDeskApprovalStatusBreakDown =
      '/v1/general-service/helpdesk/analytics/approver/status-breakdown';
  static String helpDeskApprovalMonthlyTrend =
      '/v1/general-service/helpdesk/analytics/approver/monthly-trend';
  static String helpDeskStatusBreakdown =
      '/v1/general-service/helpdesk/analytics/status-breakdown';
  static String helpDeskmonthlyTrend =
      '/v1/general-service/helpdesk/analytics/monthly-trend';

  /// telephone directories
  static String departmentCategoryNList =
      '/v1/general-service/telephone/departments/count';
  static String createTelephoneDirectory =
      '/v1/general-service/telephone/create';
  static String embassies = '/v1/general-service/telephone/embassies';
  static String designations = '/v1/general-service/telephone/designations';
  static String diplomaticTitles =
      '/v1/general-service/telephone/diplomatic-titles';
  static String telephoneDirectory(int departmentId) =>
      '/v1/general-service/telephone/requests/$departmentId';

  /// stationery
  static String stationeryKPIStats =
      '/v1/general-service/stationery/analytics/kpi-stats';
  static String stationeryStatusBreakdown =
      '/v1/general-service/stationery/analytics/status-breakdown';
  static String stationeryMonthlyTrend =
      '/v1/general-service/stationery/analytics/monthly-trend';
  static String stationeryApproverKPIStats =
      '/v1/general-service/stationery/analytics/approver/kpi-stats';
  static String stationeryApproverStatusBreakdown =
      '/v1/general-service/stationery/analytics/approver/status-breakdown';
  static String stationeryApproverMonthlyTrend =
      '/v1/general-service/stationery/analytics/Approver/monthly-trend';
  static String stationeryCreateRequest =
      '/v1/general-service/stationery/create';
  static String stationeryMyRequests =
      '/v1/general-service/stationery/requests';
  static String stationeryPendingApproval =
      '/v1/general-service/stationery/approvals/pending';
  static String stationeryApproveRequest =
      '/v1/general-service/stationery/approve';
  static String stationeryApproveByFinanceRequest =
      '/v1/general-service/stationery/approve';
  static String stationeryAssignToOffice =
      '/v1/general-service/stationery/stores-office/assign-to-finance';
  static String stationeryOfficeMaterials =
      '/v1/general-service/stationery/materials/list';
  static String stationeryOfficesList =
      '/v1/general-service/stationery/offices/list';
  static String stationeryDetailsById(int id) =>
      '/v1/general-service/stationery/requests/$id';
  static String stationeryCreateChat(int id) =>
      '/v1/general-service/stationery/requests/$id/chat';

  /// diplomatic services
  // transfer to mission
  static String missionTransferKPIStats =
      '/v1/diplomatic-services/analytics/transfer-mission/kpi-cards';
  static String missionTransferStatusBreakdown =
      '/v1/diplomatic-services/analytics/transfer-mission/status-breakdown';
  static String missionTransferMonthlyTrend =
      '/v1/diplomatic-services/analytics/transfer-mission/trend-breakdown';
  static String missionTransferApproverKPIStats =
      '/v1/diplomatic-services/analytics/transfer-mission-approvals/kpi-cards';
  static String missionTransferApproverStatusBreakdown =
      '/v1/diplomatic-services/analytics/transfer-mission-approvals/status-breakdown';
  static String missionTransferApproverMonthlyTrend =
      '/v1/diplomatic-services/analytics/transfer-mission-approvals/monthly-trend';
  static String missionTransferCreateRequest =
      '/v1/diplomatic-services/transfer-mission/request';
  static String missionTransferApproveReject =
      '/v1/diplomatic-services/transfer-mission/approve';
  static String missionTransferDetailsById(int id) =>
      '/v1/diplomatic-services/transfer-mission/request/$id';

  // register vacancy
  static String registerVacancyKPIStats =
      '/v1/diplomatic-services/analytics/register-vacancy/kpi-cards';
  static String registerVacancyStatusBreakdown =
      '/v1/diplomatic-services/analytics/register-vacancy/status-breakdown';
  static String registerVacancyMonthlyTrend =
      '/v1/diplomatic-services/analytics/register-vacancy/trend-breakdown';
  static String registerVacancyApproverKPIStats =
      '/v1/diplomatic-services/analytics/register-vacancy-approvals/kpi-cards';
  static String registerVacancyApproverStatusBreakdown =
      '/v1/diplomatic-services/analytics/register-vacancy-approvals/status-breakdown';
  static String registerVacancyApproverMonthlyTrend =
      '/v1/diplomatic-services/analytics/register-vacancy-approvals/monthly-trend';
  static String registerVacancyCreateRequest =
      '/v1/diplomatic-services/register-vacancy/request';
  static String registerVacancyApproveReject =
      '/v1/diplomatic-services/register-vacancy/approve';
  static String registerVacancyMyRequests =
      '/v1/diplomatic-services/register-vacancy/requests';
  static String registerVacancyApprovalRequests =
      '/v1/diplomatic-services/register-vacancy/requests/for-approval';
  static String registerVacancyDetailsById(int id) =>
      '/v1/diplomatic-services/register-vacancy/request/$id';

  // request parcel

  static String requestParcelKPIStats =
      '/v1/diplomatic-services/analytics/request-parcel/kpi-cards';
  static String requestParcelStatusBreakdown =
      '/v1/diplomatic-services/analytics/request-parcel/status-breakdown';
  static String requestParcelMonthlyTrend =
      '/v1/diplomatic-services/analytics/request-parcel/trend-breakdown';
  static String requestParcelApproverKPIStats =
      '/v1/diplomatic-services/analytics/request-parcel-approvals/kpi-cards';
  static String requestParcelApproverStatusBreakdown =
      '/v1/diplomatic-services/analytics/request-parcel-approvals/status-breakdown';
  static String requestParcelApproverMonthlyTrend =
      '/v1/diplomatic-services/analytics/request-parcel-approvals/monthly-trend';
  static String requestParcelCreateRequest =
      '/v1/diplomatic-services/request-parcel/request';
  static String requestParcelApproveReject =
      '/v1/diplomatic-services/request-parcel/approve';
  static String requestParcelMyRequests =
      '/v1/diplomatic-services/request-parcel/requests';
  static String requestParcelApprovalRequests =
      '/v1/diplomatic-services/request-parcel/requests/for-approval';
  static String requestParcelDetailsById(int id) =>
      '/v1/diplomatic-services/request-parcel/request/$id';

  // request passport

  static String requestPassportKPIStats =
      '/v1/diplomatic-services/analytics/request-passport/kpi-cards';
  static String requestPassportStatusBreakdown =
      '/v1/diplomatic-services/analytics/request-passport/status-breakdown';
  static String requestPassportMonthlyTrend =
      '/v1/diplomatic-services/analytics/request-passport/trend-breakdown';
  static String requestPassportApproverKPIStats =
      '/v1/diplomatic-services/analytics/request-passport-approvals/kpi-cards';
  static String requestPassportApproverStatusBreakdown =
      '/v1/diplomatic-services/analytics/request-passport-approvals/status-breakdown';
  static String requestPassportApproverMonthlyTrend =
      '/v1/diplomatic-services/analytics/request-passport-approvals/trend-breakdown';
  static String requestPassportCreateRequest =
      '/v1/diplomatic-services/request-passport/request';
  static String requestPassportApproveReject =
      '/v1/diplomatic-services/request-passport/approve';
  static String requestPassportMyRequests =
      '/v1/diplomatic-services/request-passport/requests';
  static String requestPassportApprovalRequests =
      '/v1/diplomatic-services/request-passport/requests/for-approval';
  static String requestPassportDetailsById(int id) =>
      '/v1/diplomatic-services/request-passport/request/$id';

  // club card requests

  static String clubCardKPIStats =
      '/v1/diplomatic-services/analytics/club-card-requests/kpi-cards';
  static String clubCardStatusBreakdown =
      '/v1/diplomatic-services/analytics/club-card-requests/status-breakdown';
  static String clubCardMonthlyTrend =
      '/v1/diplomatic-services/analytics/club-card-requests/trend-breakdown';
  static String clubCardApproverKPIStats =
      '/v1/diplomatic-services/analytics/club-card-requests-approvals/kpi-cards';
  static String clubCardApproverStatusBreakdown =
      '/v1/diplomatic-services/analytics/club-card-requests-approvals/status-breakdown';
  static String clubCardApproverMonthlyTrend =
      '/v1/diplomatic-services/analytics/club-card-requests-approvals/monthly-trend';
  static String clubCardCreateRequest =
      '/v1/diplomatic-services/club-card-requests/request';
  static String clubCardApproveReject =
      '/v1/diplomatic-services/club-card-requests/approve';
  static String clubCardMyRequests =
      '/v1/diplomatic-services/club-card-requests/requests';
  static String clubCardApprovalRequests =
      '/v1/diplomatic-services/club-card-requests/requests/for-approval';
  static String clubCardDiplomaticTitle =
      '/v1/diplomatic-services/club-card-requests/diplomatic-titles';

  static String clubCardDetailsById(int id) =>
      '/v1/diplomatic-services/club-card-requests/request/$id';

  /// LMS Services
  static String availableCourses = '/v1/lms-service/courses';
  static String myLmsRequests = '/v1/lms-service/requests';
  static String enrollInCourse = '/v1/lms-service/enroll';
  static String completeCourseModule = '/v1/lms-service/module/complete';

  /// Meeting Management
  static String searchUsers = '/v1/user-service/users';
  static String createDirectChat =
      '/v1/user-service/messaging/conversations/direct';
  static String createGroupChat =
      '/v1/user-service/messaging/conversations/group';
  static String fetchConversations(int userId) =>
      '/v1/user-service/messaging/conversations/$userId';
  static String conversationMessages(int conversionId) =>
      '/v1/user-service/messaging/conversations/$conversionId/messages';
}
