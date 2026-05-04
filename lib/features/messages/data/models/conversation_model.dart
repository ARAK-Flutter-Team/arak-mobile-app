// lib/features/conversations/data/models/conversation_model.dart
/*import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.otherPartyId,
    required super.otherPartyName,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final participant = json['participant'] as Map<String, dynamic>?;

    // ✅ important: use participantId directly from json
    final otherPartyId = json['participantId']?.toString() ?? '';
    final otherPartyName = participant?['name']?.toString() ?? 'Unknown';

    // ✅ skip conversation with self
    return ConversationModel(
      otherPartyId: otherPartyId,
      otherPartyName: otherPartyName,
      lastMessage: json['lastMessage']?.toString() ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'])
          : DateTime.now(),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }
}*/
import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.otherPartyId,
    required super.otherPartyName,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final participant = json['participant'] as Map<String, dynamic>?;

    final otherPartyId = json['participantId']?.toString() ?? '';
    final otherPartyName = participant?['name']?.toString() ?? 'Unknown';

    return ConversationModel(
      otherPartyId: otherPartyId,
      otherPartyName: otherPartyName,
      lastMessage: json['lastMessage']?.toString() ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'])
          : DateTime.now(),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  /// ✅ دالة copyWith لتحديث البيانات
  ConversationModel copyWith({
    String? otherPartyId,
    String? otherPartyName,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
  }) {
    return ConversationModel(
      otherPartyId: otherPartyId ?? this.otherPartyId,
      otherPartyName: otherPartyName ?? this.otherPartyName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  /// ✅ تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'participantId': otherPartyId,
      'participant': {
        'name': otherPartyName,
        'avatar': '',
      },
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }

  @override
  String toString() {
    return 'ConversationModel(otherPartyId: $otherPartyId, otherPartyName: $otherPartyName, lastMessage: $lastMessage, unreadCount: $unreadCount)';
  }
}