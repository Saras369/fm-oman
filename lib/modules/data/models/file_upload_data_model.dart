class FileUploadDataModel {
  final String? message;
  final List<FileUploadItem>? files;

  FileUploadDataModel({this.message, this.files});

  factory FileUploadDataModel.fromJson(Map<String, dynamic> json) {
    return FileUploadDataModel(
      message: json['message'] as String?,
      files: json['files'] != null
          ? (json['files'] as List)
                .map((e) => FileUploadItem.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'files': files?.map((e) => e.toJson()).toList(),
    };
  }
}

class FileUploadItem {
  final String? documentId;
  final String? filename;
  final String? originalName;
  final int? size;
  final String? downloadUrl;

  FileUploadItem({
    this.documentId,
    this.filename,
    this.originalName,
    this.size,
    this.downloadUrl,
  });

  factory FileUploadItem.fromJson(Map<String, dynamic> json) {
    dynamic downloadUrl = json['downloadUrl'];
    String? parsedDownloadUrl;
    if (downloadUrl is List && downloadUrl.isNotEmpty) {
      parsedDownloadUrl = downloadUrl[0] as String?;
    } else if (downloadUrl is String) {
      parsedDownloadUrl = downloadUrl;
    } else {
      parsedDownloadUrl = null;
    }

    return FileUploadItem(
      documentId: json['documentId'] as String?,
      filename: json['filename'] as String?,
      originalName: json['originalName'] as String?,
      size: json['size'] as int?,
      downloadUrl: parsedDownloadUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'filename': filename,
      'originalName': originalName,
      'size': size,
      'downloadUrl': downloadUrl,
    };
  }
}
