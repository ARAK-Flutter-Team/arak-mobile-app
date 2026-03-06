import '../enums/message_type.dart';
import '../enums/message_status.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;

  final String? text;
  final String? fileUrl;

  final MessageType type;
  final MessageStatus status;

  final DateTime createdAt;

  final bool deletedForEveryone;

  final String? replyToMessageId;

  final int? duration;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.text,
    this.fileUrl,
    required this.type,
    required this.status,
    required this.createdAt,
    this.deletedForEveryone = false,
    this.replyToMessageId,
    this.duration,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? text,
    String? fileUrl,
    MessageType? type,
    MessageStatus? status,
    DateTime? createdAt,
    bool? deletedForEveryone,
    String? replyToMessageId,
    int? duration,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      fileUrl: fileUrl ?? this.fileUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deletedForEveryone: deletedForEveryone ?? this.deletedForEveryone,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      duration: duration ?? this.duration,
    );
  }
}