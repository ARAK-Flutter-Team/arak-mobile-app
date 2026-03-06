import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import 'message_model.dart';

class ConversationModel extends Conversation {

  const ConversationModel({
    required super.id,
    required super.participants,
    super.lastMessage,
    super.lastMessageTime,
    super.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {

    return ConversationModel(
      id: json['id'],

      participants: List<String>.from(json['participants']),

      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,

      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'])
          : null,

      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "id": id,
      "participants": participants,
      "lastMessage":
      (lastMessage as MessageModel?)?.toJson(),
      "lastMessageTime":
      lastMessageTime?.toIso8601String(),
      "unreadCount": unreadCount,
    };
  }
}