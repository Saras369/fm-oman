import 'dart:io';
import 'package:code_setup/presentation/common_widgets/show_toast.dart';
import 'package:code_setup/repository/domain/auth_repository.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  final void Function(String url)? onUploadSuccess;
  final void Function(int index)? onDelete;

  const FileUploadWidget({Key? key, this.onUploadSuccess, this.onDelete})
    : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  List<File> _selectedFiles = [];
  List<String?> _uploadedUrls = [];
  String? _errorMessage;
  bool _isUploading = false;
  int? _uploadingIndex;

  static const int _maxFileSizeBytes = 10 * 1024 * 1024; // 10MB

  Future<void> _pickFile() async {
    setState(() {
      _errorMessage = null;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final size = await file.length();
      if (size > _maxFileSizeBytes) {
        setState(() {
          _errorMessage = "File can't be larger than 10MB";
        });
      } else {
        setState(() {
          _selectedFiles.add(file);
          _uploadedUrls.add(null);
          _errorMessage = null;
        });

        // Start upload immediately for the newly added file
        await _uploadFile(_selectedFiles.length - 1);
      }
    }
  }

  Future<void> _uploadFile(int index) async {
    if (index >= _selectedFiles.length) return;

    setState(() {
      _isUploading = true;
      _uploadingIndex = index;
      _errorMessage = null;
    });

    try {
      String fileName = _selectedFiles[index].path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedFiles[index].path,
          filename: fileName,
        ),
      });
      final authRepo = AuthRepository();
      final response = await authRepo.uploadFile(formData);
      setState(() {
        _isUploading = false;
        _uploadingIndex = null;

        // Save uploaded URL to list
        _uploadedUrls[index] = response?.files?.first.downloadUrl ?? '';
      });
      if (widget.onUploadSuccess != null) {
        widget.onUploadSuccess!(response?.files?.first.downloadUrl ?? '');
      }
      ShowFlutterToast().showFlutterToastSuccess(
        response?.message ?? "File uploaded successfully!",
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadingIndex = null;
        _errorMessage = "Failed to upload: $e";
        _uploadedUrls[index] = null;
      });
    }
  }

  void _deleteFile(int index) {
    if (index < 0 || index >= _selectedFiles.length) return;

    final deletedUrl = _uploadedUrls.length > index
        ? _uploadedUrls[index]
        : null;

    setState(() {
      _selectedFiles.removeAt(index);
      _uploadedUrls.removeAt(index);
    });

    if (widget.onDelete != null) {
      widget.onDelete!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Attach Files (Optional)",
            style: TextStyle(
              fontWeight: currentTheme.fontWeights.wBold,
              fontSize: currentTheme.fontSizes.s12,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: _isUploading ? null : _pickFile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _isUploading
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Uploading...",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        )
                      : Text(
                          "Upload Files..",
                          style: TextStyle(
                            fontWeight: currentTheme.fontWeights.wBold,
                            fontSize: currentTheme.fontSizes.s14,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 18),
              Icon(
                Icons.cloud_upload_outlined,
                color: Colors.grey.shade700,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                "Drop files here",
                style: TextStyle(
                  fontWeight: currentTheme.fontWeights.wBold,
                  fontSize: currentTheme.fontSizes.s12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "You can upload doc, docx, pdf, png, jpeg files\nFile can't be larger than 10MB",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 14),
              if (_selectedFiles.isNotEmpty)
                ...List.generate(_selectedFiles.length, (index) {
                  final file = _selectedFiles[index];
                  return ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(
                      file.path.split('/').last,
                      style: TextStyle(fontSize: currentTheme.fontSizes.s13),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () => _deleteFile(index),
                    ),
                  );
                }),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
