import 'dart:async';
import 'dart:developer';

import 'package:code_setup/modules/data/models/meeting_management/conversation_model.dart';
import 'package:code_setup/repository/domain/meeting_management_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewChatState {
  final bool isLoading;
  final String searchQuery;
  final List<Participant> searchResults;
  final List<Participant> selectedUsers;

  NewChatState({
    required this.isLoading,
    required this.searchQuery,
    required this.searchResults,
    required this.selectedUsers,
  });

  NewChatState copyWith({
    bool? isLoading,
    String? searchQuery,
    List<Participant>? searchResults,
    List<Participant>? selectedUsers,
  }) {
    return NewChatState(
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      selectedUsers: selectedUsers ?? this.selectedUsers,
    );
  }
}

class NewChatController extends StateNotifier<NewChatState> {
  final MeetingManagementRepo repo;
  Timer? _debounceTimer;

  NewChatController(this.repo)
      : super(NewChatState(
          isLoading: false,
          searchQuery: '',
          searchResults: [],
          selectedUsers: [],
        ));

  void searchUsers(String query) {
    state = state.copyWith(searchQuery: query);

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    if (query.trim().isEmpty) {
      state = state.copyWith(searchResults: [], isLoading: false);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = state.copyWith(isLoading: true);
      try {
        final results = await repo.searchUsers(query);
        // Filter out users that are already selected
        final selectedUserIds = state.selectedUsers.map((u) => u.userId).toSet();
        final filteredResults = (results ?? []).where((u) => !selectedUserIds.contains(u.userId)).toList();
        
        state = state.copyWith(
          searchResults: filteredResults,
          isLoading: false,
        );
      } catch (e) {
        log('Error searching users: $e');
        state = state.copyWith(isLoading: false, searchResults: []);
      }
    });
  }

  void addUser(Participant user) {
    if (state.selectedUsers.any((u) => u.userId == user.userId)) return;

    final updatedSelected = List<Participant>.from(state.selectedUsers)..add(user);
    final updatedResults = state.searchResults.where((u) => u.userId != user.userId).toList();

    state = state.copyWith(
      selectedUsers: updatedSelected,
      searchResults: updatedResults,
    );
  }

  void removeUser(Participant user) {
    final updatedSelected = state.selectedUsers.where((u) => u.userId != user.userId).toList();
    
    state = state.copyWith(
      selectedUsers: updatedSelected,
    );

    // Optionally re-run search to put them back in the results list if they match the query
    if (state.searchQuery.trim().isNotEmpty) {
      searchUsers(state.searchQuery);
    }
  }
  Future<bool> startChat(int currentUserId) async {
    if (state.selectedUsers.isEmpty) return false;

    state = state.copyWith(isLoading: true);
    try {
      if (state.selectedUsers.length == 1) {
        // Direct chat
        await repo.createDirectChat({
          "senderId": currentUserId,
          "receiverId": state.selectedUsers.first.userId,
        });
      } else {
        // Group chat
        // participants includes selected + current user
        final participantIds = state.selectedUsers.map((u) => u.userId).toList();
        if (!participantIds.contains(currentUserId)) {
          participantIds.add(currentUserId);
        }

        final groupNames = state.selectedUsers.map((u) => u.userName?.split(' ').first ?? 'User').toList();
        final groupNameStr = groupNames.join(', ');

        await repo.createGroupChat({
          "groupName": groupNameStr,
          "createdBy": currentUserId,
          "participants": participantIds,
        });
      }
      
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      log('Error creating chat: $e');
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}

final newChatControllerProvider = StateNotifierProvider.autoDispose<NewChatController, NewChatState>((ref) {
  final repo = MeetingManagementRepo();
  return NewChatController(repo);
});
