import 'package:code_setup/presentation/core_widgets/dynamic_form/models/field_type.dart';

typedef VisibilityCondition = bool Function(Map<String, dynamic> values);

class DynamicField {
  final String name;
  final String label;
  final FieldType type;
  final bool required;
  final String? placeholder;
  final bool disabled;
  final List<dynamic>? options;
  final dynamic initialValue;
  final VisibilityCondition? visibleWhen;

  const DynamicField({
    required this.name,
    required this.label,
    required this.type,
    this.required = false,
    this.placeholder,
    this.disabled = false,
    this.options,
    this.initialValue,
    this.visibleWhen,
  });
}

class DropdownOption<T> {
  final T value; // actual stored value (id / object / enum)
  final String label; // what user sees

  const DropdownOption({required this.value, required this.label});
}
