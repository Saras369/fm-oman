import 'dart:async';

import 'package:code_setup/modules/domain/core/connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../modules/data/core/network/network.dart';
import '../../modules/domain/core/network/network.dart';
import '../../modules/domain/core/theme/theme.dart';
import '../../modules/router/app_router.dart';
import '../../presentation/core_widgets/bottom_sheet_drager.dart';

part 'extended_router/extended_router.dart';
part 'extended_router/routes/bottom_sheet.dart';
part 'extended_router/routes/dialog.dart';
// part 'onboarding/onboarding.dart';
// part 'profile/profile.dart';
// part 'profile/profile_controller.dart';
part 'services/service/haptics.dart';
// part 'services/service/time.dart';
part 'services/services.dart';
part 'settings/app_setting.dart';
part 'settings/theme/theme.dart';
part 'settings/theme/theme_provider.dart';

final kProviderContainer = ProviderContainer();

/// Add global-providers or services shortcut for easy accessibility
class KAppX {
  KAppX._();

  static final globalProvider = kProviderContainer;
  static final router = AppRouter.instance;

  static BuildContext? get currentContext => router.navigatorKey.currentContext;

  // static final KRouterBoxImpl router = KRouterBox.instance;

  static final KThemeSetting theme = KThemeSetting._();

  static final KServices services = KServices._();

  // static KLocalizer localizer = KLocalizer._();

  // static KPermissionBox permission = KPermissionsBoxImpl();

  static KNetworkingBoxImpl network = KNetworkingBox.instance;

  // ADD THIS LINE:
  static final KConnectivity connectivity = KConnectivity.instance;

  static KExtendedRouter extendedRouter = KExtendedRouter._();
}
