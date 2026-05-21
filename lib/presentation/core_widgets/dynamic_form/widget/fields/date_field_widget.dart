import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const DateFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dynamicFormProvider.notifier);
    final state = ref.watch(dynamicFormProvider);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    Future<int?> showYearPickerDialog(
      BuildContext context, {
      required int initialYear,
      int startYear = 1900,
      int endYear = 2100,
    }) {
      return showDialog<int>(
        context: context,
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: currentTheme
                    .colors
                    .primary, // 👈 highlighted year background
                onPrimary: currentTheme.colors.onPrimary, // 👈 year text color
              ),
            ),
            child: AlertDialog(
              title: const Text('Select Year'),
              content: SizedBox(
                height: 300,
                width: 300,
                child: YearPicker(
                  firstDate: DateTime(startYear),
                  lastDate: DateTime(endYear),
                  selectedDate: DateTime(initialYear),
                  onChanged: (date) {
                    Navigator.pop(context, date.year);
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: KTextField(
        controller: TextEditingController(
          text: state.values[field.name]?.toString() ?? '',
        ),
        isRequired: field.required,
        initialValue: state.values[field.name],
        readOnly: true,
        enabled: !field.disabled,
        hintText: field.placeholder,
        fieldHeadingText: field.label,
        errorText: state.errors[field.name],
        suffixIcon: const Icon(Icons.calendar_today),

        onTap: () async {
          if (field.type == FieldType.year) {
            final year = await showYearPickerDialog(
              context,
              initialYear: state.values[field.name] != null
                  ? int.parse(state.values[field.name])
                  : DateTime.now().year,
            );
            if (year != null) {
              notifier.updateValue(field.name, year.toString());
            }
          }

          if (field.type == FieldType.date) {
            final pickedDate = await KAppX.extendedRouter.showKDatePicker(
              context: KAppX.currentContext,
              initialDate: state.values[field.name] != null
                  ? DateTime.parse(state.values[field.name])
                  : DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              final selectedDate = pickedDate.formattedDateAsYearMonthDate;

              notifier.updateValue(field.name, selectedDate);
            }
          }
        },
      ),
    );
  }
}
