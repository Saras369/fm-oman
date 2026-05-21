import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/buttons/text_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/leave_request/view.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

part 'widgets/appointment_header.dart';
part 'widgets/apppointment_card.dart';
part 'widgets/appointment_action_card.dart';

@RoutePage()
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        foregroundColor: currentTheme.colors.onPrimary,
        title: Text(
          '   Appointments',
          style: TextStyle(color: currentTheme.colors.onPrimary),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [AppointmentHeader()]),
        ),
      ),
    );
  }
}
