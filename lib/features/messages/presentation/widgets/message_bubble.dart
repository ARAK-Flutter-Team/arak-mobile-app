// lib/features/conversations/presentation/widgets/message_bubble.dart
import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import 'text_message_bubble.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isSending;
  final bool hasError;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.isSending = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    // حالياً بنستخدم text بس
    // لما الباك يدعم صورة/ملف/صوت هنضيفهم تاني
    return TextMessageBubble(
      message: message,
      isMe: isMe,
      isSending: isSending,
      hasError: hasError,
    );
  }
}