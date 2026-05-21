part of 'view.dart';

class _VSControllerParams extends Equatable {
  final int serviceId;
  final List<SubServices> subServicesList;

  _VSControllerParams({required this.serviceId, required this.subServicesList});

  @override
  List<Object?> get props => [serviceId, subServicesList];
}

final _paramProvider = Provider<_VSControllerParams>((ref) {
  throw UnimplementedError();
});

final _vsProvider = StateNotifierProvider.autoDispose
    .family<_VSController, _ViewState, _VSControllerParams>((ref, params) {
      final stateController = _VSController(params);

      stateController.initState();

      return stateController;
    });

extension ConversationModelUI on ConversationModel {
  String get name => conversationName ?? "Unknown";
  String get initials {
    if (name.isEmpty) return "U";
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length > 1) {
      if (parts[1].isNotEmpty) {
        return "${parts[0][0]}${parts[1][0]}".toUpperCase();
      }
    }
    return name[0].toUpperCase();
  }

  String get lastMessageText => lastMessage?.content ?? "No messages yet";
  String get timeStr {
    if (lastMessage?.createdAt == null) return "";
    final date = lastMessage!.createdAt!;
    return "${date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'pm' : 'am'}";
  }

  Color get color {
    final colors = [
      Colors.blue[200]!,
      Colors.green[200]!,
      Colors.orange[200]!,
      Colors.purple[200]!,
    ];
    final index = (conversationId ?? 0) % colors.length;
    return colors[index];
  }
}

extension MessageModelUI on MessageModel {
  bool get isMe {
    final currentUserId =
        KAppX.globalProvider.read(userProvider)?.userId ?? 109;
    return senderId == currentUserId;
  }

  String get displayTime {
    if (createdAt == null) return "";
    final date = createdAt!.toLocal();
    return "${date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'pm' : 'am'}";
  }

  String get displayText => content ?? "";

  String get senderDisplayName => sender?.userName ?? "";
}

class _ViewState {
  final bool isLoading;
  final bool isMessagesLoading;
  final ConversationModel? selectedContact;
  final List<ConversationModel> contacts;
  final List<MessageModel> messages;
  final String searchKey;
  final String activeFilter;
  final String? error;

  _ViewState({
    required this.isLoading,
    required this.isMessagesLoading,
    this.selectedContact,
    required this.contacts,
    required this.messages,
    required this.searchKey,
    required this.activeFilter,
    this.error,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        isMessagesLoading: false,
        contacts: [],
        messages: [],
        searchKey: '',
        activeFilter: 'All',
      );

  List<ConversationModel> get filteredContacts {
    var filtered = contacts;

    // Apply active filter
    if (activeFilter == 'Groups') {
      filtered = filtered
          .where((c) => c.conversationType?.toLowerCase() == 'group')
          .toList();
    } else if (activeFilter == 'Unread') {
      filtered = filtered.where((c) => (c.unreadCount ?? 0) > 0).toList();
    }

    // Apply search key
    if (searchKey.trim().isNotEmpty) {
      final key = searchKey.trim().toLowerCase();
      filtered = filtered.where((c) {
        final name = c.conversationName?.toLowerCase() ?? '';
        return name.contains(key);
      }).toList();
    }

    return filtered;
  }

  _ViewState copyWith({
    bool? isLoading,
    bool? isMessagesLoading,
    ConversationModel? selectedContact,
    List<ConversationModel>? contacts,
    List<MessageModel>? messages,
    String? searchKey,
    String? activeFilter,
    String? error,
    bool clearSelectedContact = false,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      isMessagesLoading: isMessagesLoading ?? this.isMessagesLoading,
      selectedContact: clearSelectedContact
          ? null
          : (selectedContact ?? this.selectedContact),
      contacts: contacts ?? this.contacts,
      messages: messages ?? this.messages,
      searchKey: searchKey ?? this.searchKey,
      activeFilter: activeFilter ?? this.activeFilter,
      error: error ?? this.error,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  final _VSControllerParams params;
  final MeetingManagementRepo _repo = MeetingManagementRepo();

  _VSController(this.params) : super(_ViewState.init());

  Future<void> initState() async {
    await fetchConversations();
  }

  Future<void> fetchConversations() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = KAppX.globalProvider.read(userProvider);
      final userId =
          user?.userId ??
          109; // Defaulting to 109 as per requirements for testing
      final data = await _repo.fetchConversations(userId);
      state = state.copyWith(isLoading: false, contacts: data ?? []);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> selectContact(ConversationModel contact) async {
    state = state.copyWith(
      selectedContact: contact,
      isMessagesLoading: true,
      messages: [],
    );

    try {
      final messages = await _repo.fetchMessages(contact.conversationId!);
      if (state.selectedContact?.conversationId == contact.conversationId) {
        state = state.copyWith(
          isMessagesLoading: false,
          messages: messages ?? [],
        );
      }
    } catch (e) {
      if (state.selectedContact?.conversationId == contact.conversationId) {
        state = state.copyWith(isMessagesLoading: false, error: e.toString());
      }
    }
  }

  void clearSelectedContact() {
    state = state.copyWith(clearSelectedContact: true, messages: []);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.selectedContact == null) return;

    final contact = state.selectedContact!;
    final userId = KAppX.globalProvider.read(userProvider)?.userId ?? 109;

    final requestBody = {
      "senderId": userId,
      "roleId": 2,
      "content": text.trim(),
      "conversationType": contact.conversationType?.toLowerCase() == 'group'
          ? 'Group'
          : 'Direct',
      "messageType": "text",
      "replyToMessageId": null,
    };

    try {
      await _repo.sendMessage(contact.conversationId!, requestBody);

      // Re-fetch all messages after successfully sending per requirements
      if (state.selectedContact?.conversationId == contact.conversationId) {
        final messages = await _repo.fetchMessages(contact.conversationId!);
        if (state.selectedContact?.conversationId == contact.conversationId) {
          state = state.copyWith(messages: messages ?? []);
        }
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void searchContacts(String query) {
    state = state.copyWith(searchKey: query);
  }

  void setFilter(String filter) {
    state = state.copyWith(activeFilter: filter);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
