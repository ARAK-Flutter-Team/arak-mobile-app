import '../enums/user_status.dart';

class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final String role;
  final UserStatus status;
  final DateTime? lastSeen;

  const ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.role,
    required this.status,
    this.lastSeen,
  });
}