import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import 'message_status.dart';
import 'message_time.dart';

class TextMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text ?? "",
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageTime(time: message.createdAt, isMe: isMe), // حذف isMe لو مش موجود في الـ widget
                const SizedBox(width: 6),
                if (isMe)
                  MessageStatusWidget(
                    status: message.status, // ضروري تمرر status
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}