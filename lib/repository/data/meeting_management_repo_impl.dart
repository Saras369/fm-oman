import 'dart:developer';

import 'package:code_setup/modules/data/models/meeting_management/conversation_model.dart';
import 'package:code_setup/repository/domain/meeting_management_repo.dart';
import 'package:code_setup/utils/api_end_points.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:dio/dio.dart';

class MeetingManagementRepoImpl implements MeetingManagementRepo {
  @override
  Future<List<ConversationModel>?> fetchConversations(int userId) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.fetchConversations(userId),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final conversationResponse = ConversationResponse.fromJson(jsonMap);
          return conversationResponse.data;
        } else {
          final errorMessage =
              response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching conversations $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<MessageModel>?> fetchMessages(int conversationId) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.conversationMessages(conversationId),
        );
        if (response.statusCode == 200 && response.data != null) {
          final jsonMap = Map<String, dynamic>.from(response.data);
          final messageResponse = MessageResponse.fromJson(jsonMap);
          return messageResponse.data;
        } else {
          final errorMessage = response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error fetching messages $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<MessageModel?> sendMessage(int conversationId, Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(
          ApiEndPoint.conversationMessages(conversationId),
          data: data,
        );
        if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
          if (response.data is Map) {
            final jsonMap = Map<String, dynamic>.from(response.data);
            final messageResponse = MessageResponse.fromJson(jsonMap);
            // POST API typically returns the created object or a MessageResponse with the single message
            return (messageResponse.data != null && messageResponse.data!.isNotEmpty) ? messageResponse.data!.first : null;
          }
          // If the backend returns an integer ID instead of an object, safely ignore since we re-fetch immediately anyway.
          return null;
        } else {
          final errorMessage = response.data?['message'] ?? 'Unexpected error occurred';
          throw ApiException(errorMessage);
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error sending message $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<List<Participant>?> searchUsers(String query) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.get(
          ApiEndPoint.searchUsers,
          queryParameters: {
            'offset': 1,
            'limit': 20,
            'search_text': query,
          },
        );
        if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
          final dataMap = Map<String, dynamic>.from(response.data);
          if (dataMap['data'] is List) {
            final list = dataMap['data'] as List;
            return list.map((e) => Participant.fromJson(Map<String, dynamic>.from(e))).toList();
          }
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error in user search');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error searching users $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ConversationModel?> createDirectChat(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(ApiEndPoint.createDirectChat, data: data);
        if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
          final dataMap = Map<String, dynamic>.from(response.data);
          if (dataMap['data'] != null && dataMap['data'] is Map) {
             return ConversationModel.fromJson(Map<String, dynamic>.from(dataMap['data']));
          } else if (dataMap['data'] is int) {
             // Just in case backend returns ID
             log("Direct chat created with ID: \${dataMap['data']}");
             return ConversationModel(conversationId: dataMap['data']);
          }
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error in createDirectChat');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating direct chat $e');
      throw ApiException(e.toString());
    }
  }

  @override
  Future<ConversationModel?> createGroupChat(Map<String, dynamic> data) async {
    try {
      final client = await KAppX.network.secureClient();
      if (client != null) {
        final response = await client.post(ApiEndPoint.createGroupChat, data: data);
        if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
          final dataMap = Map<String, dynamic>.from(response.data);
          if (dataMap['data'] != null && dataMap['data'] is Map) {
             return ConversationModel.fromJson(Map<String, dynamic>.from(dataMap['data']));
          } else if (dataMap['data'] is int) {
             return ConversationModel(conversationId: dataMap['data']);
          }
        }
      }
      return null;
    } on DioException catch (error) {
      log('caught error in createGroupChat');
      final message = error.response?.data['message'] ?? error.message;
      throw ApiException(message);
    } catch (e) {
      log('error creating group chat $e');
      throw ApiException(e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
