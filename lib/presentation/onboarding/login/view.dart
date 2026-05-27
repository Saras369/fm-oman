import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/onboarding/login/widgets/important_update_card.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:msal_auth/msal_auth.dart';

import '../../../utils/app_extensions/app_extension.dart';
import '../../core_widgets/input_field/mobile_number_input_field.dart';
import '../../core_widgets/input_field/text_field.dart';

part 'controller.dart';
part 'widgets/announcement_card.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    // final state = ref.watch(_vsProvider);
    // final stateController = ref.watch(_vsProvider.notifier);

    return GovtLoginPage();
  }
}
