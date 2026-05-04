// lib/features/conversations/data/models/message_model.dart
import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.senderName,
    required super.receiverId,
    required super.receiverName,
    required super.content,
    required super.sentAt,
    required super.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      receiverId: json['receiverId'] as String,
      receiverName: json['receiverName'] as String,
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}