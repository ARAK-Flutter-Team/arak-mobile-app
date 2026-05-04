// lib/features/conversations/presentation/widgets/text_message_bubble.dart
import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import 'message_status.dart';
import 'message_time.dart';

class TextMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isSending;     // اختياري - للـ optimistic update
  final bool hasError;      // اختياري - لو فشل الإرسال

  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.isSending = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // اسم المرسل (لطرف التاني بس)
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  message.senderName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

            // النص
            Text(
              message.content, // استخدمي content مش text
              style: TextStyle(
                color: isMe ? Colors.white : theme.colorScheme.onSurface,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 4),

            // الوقت + الحالة
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageTime(
                  time: message.sentAt, // استخدمي sentAt مش createdAt
                  isMe: isMe,
                ),
                if (isMe) ...[
                  const SizedBox(width: 6),
                  MessageStatusWidget(
                    isRead: message.isRead,  // من الباك
                    isSending: isSending,
                    hasError: hasError,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
