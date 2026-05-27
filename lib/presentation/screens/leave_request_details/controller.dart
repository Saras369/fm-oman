part of 'view.dart';

class _VSControllerParams {
  final int requestId;
  final bool isFromActionItems;

  _VSControllerParams({
    required this.requestId,
    required this.isFromActionItems,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VSControllerParams &&
        other.requestId == requestId &&
        other.isFromActionItems == isFromActionItems;
  }

  @override
  int get hashCode => Object.hash(requestId, isFromActionItems);
}

class _ViewState {
  final bool isLoading;
  final LeaveRequestDetailsModel? requestDetails;

  _ViewState({required this.isLoading, this.requestDetails});

  _ViewState copyWith({
    bool? isLoading,
    LeaveRequestDetailsModel? requestDetails,
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
  final LeaveRepo _leaveRepo = LeaveRepo();
  int? _loggedInRoleId;

  _VsController(this.params) : super(_ViewState(isLoading: true)) {
    commentController = TextEditingController();
    _loadLoggedInRoleId();
    fetchRequestDetailsById();
  }

  Future<void> _loadLoggedInRoleId() async {
    final userMeta = await KAuthCred().getUserMeta();
    final role = userMeta?['role'];
    if (role is int) {
      _loggedInRoleId = role;
    } else if (role is String) {
      _loggedInRoleId = int.tryParse(role);
    }
    // Trigger a rebuild because approval visibility depends on role match.
    state = state.copyWith(isLoading: state.isLoading);
  }

  Future<void> fetchRequestDetailsById() async {
    state = state.copyWith(isLoading: true);
    try {
      final details = await _leaveRepo.fetchLeaveRequestDetailsById(
        params.requestId,
      );
      state = state.copyWith(requestDetails: details, isLoading: false);
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    final workflowSteps = <WorkflowTimelineStep>[];
    final workflowList = state.requestDetails?.data?.workflowDetails ?? [];
    final requestItem = state.requestDetails?.data?.request;
    final approvals = state.requestDetails?.data?.approvalDetails ?? [];

    for (var i = 0; i < workflowList.length; i++) {
      final workflow = workflowList[i];
      String? chipText = workflow.role?.name;
      String? submittedBy;
      if (i == 0) {
        submittedBy = requestItem?.createdByUser?.employeeName;
      }

      String? approvedBy;
      if (i > 0) {
        if (workflow.content?.toLowerCase().contains('notification') == true) {
          approvedBy = null;
        } else if (workflow.roleId != null) {
          final approval = approvals
              .where((a) => a.approverRoleId == workflow.roleId)
              .firstOrNull;
          approvedBy =
              approval?.approverUser?.employeeName ??
              workflow.role?.name ??
              'NA';
        }
      }

      workflowSteps.add(
        WorkflowTimelineStep(
          status: _determineWorkflowStatus(workflow.status ?? ''),
          title: workflow.content ?? '',
          chip: chipText,
          submittedBy: submittedBy,
          approvedBy: approvedBy,
          date: _formatDate(workflow.createdAt),
        ),
      );
    }
    return workflowSteps;
  }

  WorkflowStepStatus _determineWorkflowStatus(String status) {
    final s = status.toLowerCase();
    if (s == 'completed' ||
        s == 'received' ||
        s == 'approved' ||
        s == 'sent') {
      return WorkflowStepStatus.approved;
    }
    if (s == 'submitted') return WorkflowStepStatus.submitted;
    if (s == 'pending') return WorkflowStepStatus.pending;
    return WorkflowStepStatus.inactive;
  }

  List<FileInfo> createAttachmentsList() {
    final files = <FileInfo>[];
    final attachments = state.requestDetails?.data?.attachments ?? [];
    for (final file in attachments) {
      files.add(
        FileInfo(
          name: file.fileName ?? '',
          type: file.fileType ?? '',
          uploadedDate: _formatDate(file.createdAt),
          downloadable: true,
          viewable: true,
          onDownload: () {},
          onView: () {},
        ),
      );
    }
    return files;
  }

  List<CommentEntryModel> createChatList() {
    final user = KAppX.globalProvider.read(userProvider);
    final comments = <CommentEntryModel>[];
    final chatMessages = state.requestDetails?.data?.chatMessages ?? [];

    for (final comment in chatMessages) {
      final isSelf = comment.senderUser?.id == user?.userId;
      comments.add(
        CommentEntryModel(
          userName: _roleNameForChat(comment),
          userInitials: _getInitials(comment.senderUser?.employeeName ?? ''),
          isSelf: isSelf,
          message: comment.content ?? '',
          statusLabel: comment.status,
          time: _formatDateTime(comment.createdAt),
        ),
      );
    }
    return comments.reversed.toList();
  }

  bool get isMyRequest {
    if (!params.isFromActionItems) return true;

    final request = state.requestDetails?.data?.request;
    if (request == null) return true;
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null) return false;

    if (request.userId != null && request.userId == '${user.userId}') {
      return true;
    }

    final employeeId = request.createdByUser?.employeeId?.trim() ?? '';
    if (employeeId.isNotEmpty && employeeId == user.employeeId) return true;
    return false;
  }

  LeaveApprovalDetail? get pendingApproval {
    final user = KAppX.globalProvider.read(userProvider);
    if (user == null) return null;

    final approvals = state.requestDetails?.data?.approvalDetails ?? [];
    final inProgressApprovals = approvals.where((approval) {
      final status = approval.approvalStatus?.trim().toLowerCase() ?? '';
      return status == 'in progress';
    }).toList();
    if (inProgressApprovals.isEmpty) return null;

    for (final approval in inProgressApprovals) {
      final approverUserId = approval.approverUserId;
      final approverRoleId = approval.approverRoleId;

      if (approverUserId != null) {
        if (approverUserId == user.userId) return approval;
        continue;
      }

      if (approverRoleId != null) {
        if (_loggedInRoleId != null && approverRoleId == _loggedInRoleId) {
          return approval;
        }
        continue;
      }

      final departmentId = approval.departmentId;
      final sectionId = approval.sectionId;
      final departmentMatches =
          departmentId == null || departmentId == user.department;
      final sectionMatches = sectionId == null || sectionId == user.section;
      if (departmentMatches && sectionMatches) return approval;
    }

    return null;
  }

  bool get canApproveOrReject =>
      params.isFromActionItems && !isMyRequest && pendingApproval != null;

  int? get pendingApprovalId => pendingApproval?.id;

  int? get leaveRequestId =>
      state.requestDetails?.data?.request?.id ??
      pendingApproval?.leaveRequestId ??
      params.requestId;

  String _roleNameForChat(LeaveChatMessage comment) {
    if (comment.senderUser?.employeeName?.isNotEmpty == true) {
      return comment.senderUser!.employeeName!;
    }
    final approvals = state.requestDetails?.data?.approvalDetails ?? [];
    for (final a in approvals) {
      if (a.approverRoleId == comment.roleId && a.approverRole?.name != null) {
        return a.approverRole!.name!;
      }
    }
    return 'Employee';
  }

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '';
    final names = name.trim().split(RegExp(r'\s+'));
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names[names.length - 1][0]).toUpperCase();
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '';
    return DateTime.tryParse(value)?.formattedDate ?? value;
  }

  String _formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '';
    return DateTime.tryParse(value)?.formattedDateTime ?? value;
  }

  void addComment() {
    commentController.clear();
  }

  Future<void> _returnToLeaveDashboardAndRefresh() async {
    await KAppX.router.maybePop();
  }

  Future<void> approveRequest(String comment) async {
    final approvalId = pendingApprovalId;
    if (approvalId == null) {
      ShowFlutterToast().showFlutterToastFailure('No pending approval found');
      return;
    }

    final requestId = leaveRequestId;
    if (requestId == null) {
      ShowFlutterToast().showFlutterToastFailure(
        'Unable to resolve leave request id',
      );
      return;
    }

    try {
      await _leaveRepo.approveOrRejectLeaveRequest({
        'leave_request_id': requestId,
        'approval_id': approvalId,
        'status': 'Approved',
        'comment': comment,
      });
      await _returnToLeaveDashboardAndRefresh();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error approving leave request $e');
    }
  }

  Future<void> rejectRequest(String comment) async {
    final approvalId = pendingApprovalId;
    if (approvalId == null) {
      ShowFlutterToast().showFlutterToastFailure('No pending approval found');
      return;
    }

    final requestId = leaveRequestId;
    if (requestId == null) {
      ShowFlutterToast().showFlutterToastFailure(
        'Unable to resolve leave request id',
      );
      return;
    }

    try {
      await _leaveRepo.approveOrRejectLeaveRequest({
        'leave_request_id': requestId,
        'approval_id': approvalId,
        'status': 'Rejected',
        'comment': comment,
      });
      await _returnToLeaveDashboardAndRefresh();
    } on ApiException catch (apiError) {
      ShowFlutterToast().showFlutterToastFailure(apiError.message);
    } catch (e) {
      debugPrint('error rejecting leave request $e');
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VsController, _ViewState, _VSControllerParams>((ref, params) {
      return _VsController(params);
    });
