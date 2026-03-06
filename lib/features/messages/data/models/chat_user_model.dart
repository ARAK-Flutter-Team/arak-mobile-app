import '../../domain/entities/chat_user.dart';
import '../../domain/enums/user_status.dart';

class ChatUserModel extends ChatUser {

  const ChatUserModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.role,
    required super.status,
    super.lastSeen,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {

    return ChatUserModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      role: json['role'],

      status: UserStatus.values.firstWhere(
            (e) => e.name == json['status'],
      ),

      lastSeen: json['lastSeen'] != null
          ? DateTime.parse(json['lastSeen'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "id": id,
      "name": name,
      "avatarUrl": avatarUrl,
      "role": role,
      "status": status.name,
      "lastSeen": lastSeen?.toIso8601String(),
    };
  }
}