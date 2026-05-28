import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.otherPartyId,
    required super.otherPartyName,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
    required super.otherPartyRole,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final participant = json['participant'] as Map<String, dynamic>?;

    final otherPartyId = json['participantId']?.toString() ?? '';
    final otherPartyName = participant?['name']?.toString() ?? 'Unknown';

    // 🚀 INTEGRATION: Read the resolved role from participant DTO
    final otherPartyRole = participant?['role']?.toString() ?? 'Unknown';

    return ConversationModel(
      otherPartyId: otherPartyId,
      otherPartyName: otherPartyName,
      lastMessage: json['lastMessage']?.toString() ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'])
          : DateTime.now(),
      unreadCount: json['unreadCount'] as int? ?? 0,
      otherPartyRole: otherPartyRole,
    );
  }
}
