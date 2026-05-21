import 'package:code_setup/presentation/common_widgets/file_upload_widget.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/core_widgets/dynamic_form/state/dynamic_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileFieldWidget extends ConsumerWidget {
  final DynamicField field;

  const FileFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);

    final uploadedUrls = List<String>.from(state.values[field.name] ?? []);

    final errorText = state.errors[field.name];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileUploadWidget(
          onUploadSuccess: (url) {
            notifier.onUploadFileSuccess(field.name, url);
          },
          onDelete: (index) {
            notifier.onRemoveFile(field.name, index);
          },
        ),

        // 🔴 Validation error
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
