part of 'view.dart';

class _SecurityDetailsParams {
  final int requestId;
  final String slug;
  final String title;
  final bool isFromActionItems;

  _SecurityDetailsParams({
    required this.requestId,
    required this.slug,
    required this.title,
    required this.isFromActionItems,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _SecurityDetailsParams &&
        other.requestId == requestId &&
        other.slug == slug &&
        other.isFromActionItems == isFromActionItems;
  }

  @override
  int get hashCode => Object.hash(requestId, slug, isFromActionItems);
}

class _SecurityDetailsState {
  final bool isLoading;
  final FinancialServiceRequestDetailsItem? detail;

  _SecurityDetailsState({required this.isLoading, this.detail});

  _SecurityDetailsState copyWith({
    bool? isLoading,
    FinancialServiceRequestDetailsItem? detail,
  }) {
    return _SecurityDetailsState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
    );
  }
}

class _SecurityDetailsController extends StateNotifier<_SecurityDetailsState> {
  final _SecurityDetailsParams params;
  late TextEditingController commentController;
  String? pendingFileUrl;
  String? pendingFileName;
  String? pendingFileType;
  String? pendingFileSize;

  _SecurityDetailsController(this.params)
    : super(_SecurityDetailsState(isLoading: true));

  FinancialServiceRequestDetailsItem? get requestDetail => state.detail;

  bool get isMyRequest {
    if (!params.isFromActionItems) return true;

    final detail = state.detail;
    if (detail == null) return true;
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null) return false;

    if (detail.userId != null && detail.userId == user.userId) return true;

    final createdBy = detail.createdBy?.trim();
    if (createdBy != null && createdBy.isNotEmpty) {
      if (createdBy == '${user.userId}') return true;
      if (createdBy == user.employeeId) return true;
    }

    final detailEmployeeId = detail.employeeId?.trim() ?? '';
    if (detailEmployeeId.isNotEmpty && detailEmployeeId == user.employeeId) {
      return true;
    }
    return false;
  }

  ApprovalDetails? get pendingApproval {
    final user = KAppX.globalProvider.read(userProvider);
    final detail = state.detail;
    if (user == null || detail == null) return null;

    final approvals = detail.approvals ?? [];
    for (final approval in approvals) {
      final status = approval.approvalStatus?.trim().toLowerCase() ?? '';
      if (status != 'in progress') continue;

      final deptId =
          approval.departmentDetails?.id ?? approval.departmentId;
      final sectionId = approval.sectionDetails?.id ?? approval.sectionId;
      if (deptId == user.department && sectionId == user.section) {
        return approval;
      }
    }
    return null;
  }

  bool get canApproveOrReject =>
      params.isFromActionItems && !isMyRequest && pendingApproval != null;

  int? get pendingApprovalId => pendingApproval?.id;

  void clearPendingAttachment() {
    pendingFileUrl = null;
    pendingFileName = null;
    pendingFileType = null;
    pendingFileSize = null;
  }

  Future<void> fetchRequestDetails({bool showLoader = true}) async {
    if (showLoader) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final detail = await SecurityServicesRepo().fetchRequestDetails(
        params.slug,
        params.requestId,
      );
      state = state.copyWith(detail: detail, isLoading: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint('error fetching security request details $e');
      state = state.copyWith(isLoading: false);
    }
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    final workflows = state.detail?.workflows ?? [];
    return workflows.map((workflow) {
      return WorkflowTimelineStep(
        status: _workflowStatus(workflow.status ?? ''),
        title: workflow.content ?? '',
        date: _formatDate(workflow.activityDate),
      );
    }).toList();
  }

  WorkflowStepStatus _workflowStatus(String status) {
    switch (status) {
      case 'Completed':
        return WorkflowStepStatus.approved;
      case 'Pending':
        return WorkflowStepStatus.pending;
      default:
        return WorkflowStepStatus.inactive;
    }
  }

  List<FileInfo> createAttachmentsList() {
    final attachments = state.detail?.attachments ?? [];
    return attachments.map((file) {
      return FileInfo(
        name: file.fileName ?? '',
        type: file.fileType ?? '',
        uploadedDate: _formatDate(file.createdAt),
        downloadable: true,
        viewable: true,
        onDownload: () {},
        onView: () {},
      );
    }).toList();
  }

  List<CommentEntryModel> createChatList() {
    final user = KAppX.globalProvider.read(userProvider);
    final chats = state.detail?.chats ?? [];

    return chats.map((comment) {
      final isSelf = comment.senderUserId?.id == user?.userId;
      return CommentEntryModel(
        userName: comment.senderUserId?.employeeName ?? '',
        userInitials: _initials(comment.senderUserId?.employeeName ?? ''),
        isSelf: isSelf,
        message: comment.content ?? '',
        time: _formatDate(comment.createdAt),
      );
    }).toList();
  }

  String _initials(String name) {
    if (name.trim().isEmpty) return '';
    final names = name.trim().split(RegExp(r'\s+'));
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names[names.length - 1][0]).toUpperCase();
  }

  String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) return '';
    try {
      return DateTime.parse(value).formattedDate;
    } catch (_) {
      return value;
    }
  }

  Future<void> pickAndUploadAttachment() async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null || result.files.isEmpty) return;

    final picked = result.files.single;
    final path = picked.path;
    if (path == null || path.isEmpty) return;

    final file = File(path);
    final fileName = picked.name;
    final fileSize = await file.length();

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: fileName),
      });
      final uploadResponse = await AuthRepository().uploadFile(formData);
      final uploaded = uploadResponse?.files?.firstOrNull;
      final downloadUrl = uploaded?.downloadUrl;
      if (downloadUrl == null || downloadUrl.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: 'File upload failed',
          timeInSecForIosWeb: 3,
        );
        return;
      }

      pendingFileUrl = downloadUrl;
      pendingFileName = uploaded?.originalName ?? fileName;
      pendingFileType = _fileTypeFromName(fileName);
      pendingFileSize = '${uploaded?.size ?? fileSize}';
      state = state.copyWith();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error uploading security attachment $e');
    }
  }

  String _fileTypeFromName(String fileName) {
    final ext = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';
    if (['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp'].contains(ext)) {
      return 'image';
    }
    return ext.isEmpty ? 'file' : ext;
  }

  String _messageTypeFromName(String fileName) {
    return _fileTypeFromName(fileName) == 'image' ? 'image' : 'file';
  }

  Map<String, dynamic> _buildChatPayload() {
    final detail = state.detail!;
    final content = commentController.text.trim();
    final hasFile =
        pendingFileUrl != null && pendingFileUrl!.trim().isNotEmpty;

    final payload = <String, dynamic>{
      'request_id': params.requestId,
      'service_id': detail.serviceId,
      'sub_service_id': detail.subServiceId,
      'messageType': hasFile
          ? _messageTypeFromName(pendingFileName ?? '')
          : 'text',
      'content': content,
    };

    if (hasFile) {
      payload['file_url'] = pendingFileUrl;
      payload['file_name'] = pendingFileName;
      payload['file_type'] = pendingFileType;
      payload['file_size'] = pendingFileSize;
    }

    return payload;
  }

  Future<void> _returnToSecurityDashboardAndRefresh() async {
    await KAppX.router.maybePop();
    triggerSecurityDashboardMyRequestsRefresh();
  }

  Future<void> approveRequest(String comment) async {
    final approvalId = pendingApprovalId;
    if (approvalId == null) {
      Fluttertoast.showToast(
        msg: 'No pending approval found for your department',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    try {
      await SecurityServicesRepo().approveSecurityRequest(
        params.slug,
        params.requestId,
        {
          'approval_id': approvalId,
          'comment': comment,
          'status': 'Approved',
        },
      );
      await _returnToSecurityDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error approving security request $e');
    }
  }

  Future<void> rejectRequest(String comment) async {
    final approvalId = pendingApprovalId;
    if (approvalId == null) {
      Fluttertoast.showToast(
        msg: 'No pending approval found for your department',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    try {
      await SecurityServicesRepo().rejectSecurityRequest(
        params.slug,
        params.requestId,
        {
          'approval_id': approvalId,
          'comment': comment,
          'status': 'Rejected',
        },
      );
      await _returnToSecurityDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error rejecting security request $e');
    }
  }

  Future<void> addCommentInRequest() async {
    if (state.detail == null) return;

    final content = commentController.text.trim();
    final hasFile =
        pendingFileUrl != null && pendingFileUrl!.trim().isNotEmpty;
    if (content.isEmpty && !hasFile) {
      Fluttertoast.showToast(
        msg: 'Please enter remarks or attach a file',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    try {
      await SecurityServicesRepo().addCommentInSecurityRequest(
        params.slug,
        params.requestId,
        _buildChatPayload(),
      );
      commentController.clear();
      clearPendingAttachment();
      await fetchRequestDetails(showLoader: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error adding security request comment $e');
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}

final _securityDetailsProvider = StateNotifierProvider.autoDispose
    .family<_SecurityDetailsController, _SecurityDetailsState,
        _SecurityDetailsParams>((ref, params) {
  final controller = _SecurityDetailsController(params);
  controller.commentController = TextEditingController();
  controller.fetchRequestDetails();
  return controller;
});
