import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/models/financial_services/bank_name_model.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/screens/home/view.dart';
import 'package:code_setup/repository/data/stationery_repo_impl.dart';
import 'package:code_setup/repository/domain/diplomatic_services/transfer_to_mission_repo.dart';
import 'package:code_setup/repository/domain/financial_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';

@RoutePage()
class CreateTransferToMissionRequestScreen extends ConsumerWidget {
  final int serviceId;
  final int subServiceId;
  late final _VSControllerParams params;

  CreateTransferToMissionRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
  }) {
    params = _VSControllerParams(
      serviceId: serviceId,
      subServiceId: subServiceId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final state = ref.watch(_vsProvider(params));
    final stateController = ref.read(_vsProvider(params).notifier);
    // final statsData = state.statsData;

    return ProviderScope(
      overrides: [
        dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier()),
      ],
      child: DynamicForm(
        stepTitles: const [''],
        steps: [stateController.missionTransferFields],
        onSubmit: (values) {
          debugPrint('FORM SUBMITTED');
          debugPrint(values.toString());
          // Navigator.pop(context);
        },
        title: 'Mission Transfer Request',
      ),
    );
  }
}
