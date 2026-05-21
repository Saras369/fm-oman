import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const CheckboxFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final List values = state.values[field.name] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.label),
        ...field.options!.map((opt) {
          final checked = values.contains(opt);
          return CheckboxListTile(
            value: checked,
            title: Text(opt.toString()),
            onChanged: (val) {
              final updated = [...values];
              val == true ? updated.add(opt) : updated.remove(opt);
              notifier.updateValue(field.name, updated);
            },
          );
        }),
      ],
    );
  }
}
