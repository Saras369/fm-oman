// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i39;
import 'package:code_setup/modules/data/models/all_services_model.dart' as _i41;
import 'package:code_setup/presentation/onboarding/login/view.dart' as _i20;
import 'package:code_setup/presentation/onboarding/splash/view.dart' as _i32;
import 'package:code_setup/presentation/screens/appointment_details/view.dart'
    as _i2;
import 'package:code_setup/presentation/screens/appointments/view.dart' as _i3;
import 'package:code_setup/presentation/screens/attendance/attendance_details/view.dart'
    as _i37;
import 'package:code_setup/presentation/screens/attendance/update_attendance_record/view.dart'
    as _i38;
import 'package:code_setup/presentation/screens/bottom_navigator/view.dart'
    as _i17;
import 'package:code_setup/presentation/screens/diplomatic_services/diplomatic_club_card/view.dart'
    as _i6;
import 'package:code_setup/presentation/screens/diplomatic_services/parcel_services/view.dart'
    as _i23;
import 'package:code_setup/presentation/screens/diplomatic_services/register_vacancy/view.dart'
    as _i26;
import 'package:code_setup/presentation/screens/diplomatic_services/request_for_passport/passport_service_details/view.dart'
    as _i24;
import 'package:code_setup/presentation/screens/diplomatic_services/request_for_passport/view.dart'
    as _i28;
import 'package:code_setup/presentation/screens/diplomatic_services/transfer_to_mission/create_mission_transfer_request/view.dart'
    as _i5;
import 'package:code_setup/presentation/screens/diplomatic_services/transfer_to_mission/view.dart'
    as _i36;
import 'package:code_setup/presentation/screens/diplomatic_services/view.dart'
    as _i7;
import 'package:code_setup/presentation/screens/financial_services/dashboard/view.dart'
    as _i8;
import 'package:code_setup/presentation/screens/financial_services/financial_services_details/view.dart'
    as _i9;
import 'package:code_setup/presentation/screens/financial_services/reimbursement_request/view.dart'
    as _i27;
import 'package:code_setup/presentation/screens/general_services/helpdesk/dashboard/view.dart'
    as _i10;
import 'package:code_setup/presentation/screens/general_services/helpdesk/help_desk_details/view.dart'
    as _i11;
import 'package:code_setup/presentation/screens/general_services/helpdesk/request_portal/view.dart'
    as _i13;
import 'package:code_setup/presentation/screens/general_services/helpdesk/view.dart'
    as _i12;
import 'package:code_setup/presentation/screens/general_services/stationery/view.dart'
    as _i33;
import 'package:code_setup/presentation/screens/general_services/telephone_directory/view.dart'
    as _i35;
import 'package:code_setup/presentation/screens/holidays_list/view.dart'
    as _i14;
import 'package:code_setup/presentation/screens/home/all_services/view.dart'
    as _i1;
import 'package:code_setup/presentation/screens/home/links/view.dart' as _i16;
import 'package:code_setup/presentation/screens/home/my_profile_page/view.dart'
    as _i22;
import 'package:code_setup/presentation/screens/home/settings/view.dart'
    as _i31;
import 'package:code_setup/presentation/screens/home/view.dart' as _i15;
import 'package:code_setup/presentation/screens/leave_request/view.dart'
    as _i19;
import 'package:code_setup/presentation/screens/leave_request_details/view.dart'
    as _i18;
import 'package:code_setup/presentation/screens/meeting_management/collaboration/view.dart'
    as _i4;
import 'package:code_setup/presentation/screens/meeting_management/view.dart'
    as _i21;
import 'package:code_setup/presentation/screens/profile_details/view.dart'
    as _i25;
import 'package:code_setup/presentation/screens/security_services/details/view.dart'
    as _i29;
import 'package:code_setup/presentation/screens/security_services/view.dart'
    as _i30;
import 'package:code_setup/presentation/screens/stay_after_working_hours/view.dart'
    as _i34;
import 'package:collection/collection.dart' as _i42;
import 'package:flutter/material.dart' as _i40;

/// generated route for
/// [_i1.AllServicesPage]
class AllServicesRoute extends _i39.PageRouteInfo<void> {
  const AllServicesRoute({List<_i39.PageRouteInfo>? children})
    : super(AllServicesRoute.name, initialChildren: children);

  static const String name = 'AllServicesRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i1.AllServicesPage();
    },
  );
}

/// generated route for
/// [_i2.AppointmentDetailsScreen]
class AppointmentDetailsRoute extends _i39.PageRouteInfo<void> {
  const AppointmentDetailsRoute({List<_i39.PageRouteInfo>? children})
    : super(AppointmentDetailsRoute.name, initialChildren: children);

  static const String name = 'AppointmentDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppointmentDetailsScreen();
    },
  );
}

/// generated route for
/// [_i3.AppointmentsScreen]
class AppointmentsRoute extends _i39.PageRouteInfo<void> {
  const AppointmentsRoute({List<_i39.PageRouteInfo>? children})
    : super(AppointmentsRoute.name, initialChildren: children);

  static const String name = 'AppointmentsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i3.AppointmentsScreen();
    },
  );
}

/// generated route for
/// [_i4.CollaborationScreen]
class CollaborationRoute extends _i39.PageRouteInfo<CollaborationRouteArgs> {
  CollaborationRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         CollaborationRoute.name,
         args: CollaborationRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'CollaborationRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollaborationRouteArgs>();
      return _i4.CollaborationScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class CollaborationRouteArgs {
  const CollaborationRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'CollaborationRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CollaborationRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i5.CreateTransferToMissionRequestScreen]
class CreateTransferToMissionRequestRoute
    extends _i39.PageRouteInfo<CreateTransferToMissionRequestRouteArgs> {
  CreateTransferToMissionRequestRoute({
    _i40.Key? key,
    required int serviceId,
    required int subServiceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         CreateTransferToMissionRequestRoute.name,
         args: CreateTransferToMissionRequestRouteArgs(
           key: key,
           serviceId: serviceId,
           subServiceId: subServiceId,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateTransferToMissionRequestRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateTransferToMissionRequestRouteArgs>();
      return _i5.CreateTransferToMissionRequestScreen(
        key: args.key,
        serviceId: args.serviceId,
        subServiceId: args.subServiceId,
      );
    },
  );
}

class CreateTransferToMissionRequestRouteArgs {
  const CreateTransferToMissionRequestRouteArgs({
    this.key,
    required this.serviceId,
    required this.subServiceId,
  });

  final _i40.Key? key;

  final int serviceId;

  final int subServiceId;

  @override
  String toString() {
    return 'CreateTransferToMissionRequestRouteArgs{key: $key, serviceId: $serviceId, subServiceId: $subServiceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateTransferToMissionRequestRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        subServiceId == other.subServiceId;
  }

  @override
  int get hashCode => key.hashCode ^ serviceId.hashCode ^ subServiceId.hashCode;
}

/// generated route for
/// [_i6.DiplomaticClubCardScreen]
class DiplomaticClubCardRoute
    extends _i39.PageRouteInfo<DiplomaticClubCardRouteArgs> {
  DiplomaticClubCardRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         DiplomaticClubCardRoute.name,
         args: DiplomaticClubCardRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'DiplomaticClubCardRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DiplomaticClubCardRouteArgs>();
      return _i6.DiplomaticClubCardScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class DiplomaticClubCardRouteArgs {
  const DiplomaticClubCardRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'DiplomaticClubCardRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DiplomaticClubCardRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i7.DiplomaticServicesScreen]
class DiplomaticServicesRoute
    extends _i39.PageRouteInfo<DiplomaticServicesRouteArgs> {
  DiplomaticServicesRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         DiplomaticServicesRoute.name,
         args: DiplomaticServicesRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'DiplomaticServicesRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DiplomaticServicesRouteArgs>();
      return _i7.DiplomaticServicesScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class DiplomaticServicesRouteArgs {
  const DiplomaticServicesRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'DiplomaticServicesRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DiplomaticServicesRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i8.FinancialServicesDashboardPage]
class FinancialServicesDashboardRoute
    extends _i39.PageRouteInfo<FinancialServicesDashboardRouteArgs> {
  FinancialServicesDashboardRoute({
    _i40.Key? key,
    required int serviceId,
    required List<_i41.SubServices> subServiceList,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         FinancialServicesDashboardRoute.name,
         args: FinancialServicesDashboardRouteArgs(
           key: key,
           serviceId: serviceId,
           subServiceList: subServiceList,
         ),
         initialChildren: children,
       );

  static const String name = 'FinancialServicesDashboardRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FinancialServicesDashboardRouteArgs>();
      return _i8.FinancialServicesDashboardPage(
        key: args.key,
        serviceId: args.serviceId,
        subServiceList: args.subServiceList,
      );
    },
  );
}

class FinancialServicesDashboardRouteArgs {
  const FinancialServicesDashboardRouteArgs({
    this.key,
    required this.serviceId,
    required this.subServiceList,
  });

  final _i40.Key? key;

  final int serviceId;

  final List<_i41.SubServices> subServiceList;

  @override
  String toString() {
    return 'FinancialServicesDashboardRouteArgs{key: $key, serviceId: $serviceId, subServiceList: $subServiceList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FinancialServicesDashboardRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServiceList,
          other.subServiceList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      serviceId.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServiceList);
}

/// generated route for
/// [_i9.FinancialServicesDetailsScreen]
class FinancialServicesDetailsRoute
    extends _i39.PageRouteInfo<FinancialServicesDetailsRouteArgs> {
  FinancialServicesDetailsRoute({
    _i40.Key? key,
    required int requestId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         FinancialServicesDetailsRoute.name,
         args: FinancialServicesDetailsRouteArgs(
           key: key,
           requestId: requestId,
         ),
         initialChildren: children,
       );

  static const String name = 'FinancialServicesDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FinancialServicesDetailsRouteArgs>();
      return _i9.FinancialServicesDetailsScreen(
        key: args.key,
        requestId: args.requestId,
      );
    },
  );
}

class FinancialServicesDetailsRouteArgs {
  const FinancialServicesDetailsRouteArgs({this.key, required this.requestId});

  final _i40.Key? key;

  final int requestId;

  @override
  String toString() {
    return 'FinancialServicesDetailsRouteArgs{key: $key, requestId: $requestId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FinancialServicesDetailsRouteArgs) return false;
    return key == other.key && requestId == other.requestId;
  }

  @override
  int get hashCode => key.hashCode ^ requestId.hashCode;
}

/// generated route for
/// [_i10.HelpDeskDashboardScreen]
class HelpDeskDashboardRoute extends _i39.PageRouteInfo<void> {
  const HelpDeskDashboardRoute({List<_i39.PageRouteInfo>? children})
    : super(HelpDeskDashboardRoute.name, initialChildren: children);

  static const String name = 'HelpDeskDashboardRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i10.HelpDeskDashboardScreen();
    },
  );
}

/// generated route for
/// [_i11.HelpDeskDetailsScreen]
class HelpDeskDetailsRoute
    extends _i39.PageRouteInfo<HelpDeskDetailsRouteArgs> {
  HelpDeskDetailsRoute({
    _i40.Key? key,
    required int requestId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         HelpDeskDetailsRoute.name,
         args: HelpDeskDetailsRouteArgs(key: key, requestId: requestId),
         initialChildren: children,
       );

  static const String name = 'HelpDeskDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HelpDeskDetailsRouteArgs>();
      return _i11.HelpDeskDetailsScreen(
        key: args.key,
        requestId: args.requestId,
      );
    },
  );
}

class HelpDeskDetailsRouteArgs {
  const HelpDeskDetailsRouteArgs({this.key, required this.requestId});

  final _i40.Key? key;

  final int requestId;

  @override
  String toString() {
    return 'HelpDeskDetailsRouteArgs{key: $key, requestId: $requestId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HelpDeskDetailsRouteArgs) return false;
    return key == other.key && requestId == other.requestId;
  }

  @override
  int get hashCode => key.hashCode ^ requestId.hashCode;
}

/// generated route for
/// [_i12.HelpDeskMenuScreen]
class HelpDeskMenuRoute extends _i39.PageRouteInfo<HelpDeskMenuRouteArgs> {
  HelpDeskMenuRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         HelpDeskMenuRoute.name,
         args: HelpDeskMenuRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'HelpDeskMenuRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HelpDeskMenuRouteArgs>();
      return _i12.HelpDeskMenuScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class HelpDeskMenuRouteArgs {
  const HelpDeskMenuRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'HelpDeskMenuRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HelpDeskMenuRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i13.HelpDeskRequestPortalScreen]
class HelpDeskRequestPortalRoute
    extends _i39.PageRouteInfo<HelpDeskRequestPortalRouteArgs> {
  HelpDeskRequestPortalRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         HelpDeskRequestPortalRoute.name,
         args: HelpDeskRequestPortalRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'HelpDeskRequestPortalRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HelpDeskRequestPortalRouteArgs>();
      return _i13.HelpDeskRequestPortalScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class HelpDeskRequestPortalRouteArgs {
  const HelpDeskRequestPortalRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'HelpDeskRequestPortalRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HelpDeskRequestPortalRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i14.HolidaysScreen]
class HolidaysRoute extends _i39.PageRouteInfo<void> {
  const HolidaysRoute({List<_i39.PageRouteInfo>? children})
    : super(HolidaysRoute.name, initialChildren: children);

  static const String name = 'HolidaysRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i14.HolidaysScreen();
    },
  );
}

/// generated route for
/// [_i15.HomePage]
class HomeRoute extends _i39.PageRouteInfo<void> {
  const HomeRoute({List<_i39.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i15.HomePage();
    },
  );
}

/// generated route for
/// [_i16.ImportantLinksScreen]
class ImportantLinksRoute extends _i39.PageRouteInfo<void> {
  const ImportantLinksRoute({List<_i39.PageRouteInfo>? children})
    : super(ImportantLinksRoute.name, initialChildren: children);

  static const String name = 'ImportantLinksRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i16.ImportantLinksScreen();
    },
  );
}

/// generated route for
/// [_i17.KBottomNavigatorScreen]
class KBottomNavigatorRoute
    extends _i39.PageRouteInfo<KBottomNavigatorRouteArgs> {
  KBottomNavigatorRoute({
    _i40.Key? key,
    int serviceId = 0,
    List<_i41.SubServices> subServicesList = const [],
    List<_i39.PageRouteInfo>? children,
  }) : super(
         KBottomNavigatorRoute.name,
         args: KBottomNavigatorRouteArgs(
           key: key,
           serviceId: serviceId,
           subServicesList: subServicesList,
         ),
         initialChildren: children,
       );

  static const String name = 'KBottomNavigatorRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KBottomNavigatorRouteArgs>(
        orElse: () => const KBottomNavigatorRouteArgs(),
      );
      return _i17.KBottomNavigatorScreen(
        key: args.key,
        serviceId: args.serviceId,
        subServicesList: args.subServicesList,
      );
    },
  );
}

class KBottomNavigatorRouteArgs {
  const KBottomNavigatorRouteArgs({
    this.key,
    this.serviceId = 0,
    this.subServicesList = const [],
  });

  final _i40.Key? key;

  final int serviceId;

  final List<_i41.SubServices> subServicesList;

  @override
  String toString() {
    return 'KBottomNavigatorRouteArgs{key: $key, serviceId: $serviceId, subServicesList: $subServicesList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! KBottomNavigatorRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      serviceId.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList);
}

/// generated route for
/// [_i18.LeaveRequestDetailsScreen]
class LeaveRequestDetailsRoute
    extends _i39.PageRouteInfo<LeaveRequestDetailsRouteArgs> {
  LeaveRequestDetailsRoute({
    _i40.Key? key,
    required int requestId,
    bool isFromActionItems = false,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         LeaveRequestDetailsRoute.name,
         args: LeaveRequestDetailsRouteArgs(
           key: key,
           requestId: requestId,
           isFromActionItems: isFromActionItems,
         ),
         initialChildren: children,
       );

  static const String name = 'LeaveRequestDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LeaveRequestDetailsRouteArgs>();
      return _i18.LeaveRequestDetailsScreen(
        key: args.key,
        requestId: args.requestId,
        isFromActionItems: args.isFromActionItems,
      );
    },
  );
}

class LeaveRequestDetailsRouteArgs {
  const LeaveRequestDetailsRouteArgs({
    this.key,
    required this.requestId,
    this.isFromActionItems = false,
  });

  final _i40.Key? key;

  final int requestId;

  final bool isFromActionItems;

  @override
  String toString() {
    return 'LeaveRequestDetailsRouteArgs{key: $key, requestId: $requestId, isFromActionItems: $isFromActionItems}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LeaveRequestDetailsRouteArgs) return false;
    return key == other.key &&
        requestId == other.requestId &&
        isFromActionItems == other.isFromActionItems;
  }

  @override
  int get hashCode => Object.hash(key, requestId, isFromActionItems);
}

/// generated route for
/// [_i19.LeaveRequestScreen]
class LeaveRequestRoute extends _i39.PageRouteInfo<LeaveRequestRouteArgs> {
  LeaveRequestRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         LeaveRequestRoute.name,
         args: LeaveRequestRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'LeaveRequestRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LeaveRequestRouteArgs>();
      return _i19.LeaveRequestScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class LeaveRequestRouteArgs {
  const LeaveRequestRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'LeaveRequestRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LeaveRequestRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i20.LoginScreen]
class LoginRoute extends _i39.PageRouteInfo<void> {
  const LoginRoute({List<_i39.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i20.LoginScreen();
    },
  );
}

/// generated route for
/// [_i21.MeetingManagementScreen]
class MeetingManagementRoute
    extends _i39.PageRouteInfo<MeetingManagementRouteArgs> {
  MeetingManagementRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         MeetingManagementRoute.name,
         args: MeetingManagementRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'MeetingManagementRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MeetingManagementRouteArgs>();
      return _i21.MeetingManagementScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class MeetingManagementRouteArgs {
  const MeetingManagementRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'MeetingManagementRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MeetingManagementRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i22.MyProfilePage]
class MyProfileRoute extends _i39.PageRouteInfo<void> {
  const MyProfileRoute({List<_i39.PageRouteInfo>? children})
    : super(MyProfileRoute.name, initialChildren: children);

  static const String name = 'MyProfileRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i22.MyProfilePage();
    },
  );
}

/// generated route for
/// [_i23.ParcelServicesRequestScreen]
class ParcelServicesRequestRoute
    extends _i39.PageRouteInfo<ParcelServicesRequestRouteArgs> {
  ParcelServicesRequestRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ParcelServicesRequestRoute.name,
         args: ParcelServicesRequestRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'ParcelServicesRequestRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ParcelServicesRequestRouteArgs>();
      return _i23.ParcelServicesRequestScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class ParcelServicesRequestRouteArgs {
  const ParcelServicesRequestRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'ParcelServicesRequestRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ParcelServicesRequestRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i24.PassportServiceDetailsScreen]
class PassportServiceDetailsRoute
    extends _i39.PageRouteInfo<PassportServiceDetailsRouteArgs> {
  PassportServiceDetailsRoute({
    _i40.Key? key,
    required int requestId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         PassportServiceDetailsRoute.name,
         args: PassportServiceDetailsRouteArgs(key: key, requestId: requestId),
         initialChildren: children,
       );

  static const String name = 'PassportServiceDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PassportServiceDetailsRouteArgs>();
      return _i24.PassportServiceDetailsScreen(
        key: args.key,
        requestId: args.requestId,
      );
    },
  );
}

class PassportServiceDetailsRouteArgs {
  const PassportServiceDetailsRouteArgs({this.key, required this.requestId});

  final _i40.Key? key;

  final int requestId;

  @override
  String toString() {
    return 'PassportServiceDetailsRouteArgs{key: $key, requestId: $requestId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PassportServiceDetailsRouteArgs) return false;
    return key == other.key && requestId == other.requestId;
  }

  @override
  int get hashCode => key.hashCode ^ requestId.hashCode;
}

/// generated route for
/// [_i25.ProfileDetailsScreen]
class ProfileDetailsRoute extends _i39.PageRouteInfo<void> {
  const ProfileDetailsRoute({List<_i39.PageRouteInfo>? children})
    : super(ProfileDetailsRoute.name, initialChildren: children);

  static const String name = 'ProfileDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i25.ProfileDetailsScreen();
    },
  );
}

/// generated route for
/// [_i26.RegisterVacancyScreen]
class RegisterVacancyRoute
    extends _i39.PageRouteInfo<RegisterVacancyRouteArgs> {
  RegisterVacancyRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         RegisterVacancyRoute.name,
         args: RegisterVacancyRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'RegisterVacancyRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterVacancyRouteArgs>();
      return _i26.RegisterVacancyScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class RegisterVacancyRouteArgs {
  const RegisterVacancyRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'RegisterVacancyRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterVacancyRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i27.ReimbursementRequestScreen]
class ReimbursementRequestRoute
    extends _i39.PageRouteInfo<ReimbursementRequestRouteArgs> {
  ReimbursementRequestRoute({
    _i40.Key? key,
    required int serviceId,
    required int subServiceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ReimbursementRequestRoute.name,
         args: ReimbursementRequestRouteArgs(
           key: key,
           serviceId: serviceId,
           subServiceId: subServiceId,
         ),
         initialChildren: children,
       );

  static const String name = 'ReimbursementRequestRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReimbursementRequestRouteArgs>();
      return _i27.ReimbursementRequestScreen(
        key: args.key,
        serviceId: args.serviceId,
        subServiceId: args.subServiceId,
      );
    },
  );
}

class ReimbursementRequestRouteArgs {
  const ReimbursementRequestRouteArgs({
    this.key,
    required this.serviceId,
    required this.subServiceId,
  });

  final _i40.Key? key;

  final int serviceId;

  final int subServiceId;

  @override
  String toString() {
    return 'ReimbursementRequestRouteArgs{key: $key, serviceId: $serviceId, subServiceId: $subServiceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReimbursementRequestRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        subServiceId == other.subServiceId;
  }

  @override
  int get hashCode => key.hashCode ^ serviceId.hashCode ^ subServiceId.hashCode;
}

/// generated route for
/// [_i28.RequestForPassportScreen]
class RequestForPassportRoute
    extends _i39.PageRouteInfo<RequestForPassportRouteArgs> {
  RequestForPassportRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         RequestForPassportRoute.name,
         args: RequestForPassportRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'RequestForPassportRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestForPassportRouteArgs>();
      return _i28.RequestForPassportScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class RequestForPassportRouteArgs {
  const RequestForPassportRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'RequestForPassportRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RequestForPassportRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i29.SecurityServicesDetailsScreen]
class SecurityServicesDetailsRoute
    extends _i39.PageRouteInfo<SecurityServicesDetailsRouteArgs> {
  SecurityServicesDetailsRoute({
    _i40.Key? key,
    required int requestId,
    required String slug,
    required String title,
    bool isFromActionItems = false,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         SecurityServicesDetailsRoute.name,
         args: SecurityServicesDetailsRouteArgs(
           key: key,
           requestId: requestId,
           slug: slug,
           title: title,
           isFromActionItems: isFromActionItems,
         ),
         initialChildren: children,
       );

  static const String name = 'SecurityServicesDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecurityServicesDetailsRouteArgs>();
      return _i29.SecurityServicesDetailsScreen(
        key: args.key,
        requestId: args.requestId,
        slug: args.slug,
        title: args.title,
        isFromActionItems: args.isFromActionItems,
      );
    },
  );
}

class SecurityServicesDetailsRouteArgs {
  const SecurityServicesDetailsRouteArgs({
    this.key,
    required this.requestId,
    required this.slug,
    required this.title,
    this.isFromActionItems = false,
  });

  final _i40.Key? key;

  final int requestId;

  final String slug;

  final String title;

  final bool isFromActionItems;

  @override
  String toString() {
    return 'SecurityServicesDetailsRouteArgs{key: $key, requestId: $requestId, slug: $slug, title: $title, isFromActionItems: $isFromActionItems}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SecurityServicesDetailsRouteArgs) return false;
    return key == other.key &&
        requestId == other.requestId &&
        slug == other.slug &&
        title == other.title &&
        isFromActionItems == other.isFromActionItems;
  }

  @override
  int get hashCode => Object.hash(
    key,
    requestId,
    slug,
    title,
    isFromActionItems,
  );
}

/// generated route for
/// [_i30.SecurityServicesScreen]
class SecurityServicesRoute
    extends _i39.PageRouteInfo<SecurityServicesRouteArgs> {
  SecurityServicesRoute({
    _i40.Key? key,
    required int serviceId,
    required List<_i41.SubServices> subServicesList,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         SecurityServicesRoute.name,
         args: SecurityServicesRouteArgs(
           key: key,
           serviceId: serviceId,
           subServicesList: subServicesList,
         ),
         initialChildren: children,
       );

  static const String name = 'SecurityServicesRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecurityServicesRouteArgs>();
      return _i30.SecurityServicesScreen(
        key: args.key,
        serviceId: args.serviceId,
        subServicesList: args.subServicesList,
      );
    },
  );
}

class SecurityServicesRouteArgs {
  const SecurityServicesRouteArgs({
    this.key,
    required this.serviceId,
    required this.subServicesList,
  });

  final _i40.Key? key;

  final int serviceId;

  final List<_i41.SubServices> subServicesList;

  @override
  String toString() {
    return 'SecurityServicesRouteArgs{key: $key, serviceId: $serviceId, subServicesList: $subServicesList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SecurityServicesRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      serviceId.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList);
}

/// generated route for
/// [_i31.SettingsScreen]
class SettingsRoute extends _i39.PageRouteInfo<void> {
  const SettingsRoute({List<_i39.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i31.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i32.SplashScreen]
class SplashRoute extends _i39.PageRouteInfo<void> {
  const SplashRoute({List<_i39.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i32.SplashScreen();
    },
  );
}

/// generated route for
/// [_i33.StationeryRequestScreen]
class StationeryRequestRoute
    extends _i39.PageRouteInfo<StationeryRequestRouteArgs> {
  StationeryRequestRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         StationeryRequestRoute.name,
         args: StationeryRequestRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'StationeryRequestRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StationeryRequestRouteArgs>();
      return _i33.StationeryRequestScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class StationeryRequestRouteArgs {
  const StationeryRequestRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'StationeryRequestRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StationeryRequestRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i34.StayAfterWorkingHoursScreen]
class StayAfterWorkingHoursRoute
    extends _i39.PageRouteInfo<StayAfterWorkingHoursRouteArgs> {
  StayAfterWorkingHoursRoute({
    _i40.Key? key,
    required int serviceId,
    required List<_i41.SubServices> subServicesList,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         StayAfterWorkingHoursRoute.name,
         args: StayAfterWorkingHoursRouteArgs(
           key: key,
           serviceId: serviceId,
           subServicesList: subServicesList,
         ),
         initialChildren: children,
       );

  static const String name = 'StayAfterWorkingHoursRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StayAfterWorkingHoursRouteArgs>();
      return _i34.StayAfterWorkingHoursScreen(
        key: args.key,
        serviceId: args.serviceId,
        subServicesList: args.subServicesList,
      );
    },
  );
}

class StayAfterWorkingHoursRouteArgs {
  const StayAfterWorkingHoursRouteArgs({
    this.key,
    required this.serviceId,
    required this.subServicesList,
  });

  final _i40.Key? key;

  final int serviceId;

  final List<_i41.SubServices> subServicesList;

  @override
  String toString() {
    return 'StayAfterWorkingHoursRouteArgs{key: $key, serviceId: $serviceId, subServicesList: $subServicesList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StayAfterWorkingHoursRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      serviceId.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList);
}

/// generated route for
/// [_i35.TelephoneDirectoryScreen]
class TelephoneDirectoryRoute extends _i39.PageRouteInfo<void> {
  const TelephoneDirectoryRoute({List<_i39.PageRouteInfo>? children})
    : super(TelephoneDirectoryRoute.name, initialChildren: children);

  static const String name = 'TelephoneDirectoryRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i35.TelephoneDirectoryScreen();
    },
  );
}

/// generated route for
/// [_i36.TransferToMissionScreen]
class TransferToMissionRoute
    extends _i39.PageRouteInfo<TransferToMissionRouteArgs> {
  TransferToMissionRoute({
    _i40.Key? key,
    required List<_i41.SubServices> subServicesList,
    required int serviceId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         TransferToMissionRoute.name,
         args: TransferToMissionRouteArgs(
           key: key,
           subServicesList: subServicesList,
           serviceId: serviceId,
         ),
         initialChildren: children,
       );

  static const String name = 'TransferToMissionRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransferToMissionRouteArgs>();
      return _i36.TransferToMissionScreen(
        key: args.key,
        subServicesList: args.subServicesList,
        serviceId: args.serviceId,
      );
    },
  );
}

class TransferToMissionRouteArgs {
  const TransferToMissionRouteArgs({
    this.key,
    required this.subServicesList,
    required this.serviceId,
  });

  final _i40.Key? key;

  final List<_i41.SubServices> subServicesList;

  final int serviceId;

  @override
  String toString() {
    return 'TransferToMissionRouteArgs{key: $key, subServicesList: $subServicesList, serviceId: $serviceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransferToMissionRouteArgs) return false;
    return key == other.key &&
        const _i42.ListEquality<_i41.SubServices>().equals(
          subServicesList,
          other.subServicesList,
        ) &&
        serviceId == other.serviceId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i42.ListEquality<_i41.SubServices>().hash(subServicesList) ^
      serviceId.hashCode;
}

/// generated route for
/// [_i37.UpdateAttendanceDetailsScreen]
class UpdateAttendanceDetailsRoute
    extends _i39.PageRouteInfo<UpdateAttendanceDetailsRouteArgs> {
  UpdateAttendanceDetailsRoute({
    _i40.Key? key,
    required int requestId,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         UpdateAttendanceDetailsRoute.name,
         args: UpdateAttendanceDetailsRouteArgs(key: key, requestId: requestId),
         initialChildren: children,
       );

  static const String name = 'UpdateAttendanceDetailsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateAttendanceDetailsRouteArgs>();
      return _i37.UpdateAttendanceDetailsScreen(
        key: args.key,
        requestId: args.requestId,
      );
    },
  );
}

class UpdateAttendanceDetailsRouteArgs {
  const UpdateAttendanceDetailsRouteArgs({this.key, required this.requestId});

  final _i40.Key? key;

  final int requestId;

  @override
  String toString() {
    return 'UpdateAttendanceDetailsRouteArgs{key: $key, requestId: $requestId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UpdateAttendanceDetailsRouteArgs) return false;
    return key == other.key && requestId == other.requestId;
  }

  @override
  int get hashCode => key.hashCode ^ requestId.hashCode;
}

/// generated route for
/// [_i38.UpdateAttendanceRecordScreen]
class UpdateAttendanceRecordRoute extends _i39.PageRouteInfo<void> {
  const UpdateAttendanceRecordRoute({List<_i39.PageRouteInfo>? children})
    : super(UpdateAttendanceRecordRoute.name, initialChildren: children);

  static const String name = 'UpdateAttendanceRecordRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i38.UpdateAttendanceRecordScreen();
    },
  );
}
