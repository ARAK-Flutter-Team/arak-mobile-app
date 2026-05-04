// lib/features/conversations/presentation/widgets/conversation_tile.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/conversation.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final String currentUserId;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Text(
          conversation.otherPartyName.isNotEmpty
              ? conversation.otherPartyName[0].toUpperCase()
              : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        conversation.otherPartyName,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: conversation.unreadCount > 0
              ? theme.colorScheme.primary
              : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
          fontWeight: conversation.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(conversation.lastMessageTime),
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
            ),
          ),
          if (conversation.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${conversation.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        context.push(
          '/chat',
          extra: {
            "currentUserId": currentUserId,
            "otherUserId": conversation.otherPartyId,
            "name": conversation.otherPartyName,
            "role": "parent",
            "avatarUrl": "",
          },
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(time.year, time.month, time.day);

    if (date == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}';
    }
  }
}