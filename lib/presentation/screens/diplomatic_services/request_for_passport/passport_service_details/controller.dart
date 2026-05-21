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
  final PassportRequestDetailsModel? requestDetails;

  _ViewState({required this.isLoading, this.requestDetails});

  _ViewState copyWith({
    bool? isLoading,
    PassportRequestDetailsModel? requestDetails,
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

  _VsController(this.params) : super(_ViewState(isLoading: false)) {
    commentController = TextEditingController();
    fetchRequestDetailsById();
  }

  void showLoading(bool v) => state = state.copyWith(isLoading: v);

  Future<void> fetchRequestDetailsById() async {
    final passportRepo = RequestForPassportRepo();
    try {
      final requestDetails = await passportRepo.fetchPassportRequestDetailsById(
        params.requestId,
      );

      if (requestDetails != null) {
        state = state.copyWith(requestDetails: requestDetails);
      }
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    List<WorkflowTimelineStep> workflowSteps = [];
    if (state.requestDetails?.data?.workflowDetails != null) {
      final workflowList = state.requestDetails!.data!.workflowDetails!;
      final requestItem = state.requestDetails?.data?.request;

      for (var i = 0; i < workflowList.length; i++) {
        var workflow = workflowList[i];
        
        String? chipText;
        if (workflow.role?.name != null) {
          chipText = workflow.role!.name;
        }

        String? submittedBy;
        if (i == 0) {
          submittedBy = requestItem?.applicantName ?? requestItem?.createdByUser?.employeeName;
        }

        String? approvedBy;
        if (i > 0) {
          if (workflow.content?.toLowerCase().contains('notification') == true) {
             approvedBy = null;
          } else {
            final approvals = state.requestDetails?.data?.approvalDetails ?? [];
            final approval = approvals.where((a) => a.approverRoleId == workflow.roleId).firstOrNull;
            if (approval != null) {
               approvedBy = approval.approverUser?.employeeName ?? 'XXXXXX';
            } else {
               approvedBy = 'NA';
            }
          }
        }

        workflowSteps.add(
          WorkflowTimelineStep(
            status: determineWorkflowStatus(workflow.status ?? ''),
            title: workflow.content ?? '',
            chip: chipText,
            submittedBy: submittedBy,
            approvedBy: approvedBy,
            date: DateTime.parse(workflow.createdAt ?? '').formattedDate,
          ),
        );
      }
    }
    return workflowSteps;
  }

  WorkflowStepStatus determineWorkflowStatus(String status) {
    final s = status.toLowerCase();
    if (s == 'completed' || s == 'received' || s == 'approved' || s == 'sent') {
      return WorkflowStepStatus.approved;
    } else if (s == 'submitted') {
      return WorkflowStepStatus.submitted;
    } else if (s == 'pending') {
      return WorkflowStepStatus.pending;
    } else {
      return WorkflowStepStatus.inactive;
    }
  }

  List<FileInfo> createAttachmentsList() {
    List<FileInfo> files = [];
    if (state.requestDetails?.data?.attachments != null) {
      final attachments = state.requestDetails!.data!.attachments!;
      for (var file in attachments) {
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
    if (state.requestDetails?.data?.chatMessages != null) {
      final comments = state.requestDetails!.data!.chatMessages!;
      for (var comment in comments) {
        final isSelf = comment.user?.email == user?.email;
        commentsList.add(
          CommentEntryModel(
            userName: _getRoleName(comment.roleId),
            userInitials: getInitials(comment.user?.employeeName ?? ''),
            isSelf: isSelf,
            message: comment.message ?? '',
            statusLabel: comment.status,
            time: DateTime.parse(comment.createdAt ?? '').formattedDateTime,
          ),
        );
      }
    }
    return commentsList.reversed.toList();
  }

  String _getRoleName(int? roleId) {
    if (roleId == null) return "Employee";
    if (roleId == 2) return "Employee";
    
    final workflows = state.requestDetails?.data?.workflowDetails ?? [];
    for (var w in workflows) {
      if (w.roleId == roleId && w.role?.name != null) {
        return w.role!.name!;
      }
    }
    
    final approvals = state.requestDetails?.data?.approvalDetails ?? [];
    for (var a in approvals) {
      if (a.approverRoleId == roleId && a.approverRole?.name != null) {
        return a.approverRole!.name!;
      }
    }
    return "Employee";
  }

  String getInitials(String name) {
    if (name.trim().isEmpty) return '';
    List<String> names = name.trim().split(RegExp(r'\s+'));
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names[names.length - 1][0]).toUpperCase();
  }

  Future<void> addCommentInPassportRequest() async {
    // Left empty for now as there's no endpoint provided.
    // If an endpoint is provided, add logic here and re-fetch.
    commentController.clear();
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
      return _VsController(params);
    });
