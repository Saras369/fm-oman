part of 'view.dart';

class _VSControllerParams {
  final int requestId;

  _VSControllerParams({required this.requestId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VSControllerParams && other.requestId == requestId;
  }

  @override
  int get hashCode => requestId.hashCode;
}

class _ViewState {
  final bool isLoading;
  final List<FinancialServiceRequestDetailsItem> requestDetails;

  _ViewState({required this.isLoading, required this.requestDetails});

  _ViewState copyWith({
    bool? isLoading,
    List<FinancialServiceRequestDetailsItem>? requestDetails,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      requestDetails: requestDetails ?? this.requestDetails,
    );
  }
}

class _VsController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;
  late TextEditingController commentController;
  String? pendingFileUrl;
  String? pendingFileName;
  String? pendingFileType;
  String? pendingFileSize;

  _VsController(this.params)
    : super(_ViewState(isLoading: true, requestDetails: []));

  bool get isMyRequest {
    if (state.requestDetails.isEmpty) return true;
    final detail = state.requestDetails.first;
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null) return false;

    if (detail.userId != null && detail.userId == user.userId) return true;
    final detailEmployeeId = detail.employeeId?.trim() ?? '';
    if (detailEmployeeId.isNotEmpty && detailEmployeeId == user.employeeId) {
      return true;
    }
    return false;
  }

  ApprovalDetails? get pendingApproval {
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null || state.requestDetails.isEmpty) return null;

    final approvals = state.requestDetails.first.approvals ?? [];
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

  bool get canApproveOrReject => !isMyRequest && pendingApproval != null;

  int? get pendingApprovalId => pendingApproval?.id;

  void clearPendingAttachment() {
    pendingFileUrl = null;
    pendingFileName = null;
    pendingFileType = null;
    pendingFileSize = null;
  }

  void showLoading(bool v) => state = state.copyWith(isLoading: v);

  Future<void> fetchRequestDetailsById({bool showLoader = true}) async {
    final finRepo = FinancialServicesRepo();
    if (showLoader) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final requestDetails = await finRepo
          .fetchFinancialServiveiceRequestDetailsById(params.requestId);

      state = state.copyWith(
        requestDetails: requestDetails ?? [],
        isLoading: false,
      );
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    List<WorkflowTimelineStep> workflowSteps = [];
    if (state.requestDetails.isNotEmpty) {
      final workflowList = state.requestDetails[0].workflows ?? [];
      for (var workflow in workflowList) {
        workflowSteps.add(
          WorkflowTimelineStep(
            status: determineWorkflowStatus(workflow.status ?? ''),
            title: workflow.content ?? '',
            date: DateTime.parse(workflow.activityDate ?? '').formattedDate,
          ),
        );
      }
    }
    return workflowSteps;
  }

  WorkflowStepStatus determineWorkflowStatus(String status) {
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
    List<FileInfo> files = [];
    if (state.requestDetails.isNotEmpty) {
      final attachements = state.requestDetails[0].attachments ?? [];
      for (var file in attachements) {
        files.add(
          FileInfo(
            name: file.fileName ?? '',
            type: file.fileType ?? '',
            uploadedDate: DateTime.parse(file.createdAt ?? '').formattedDate,
            downloadable: true,
            viewable: true,
            onDownload: () {
              /* Download logic */
            },
            onView: () {
              /* View logic */
            },
          ),
        );
      }
    }
    return files;
  }

  List<CommentEntryModel> createChatList() {
    final user = KAppX.globalProvider.read(userProvider);

    List<CommentEntryModel> commentsList = [];
    if (state.requestDetails.isNotEmpty) {
      final comments = state.requestDetails[0].chats ?? [];
      for (var comment in comments) {
        final isSelf = comment.senderUserId?.id == user?.userId;
        commentsList.add(
          CommentEntryModel(
            userName: comment.senderUserId?.employeeName ?? '',
            userInitials: getInitials(comment.senderUserId?.employeeName ?? ''),
            isSelf: isSelf,
            message: comment.content ?? '',
            time: DateTime.parse(comment.createdAt ?? '').formattedDate,
          ),
        );
      }
    }
    return commentsList;
  }

  String getInitials(String name) {
    if (name.trim().isEmpty) return '';
    List<String> names = name.trim().split(RegExp(r'\s+'));
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names[names.length - 1][0]).toUpperCase();
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
      debugPrint('error uploading financial request attachment $e');
      Fluttertoast.showToast(
        msg: 'Failed to upload file',
        timeInSecForIosWeb: 3,
      );
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
    final detail = state.requestDetails.first;
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

  Future<void> _returnToFinancialDashboardAndRefresh() async {
    await KAppX.router.maybePop();
    triggerFinancialDashboardMyRequestsRefresh();
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

    final finRepo = FinancialServicesRepo();
    try {
      await finRepo.approveFinancialRequest(params.requestId, {
        'approval_id': approvalId,
        'comment': comment,
        'status': 'Approved',
      });
      await _returnToFinancialDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error approving financial request $e');
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

    final finRepo = FinancialServicesRepo();
    try {
      await finRepo.rejectFinancialRequest(params.requestId, {
        'approval_id': approvalId,
        'comment': comment,
        'status': 'Rejected',
      });
      await _returnToFinancialDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error rejecting financial request $e');
    }
  }

  Future<void> addCommentInFinRequest() async {
    if (state.requestDetails.isEmpty) return;

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

    final finRepo = FinancialServicesRepo();
    try {
      await finRepo.addCommentInFinRequest(
        params.requestId,
        _buildChatPayload(),
      );
      commentController.clear();
      clearPendingAttachment();
      await fetchRequestDetailsById(showLoader: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error adding financial request comment $e');
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}

// RIVERPOD PROVIDER
final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VsController, _ViewState, _VSControllerParams>((ref, params) {
      final controller = _VsController(params);
      // ...
      controller.commentController = TextEditingController();
      controller.fetchRequestDetailsById();
      return controller;
    });
