import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/checkbox_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/date_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/file_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/radio_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/select_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/text_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/fields/toggle_field_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/widget/step_header.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicFormState {
  final Map<String, dynamic> values;
  final Map<String, String?> errors;
  final int currentStep;
  const DynamicFormState({
    required this.values,
    required this.errors,
    required this.currentStep,
  });

  DynamicFormState copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    int? currentStep,
  }) {
    return DynamicFormState(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

final dynamicFormProvider =
    StateNotifierProvider<DynamicFormNotifier, DynamicFormState>(
      (ref) => DynamicFormNotifier(),
    );

class DynamicForm extends ConsumerWidget {
  final List<List<DynamicField>> steps;
  final List<String> stepTitles;
  final void Function(Map<String, dynamic>) onSubmit;
  final String title;

  const DynamicForm({
    super.key,
    required this.steps,
    required this.stepTitles,
    required this.onSubmit,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final currentStep = state.currentStep;
    final currentFields = steps[currentStep];
    final isLastStep = currentStep == steps.length - 1;
    final visibleFields = currentFields.where((field) {
      if (field.visibleWhen == null) return true;
      return field.visibleWhen!(state.values);
    }).toList();

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        title: Text(
          'New Request',
          style: TextStyle(
            fontSize: currentTheme.fontSizes.s18,
            fontWeight: currentTheme.fontWeights.wBold,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.toVerticalSizedBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toAutoScaledWidth),
              child: Wrap(
                children: [
                  Text(
                    'Provide details about your $title',
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s15,
                      fontWeight: currentTheme.fontWeights.wRegular,
                      color: Color(0XFF818184),
                    ),
                  ),
                ],
              ),
            ),
            if (steps.length == 1) 20.toVerticalSizedBox,

            if (steps.length > 1)
              Padding(
                padding: const EdgeInsets.all(16),
                child: StepHeader(currentStep: currentStep, steps: stepTitles),
              ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: visibleFields.length,
                itemBuilder: (_, index) {
                  return FieldRenderer(field: visibleFields[index]);
                },
              ),
            ),

            _BottomActionBar(
              showPrevious: currentStep > 0,
              isLast: isLastStep,
              onPrevious: notifier.previousStep,
              onNext: () {
                if (notifier.validateStep(visibleFields)) {
                  notifier.nextStep();
                }
              },
              onSubmit: () {
                if (notifier.validateStep(visibleFields)) {
                  onSubmit(state.values);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final bool showPrevious;
  final bool isLast;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  const _BottomActionBar({
    required this.showPrevious,
    required this.isLast,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Row(
        children: [
          if (showPrevious)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
            ),
          if (showPrevious) const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: isLast ? onSubmit : onNext,
              child: Text(isLast ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldRenderer extends StatelessWidget {
  final DynamicField field;

  const FieldRenderer({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case FieldType.text:
      case FieldType.email:
      case FieldType.number:
      case FieldType.textarea:
        return TextFieldWidget(field: field);

      case FieldType.select:
        return SelectFieldWidget(field: field);

      case FieldType.radio:
        return RadioFieldWidget(field: field);

      case FieldType.checkbox:
      case FieldType.multiselect:
        return CheckboxFieldWidget(field: field);

      case FieldType.date:
      case FieldType.time:
      case FieldType.year:
        return DateFieldWidget(field: field);

      case FieldType.toggle:
        return ToggleFieldWidget(field: field);

      case FieldType.file:
        return FileFieldWidget(field: field);

      case FieldType.rating:
        // You can add RatingFieldWidget later
        return const SizedBox();

      default:
        return const SizedBox.shrink();
    }
  }
}
