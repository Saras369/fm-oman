part of 'view.dart';

class _VSControllerParams {
  final int requestId;

  _VSControllerParams({required this.requestId});
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

  _VsController(this.params)
    : super(_ViewState(isLoading: true, requestDetails: []));

  void showLoading(bool v) => state = state.copyWith(isLoading: v);

  Future<void> fetchRequestDetailsById() async {
    final finRepo = FinancialServicesRepo();
    state = state.copyWith(isLoading: true);
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

  Future<void> addCommentInFinRequest() async {
    final finRepo = FinancialServicesRepo();
    try {
      await finRepo.addCommentInFinRequest(params.requestId, {
        'content': commentController.text,
      });
      fetchRequestDetailsById();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {}
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
