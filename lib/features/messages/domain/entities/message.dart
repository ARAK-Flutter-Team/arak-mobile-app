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

  final int? duration; // 👈 مهم للصوت

  Message({
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
}