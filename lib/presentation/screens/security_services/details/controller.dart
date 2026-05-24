part of 'view.dart';

class _SecurityDetailsControllerParams extends Equatable {
  final int requestId;
  final String slug;
  final String title;

  const _SecurityDetailsControllerParams({
    required this.requestId,
    required this.slug,
    required this.title,
  });

  @override
  List<Object?> get props => [requestId, slug, title];
}

class _SecurityDetailsViewState {
  final bool isLoading;
  final Map<String, dynamic> requestDetails;

  const _SecurityDetailsViewState({
    required this.isLoading,
    required this.requestDetails,
  });

  _SecurityDetailsViewState copyWith({
    bool? isLoading,
    Map<String, dynamic>? requestDetails,
  }) {
    return _SecurityDetailsViewState(
      isLoading: isLoading ?? this.isLoading,
      requestDetails: requestDetails ?? this.requestDetails,
    );
  }
}

class _SecurityDetailsController
    extends StateNotifier<_SecurityDetailsViewState> {
  final _SecurityDetailsControllerParams params;
  final securityRepo = SecurityServicesRepo();

  _SecurityDetailsController(this.params)
    : super(
        const _SecurityDetailsViewState(isLoading: true, requestDetails: {}),
      );

  Map<String, dynamic> get request => _requestMap(state.requestDetails);

  String get contactNumber =>
      _stringValue(request['contact_number']) ??
      _stringValue(request['mobile_number']) ??
      _stringValue(request['visitor_phone_number']) ??
      '';

  Future<void> fetchRequestDetailsById() async {
    state = state.copyWith(isLoading: true);
    try {
      final details = await securityRepo.fetchRequestDetails(
        params.slug,
        params.requestId,
      );
      state = state.copyWith(requestDetails: details ?? {}, isLoading: false);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  List<WorkflowTimelineStep> createWorkflowList() {
    final workflowItems = _listFromAny(
      state.requestDetails['workflows'] ??
          state.requestDetails['workflow_details'] ??
          request['workflows'] ??
          request['workflow_details'],
    );

    return workflowItems.map((workflow) {
      final status = _stringValue(
        workflow['status'] ?? workflow['approval_status'],
      );
      return WorkflowTimelineStep(
        status: _workflowStatus(status),
        title:
            _stringValue(
              workflow['content'] ??
                  workflow['description'] ??
                  workflow['activity'] ??
                  workflow['step_name'] ??
                  workflow['name'],
            ) ??
            'Workflow step',
        date: _formatDate(
          _stringValue(
            workflow['activity_date'] ??
                workflow['created_at'] ??
                workflow['updated_at'],
          ),
        ),
      );
    }).toList();
  }

  List<FileInfo> createAttachmentsList() {
    final attachmentItems = _listFromAny(
      state.requestDetails['attachments'] ?? request['attachments'],
    );

    return attachmentItems.map((file) {
      final name =
          _stringValue(
            file['file_name'] ??
                file['filename'] ??
                file['name'] ??
                file['document_name'],
          ) ??
          'Attachment';
      return FileInfo(
        name: name,
        type:
            _stringValue(
              file['file_type'] ?? file['type'] ?? file['mime_type'],
            ) ??
            '',
        uploadedDate: _formatDate(
          _stringValue(file['created_at'] ?? file['uploaded_date']),
        ),
        downloadable: true,
        viewable: true,
        onDownload: () {},
        onView: () {},
      );
    }).toList();
  }

  List<CommentEntryModel> createChatList() {
    final user = KAppX.globalProvider.read(userProvider);
    final comments = _listFromAny(
      state.requestDetails['chats'] ??
          state.requestDetails['chat_messages'] ??
          request['chats'] ??
          request['chat_messages'],
    );

    return comments.map((comment) {
      final sender = _mapFromAny(
        comment['sender_user_id'] ??
            comment['senderUser'] ??
            comment['user'] ??
            comment['created_by_user'],
      );
      final userName =
          _stringValue(
            sender?['employee_name'] ??
                sender?['name'] ??
                comment['sender_name'] ??
                comment['created_by'],
          ) ??
          'User';
      final senderId = readJsonInt(sender?['id'] ?? comment['sender_user_id']);

      return CommentEntryModel(
        userName: userName,
        userInitials: _getInitials(userName),
        isSelf: senderId != null && senderId == user?.userId,
        message:
            _stringValue(
              comment['content'] ?? comment['message'] ?? comment['comment'],
            ) ??
            '',
        statusLabel:
            _stringValue(comment['status'] ?? comment['approval_status']) ??
            'Submitted',
        time: _formatDate(_stringValue(comment['created_at'])),
      );
    }).toList();
  }
}

final _securityDetailsProvider = StateNotifierProvider.autoDispose
    .family<
      _SecurityDetailsController,
      _SecurityDetailsViewState,
      _SecurityDetailsControllerParams
    >((ref, params) {
      final controller = _SecurityDetailsController(params);
      controller.fetchRequestDetailsById();
      return controller;
    });

Map<String, dynamic> _requestMap(Map<String, dynamic> details) {
  final request =
      _mapFromAny(details['request']) ??
      _mapFromAny(details['data']) ??
      details;
  return request;
}

Map<String, dynamic>? _mapFromAny(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

List<Map<String, dynamic>> _listFromAny(dynamic value) {
  if (value is List) {
    return value.map(_mapFromAny).whereType<Map<String, dynamic>>().toList();
  }
  return [];
}

String? _stringValue(dynamic value) => readJsonString(value)?.trim();

String _formatDate(String? raw) {
  if (raw == null || raw.isEmpty) return '';
  final parsed = DateTime.tryParse(raw);
  return parsed == null ? raw : parsed.formattedDate;
}

WorkflowStepStatus _workflowStatus(String? status) {
  switch (status?.toLowerCase()) {
    case 'completed':
    case 'approved':
      return WorkflowStepStatus.approved;
    case 'pending':
    case 'in progress':
      return WorkflowStepStatus.pending;
    default:
      return WorkflowStepStatus.inactive;
  }
}

String _getInitials(String name) {
  if (name.trim().isEmpty) return '';
  final names = name.trim().split(RegExp(r'\s+'));
  if (names.length == 1) return names.first[0].toUpperCase();
  return (names.first[0] + names.last[0]).toUpperCase();
}
