import 'package:code_setup/modules/data/models/meeting_management/conversation_model.dart';
import 'package:code_setup/repository/data/meeting_management_repo_impl.dart';

abstract class MeetingManagementRepo {
  factory MeetingManagementRepo() => MeetingManagementRepoImpl();

  Future<List<ConversationModel>?> fetchConversations(int userId);
  Future<List<MessageModel>?> fetchMessages(int conversationId);
  Future<MessageModel?> sendMessage(int conversationId, Map<String, dynamic> data);
  Future<List<Participant>?> searchUsers(String query);
  Future<ConversationModel?> createDirectChat(Map<String, dynamic> data);
  Future<ConversationModel?> createGroupChat(Map<String, dynamic> data);
}
