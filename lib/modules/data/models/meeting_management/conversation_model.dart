class ConversationResponse {
  final String? status;
  final List<ConversationModel>? data;

  ConversationResponse({this.status, this.data});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class ConversationModel {
  final int? conversationId;
  final String? conversationType;
  final String? conversationName;
  final int? unreadCount;
  final DateTime? lastMessageAt;
  final LastMessage? lastMessage;
  final List<Participant>? participants;

  ConversationModel({
    this.conversationId,
    this.conversationType,
    this.conversationName,
    this.unreadCount,
    this.lastMessageAt,
    this.lastMessage,
    this.participants,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      conversationId: json['conversation_id'] is int
          ? json['conversation_id'] as int
          : (json['conversation_id'] != null
                ? int.tryParse('${json['conversation_id']}')
                : null),
      conversationType: json['conversation_type'] as String?,
      conversationName: json['conversation_name'] as String?,
      unreadCount: json['unread_count'] is int
          ? json['unread_count'] as int
          : (json['unread_count'] != null
                ? int.tryParse('${json['unread_count']}')
                : null),
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.tryParse(json['last_message_at'] as String)
          : null,
      lastMessage: json['last_message'] == null
          ? null
          : LastMessage.fromJson(json['last_message'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'conversation_id': conversationId,
    'conversation_type': conversationType,
    'conversation_name': conversationName,
    'unread_count': unreadCount,
    'last_message_at': lastMessageAt?.toIso8601String(),
    'last_message': lastMessage?.toJson(),
    'participants': participants?.map((e) => e.toJson()).toList(),
  };
}

class LastMessage {
  final int? id;
  final String? content;
  final String? messageType;
  final DateTime? createdAt;
  final int? senderId;
  final String? senderName;

  LastMessage({
    this.id,
    this.content,
    this.messageType,
    this.createdAt,
    this.senderId,
    this.senderName,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'] is int
          ? json['id'] as int
          : (json['id'] != null ? int.tryParse('${json['id']}') : null),
      content: json['content'] as String?,
      messageType: json['message_type'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      senderId: json['sender_id'] is int
          ? json['sender_id'] as int
          : (json['sender_id'] != null
                ? int.tryParse('${json['sender_id']}')
                : null),
      senderName: json['sender_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'message_type': messageType,
    'created_at': createdAt?.toIso8601String(),
    'sender_id': senderId,
    'sender_name': senderName,
  };
}

class Participant {
  final int? userId;
  final String? userName;
  final String? email;
  final String? avatar;
  final String? employeeId;
  final String? mobile;
  final bool? isAdmin;
  final Map<String, dynamic>? department;
  final Map<String, dynamic>? designation;
  final Map<String, dynamic>? division;

  Participant({
    this.userId,
    this.userName,
    this.email,
    this.avatar,
    this.employeeId,
    this.mobile,
    this.isAdmin,
    this.department,
    this.designation,
    this.division,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['user_id'] is int
          ? json['user_id'] as int
          : (json['user_id'] != null
                ? int.tryParse('${json['user_id']}')
                : (json['id'] is int 
                    ? json['id'] as int 
                    : (json['id'] != null ? int.tryParse('${json['id']}') : null))),
      userName:
          json['user_name'] as String? ?? json['employee_name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      employeeId: json['employee_id'] as String?,
      mobile: json['mobile'] as String?,
      isAdmin: json['is_admin'] as bool?,
      department: json['departmentDetails'] as Map<String, dynamic>? ?? 
          (json['department'] is Map ? json['department'] as Map<String, dynamic>? : null),
      designation: json['designationDetails'] as Map<String, dynamic>? ?? 
          (json['designation'] is Map ? json['designation'] as Map<String, dynamic>? : null),
      division: json['divisionDetails'] as Map<String, dynamic>? ?? 
          (json['division'] is Map ? json['division'] as Map<String, dynamic>? : null),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'user_name': userName,
    'email': email,
    'avatar': avatar,
    'employee_id': employeeId,
    'mobile': mobile,
    'is_admin': isAdmin,
    'department': department,
    'designation': designation,
    'division': division,
  };
}

class MessageResponse {
  final String? status;
  final List<MessageModel>? data;

  MessageResponse({this.status, this.data});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    List<MessageModel>? parsedData;
    if (json['data'] != null) {
      if (json['data'] is Map && json['data']['messages'] != null) {
        parsedData = (json['data']['messages'] as List<dynamic>)
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (json['data'] is List) {
        parsedData = (json['data'] as List<dynamic>)
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (json['data'] is Map) {
        // Single message response from POST
        parsedData = [
          MessageModel.fromJson(json['data'] as Map<String, dynamic>),
        ];
      }
    }

    return MessageResponse(status: json['status'] as String?, data: parsedData);
  }
}

class MessageModel {
  final int? id;
  final int? conversationId;
  final int? senderId;
  final String? messageType;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? attachmentUrl;
  final String? attachmentName;
  final int? replyToMessageId;
  final Participant? sender;

  MessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.messageType,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.attachmentUrl,
    this.attachmentName,
    this.replyToMessageId,
    this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] is int
          ? json['id'] as int
          : (json['id'] != null ? int.tryParse('${json['id']}') : null),
      conversationId: json['conversation_id'] is int
          ? json['conversation_id'] as int
          : (json['conversation_id'] != null
                ? int.tryParse('${json['conversation_id']}')
                : null),
      senderId: json['sender_id'] is int
          ? json['sender_id'] as int
          : (json['sender_id'] != null
                ? int.tryParse('${json['sender_id']}')
                : null),
      messageType: json['message_type'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      attachmentUrl: json['attachment_url'] as String?,
      attachmentName: json['attachment_name'] as String?,
      replyToMessageId: json['reply_to_message_id'] as int?,
      sender: json['sender'] == null
          ? null
          : Participant.fromJson(json['sender'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversation_id': conversationId,
    'sender_id': senderId,
    'message_type': messageType,
    'content': content,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'attachment_url': attachmentUrl,
    'attachment_name': attachmentName,
    'reply_to_message_id': replyToMessageId,
    'sender': sender?.toJson(),
  };
}
