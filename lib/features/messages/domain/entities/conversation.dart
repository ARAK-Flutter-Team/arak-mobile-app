// lib/features/conversations/domain/entities/conversation.dart
import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String otherPartyId;
  final String otherPartyName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const Conversation({
    required this.otherPartyId,
    required this.otherPartyName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
    otherPartyId,
    otherPartyName,
    lastMessage,
    lastMessageTime,
    unreadCount,
  ];
}