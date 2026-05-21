import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const SelectFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final currentValue = state.values[field.name];

    // 🔑 Build dropdown items correctly
    final items = (field.options ?? [])
        .map(
          (option) => KDropdownItem<dynamic>(
            value: option.value, // actual stored value
            child: Text(option.label), // display label
          ),
        )
        .toList();

    return KDropdownField<dynamic>(
      isRequired: field.required,
      fieldHeadingText: field.label,
      value: currentValue,
      items: items,
      hintText: field.label,
      errorText: state.errors[field.name],
      onChanged: field.disabled
          ? (_) {}
          : (val) {
              notifier.updateValue(field.name, val);
            },
    );
  }
}
