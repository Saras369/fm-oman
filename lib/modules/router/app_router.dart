import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/modules/router/route_names.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  // Singleton instance of AppRouter
  static final AppRouter instance = AppRouter._internal();

  // Private constructor
  AppRouter._internal();

  // Factory constructor to return the singleton instance
  factory AppRouter() => instance;

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: RouteNames.splash, initial: true),
    // AutoRoute(
    //   page: UpdateAttendanceRecordRoute.page,
    //   path: RouteNames.updateAttendanceRecord,
    // ),
    // AutoRoute(
    //   page: LeaveRequestRoute.page,
    //   path: RouteNames.leaveRequestScreen,
    // ),
    AutoRoute(
      page: LeaveRequestDetailsRoute.page,
      path: RouteNames.leaveRequestDetailsScreen,
    ),
    // AutoRoute(page: HolidaysRoute.page, path: RouteNames.holidaysScreen),
    // AutoRoute(page: AppointmentsRoute.page, path: RouteNames.appointmentScreen),
    AutoRoute(
      page: AppointmentDetailsRoute.page,
      path: RouteNames.appointmentDetailsScreen,
    ),
    AutoRoute(page: LoginRoute.page, path: RouteNames.login),
    AutoRoute(
      page: FinancialServicesDashboardRoute.page,
      path: RouteNames.financialServicesDashboard,
    ),
    AutoRoute(page: AllServicesRoute.page, path: RouteNames.allServices),
    AutoRoute(
      page: ProfileDetailsRoute.page,
      path: RouteNames.profileDetailsScreen,
    ),
    AutoRoute(
      page: FinancialServicesDetailsRoute.page,
      path: RouteNames.financialServicesDetails,
    ),
    AutoRoute(
      page: ReimbursementRequestRoute.page,
      path: RouteNames.reimbursementRequestScreen,
    ),
    AutoRoute(
      page: SecurityServicesRoute.page,
      path: RouteNames.securityServicesScreen,
    ),
    AutoRoute(
      page: SecurityServicesDetailsRoute.page,
      path: RouteNames.securityServicesDetailsScreen,
    ),
    AutoRoute(
      page: UpdateAttendanceDetailsRoute.page,
      path: RouteNames.updateAttendanceDetails,
    ),
    AutoRoute(
      page: HelpDeskDetailsRoute.page,
      path: RouteNames.helpdeskDetailsScreen,
    ),
    AutoRoute(
      page: CreateTransferToMissionRequestRoute.page,
      path: RouteNames.createTransferToMissionRequestScreen,
    ),
    AutoRoute(
      page: PassportServiceDetailsRoute.page,
      path: RouteNames.passportServiceDetailsScreen,
    ),
    AutoRoute(
      path: RouteNames.bottomNavigator,
      page: KBottomNavigatorRoute.page,
      children: [
        AutoRoute(page: UpdateAttendanceRecordRoute.page),
        AutoRoute(page: LeaveRequestRoute.page),
        AutoRoute(page: HolidaysRoute.page),
        AutoRoute(page: AppointmentsRoute.page),
      ],
    ),

    AutoRoute(
      path: RouteNames.home,
      page: HomeRoute.page,
      children: [
        AutoRoute(page: MyProfileRoute.page),
        AutoRoute(page: AllServicesRoute.page),
        AutoRoute(page: ImportantLinksRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(
      path: RouteNames.helpdeskMenuScreen,
      page: HelpDeskMenuRoute.page,
      children: [
        AutoRoute(page: HelpDeskDashboardRoute.page),
        AutoRoute(page: HelpDeskRequestPortalRoute.page),
        AutoRoute(page: TelephoneDirectoryRoute.page),
        AutoRoute(page: StationeryRequestRoute.page),
      ],
    ),
    AutoRoute(
      path: RouteNames.diplomaticServicesScreen,
      page: DiplomaticServicesRoute.page,
      children: [
        // AutoRoute(page: HelpDeskDashboardRoute.page),
        AutoRoute(page: TransferToMissionRoute.page),
        AutoRoute(page: DiplomaticClubCardRoute.page),
        AutoRoute(page: ParcelServicesRequestRoute.page),
        AutoRoute(page: RegisterVacancyRoute.page),
        AutoRoute(page: RequestForPassportRoute.page),
        // AutoRoute(page: TelephoneDirectoryRoute.page),
        // AutoRoute(page: StationeryRequestRoute.page),
      ],
    ),
    AutoRoute(
      path: RouteNames.meetingManagementScreen,
      page: MeetingManagementRoute.page,
      children: [AutoRoute(page: CollaborationRoute.page)],
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
