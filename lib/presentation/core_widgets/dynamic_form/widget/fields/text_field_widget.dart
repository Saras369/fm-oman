import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dynamic_field.dart';

class TextFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const TextFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        initialValue: state.values[field.name],
        enabled: !field.disabled,
        hintText: field.placeholder,
        fieldHeadingText: field.label,
        errorText: state.errors[field.name],
        onChanged: (val) => notifier.updateValue(field.name, val),
        isRequired: field.required,
      ),

      // TextFormField(
      //   initialValue: state.values[field.name],
      //   enabled: !field.disabled,
      //   textInputAction: TextInputAction.next,
      //   decoration: InputDecoration(
      //     labelText: field.label,
      //     hintText: field.placeholder,
      //     errorText: state.errors[field.name],
      //   ),
      //   onChanged: (val) => notifier.updateValue(field.name, val),
      // ),
    );
  }
}
