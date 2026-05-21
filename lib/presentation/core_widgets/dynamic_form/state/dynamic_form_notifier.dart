import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicFormNotifier extends StateNotifier<DynamicFormState> {
  DynamicFormNotifier()
    : super(const DynamicFormState(currentStep: 0, values: {}, errors: {})) {
    print('🔥 DynamicFormNotifier CREATED');
  }

  /// Call ONCE when form starts
  void initialize(List<List<DynamicField>> steps) {
    final allFields = steps.expand((e) => e);
    final initialValues = <String, dynamic>{};

    for (final field in allFields) {
      initialValues[field.name] = _defaultValue(field);
    }

    state = state.copyWith(values: initialValues);
  }

  void updateValue(String key, dynamic value) {
    state = state.copyWith(values: {...state.values, key: value});
  }

  /// ✅ File-specific helpers (important)
  void onUploadFileSuccess(String fieldName, String url) {
    final current = List<String>.from(state.values[fieldName] ?? []);
    current.add(url);

    state = state.copyWith(values: {...state.values, fieldName: current});
  }

  void onRemoveFile(String fieldName, int index) {
    final current = List<String>.from(state.values[fieldName] ?? []);
    if (index < 0 || index >= current.length) return;

    current.removeAt(index);

    state = state.copyWith(values: {...state.values, fieldName: current});
  }

  bool validateStep(List<DynamicField> fields) {
    final errors = <String, String?>{};

    for (final field in fields) {
      final value = state.values[field.name];

      // File field validation
      if (field.type == FieldType.file && field.required) {
        final files = value as List<String>?;

        if (files == null || files.isEmpty) {
          errors[field.name] = '${field.label} is required';
        }
        continue;
      }

      // Default validation
      if (field.required && (value == null || value.toString().isEmpty)) {
        errors[field.name] = '${field.label} is required';
      }
    }

    state = state.copyWith(errors: errors);
    return errors.isEmpty;
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  Map<String, dynamic> submit() => state.values;

  static dynamic _defaultValue(DynamicField field) {
    switch (field.type) {
      case FieldType.checkbox:
      case FieldType.multiselect:
        return <dynamic>[];
      case FieldType.toggle:
        return false;
      default:
        return '';
    }
  }
}
