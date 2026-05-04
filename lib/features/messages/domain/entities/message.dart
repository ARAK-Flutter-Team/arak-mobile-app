// lib/features/conversations/domain/entities/message.dart
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.content,
    required this.sentAt,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
    id,
    senderId,
    senderName,
    receiverId,
    receiverName,
    content,
    sentAt,
    isRead,
  ];

  String get text => content;
  DateTime get createdAt => sentAt;
}