import 'message.dart';

class Conversation {
  final String id;
  final List<String> participants;
  final Message? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });
}