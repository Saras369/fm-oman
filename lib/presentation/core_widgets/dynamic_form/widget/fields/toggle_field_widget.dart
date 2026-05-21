import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const ToggleFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    return SwitchListTile(
      title: Text(field.label),
      value: state.values[field.name] ?? false,
      onChanged: field.disabled
          ? null
          : (val) => notifier.updateValue(field.name, val),
    );
  }
}
