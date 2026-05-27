part of 'view.dart';

class _AttendanceDetailsParams {
  final int requestId;

  _AttendanceDetailsParams({required this.requestId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _AttendanceDetailsParams && other.requestId == requestId;
  }

  @override
  int get hashCode => requestId.hashCode;
}

class _AttendanceDetailsState {
  final bool isLoading;
  final AttendanceRequestItem? requestDetail;

  _AttendanceDetailsState({required this.isLoading, this.requestDetail});

  _AttendanceDetailsState copyWith({
    bool? isLoading,
    AttendanceRequestItem? requestDetail,
  }) {
    return _AttendanceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      requestDetail: requestDetail ?? this.requestDetail,
    );
  }
}

class _AttendanceDetailsController
    extends StateNotifier<_AttendanceDetailsState> {
  final _AttendanceDetailsParams params;
  late TextEditingController commentController;
  String? pendingFileUrl;
  String? pendingFileName;
  String? pendingFileType;
  String? pendingFileSize;

  final _attendanceRepo = AttendanceRepository();

  _AttendanceDetailsController(this.params)
    : super(_AttendanceDetailsState(isLoading: true));

  AttendanceRequestItem? get requestDetail => state.requestDetail;

  bool get isMyRequest {
    final detail = state.requestDetail;
    if (detail == null) return true;
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null) return false;

    if (detail.userId != null && detail.userId == user.userId) return true;

    final createdBy = detail.createdBy?.trim();
    if (createdBy != null && createdBy.isNotEmpty) {
      if (createdBy == '${user.userId}') return true;
      if (createdBy == user.employeeId) return true;
    }

    final employeeId = detail.createdByUser?.employeeId?.trim() ?? '';
    if (employeeId.isNotEmpty && employeeId == user.employeeId) return true;
    return false;
  }

  ApprovalDetail? get pendingApproval {
    final user = KAppX.globalProvider.read(userProvider);
    final detail = state.requestDetail;
    if (user == null || detail == null) return null;

    final approvals = detail.approvalDetails ?? [];
    for (final approval in approvals) {
      final status = approval.approvalStatus?.trim().toLowerCase() ?? '';
      if (status != 'in progress') continue;

      if (approval.departmentId == user.department &&
          approval.sectionId == user.section) {
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

  Future<void> fetchRequestDetailsById({bool showLoader = true}) async {
    if (showLoader) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final detail = await _attendanceRepo.fetchAttendanceRequestDetailsById(
        params.requestId,
      );
      state = state.copyWith(requestDetail: detail, isLoading: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint('error fetching attendance details $e');
      state = state.copyWith(isLoading: false);
    }
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    final workflowSteps = <WorkflowTimelineStep>[];
    final workflowList = state.requestDetail?.workflowLogs ?? [];
    for (final workflow in workflowList) {
      workflowSteps.add(
        WorkflowTimelineStep(
          status: _determineWorkflowStatus(workflow.status ?? ''),
          title: workflow.content ?? '',
          date: workflow.createdAt?.formattedDate ?? '',
        ),
      );
    }
    return workflowSteps;
  }

  WorkflowStepStatus _determineWorkflowStatus(String status) {
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
    return [];
  }

  List<CommentEntryModel> createChatList() {
    final user = KAppX.globalProvider.read(userProvider);
    final commentsList = <CommentEntryModel>[];
    final comments = state.requestDetail?.chatMessages ?? [];

    for (final comment in comments) {
      final isSelf = comment.user?.id == user?.userId;
      commentsList.add(
        CommentEntryModel(
          userName: comment.user?.employeeName ?? '',
          userInitials: _getInitials(comment.user?.employeeName ?? ''),
          isSelf: isSelf,
          message: comment.message ?? '',
          statusLabel: comment.status,
          time: comment.createdAt?.formattedDateTime ?? '',
        ),
      );
    }
    return commentsList.reversed.toList();
  }

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '';
    final names = name.trim().split(RegExp(r'\s+'));
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
      debugPrint('error uploading attendance attachment $e');
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
    final detail = state.requestDetail!;
    final message = commentController.text.trim();
    final hasFile =
        pendingFileUrl != null && pendingFileUrl!.trim().isNotEmpty;

    final payload = <String, dynamic>{
      'request_id': params.requestId,
      'service_id': detail.serviceId,
      'sub_service_id': detail.subServiceId,
      'messageType': hasFile
          ? _messageTypeFromName(pendingFileName ?? '')
          : 'text',
      'message': message,
      'file_url': hasFile ? pendingFileUrl : null,
      'file_name': hasFile ? pendingFileName : null,
      'file_type': hasFile ? pendingFileType : null,
    };

    return payload;
  }

  Future<void> _returnToAttendanceDashboardAndRefresh() async {
    await KAppX.router.maybePop();
    triggerAttendanceDashboardMyRequestsRefresh();
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
      await _attendanceRepo.approveAttendanceRequest(params.requestId, {
        'approval_id': approvalId,
        'comment': comment,
        'status': 'Approved',
      });
      await _returnToAttendanceDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error approving attendance request $e');
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
      await _attendanceRepo.rejectAttendanceRequest(params.requestId, {
        'approval_id': approvalId,
        'comment': comment,
        'status': 'Rejected',
      });
      await _returnToAttendanceDashboardAndRefresh();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error rejecting attendance request $e');
    }
  }

  Future<void> addCommentInAttendanceRequest() async {
    if (state.requestDetail == null) return;

    final message = commentController.text.trim();
    final hasFile =
        pendingFileUrl != null && pendingFileUrl!.trim().isNotEmpty;
    if (message.isEmpty && !hasFile) {
      Fluttertoast.showToast(
        msg: 'Please enter remarks or attach a file',
        timeInSecForIosWeb: 3,
      );
      return;
    }

    try {
      await _attendanceRepo.addCommentInAttendanceRequest(
        params.requestId,
        _buildChatPayload(),
      );
      commentController.clear();
      clearPendingAttachment();
      await fetchRequestDetailsById(showLoader: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      debugPrint('error adding attendance comment $e');
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}

final _attendanceDetailsProvider = StateNotifierProvider.autoDispose
    .family<
      _AttendanceDetailsController,
      _AttendanceDetailsState,
      _AttendanceDetailsParams
    >((ref, params) {
      final controller = _AttendanceDetailsController(params);
      controller.commentController = TextEditingController();
      controller.fetchRequestDetailsById();
      return controller;
    });
