// lib/features/messages/presentation/widgets/conversation_tile.dart
import 'package:flutter/material.dart';
import '../../domain/entities/conversation.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 🚀 INTEGRATION: Render dynamic, visually appealing role badges
    Color roleBadgeColor;
    String roleLabel;

    switch (conversation.otherPartyRole) {
      case 'Teacher':
        roleBadgeColor = Colors.blue.shade700;
        roleLabel = 'Teacher';
        break;
      case 'Parent':
        roleBadgeColor = Colors.orange.shade700;
        roleLabel = 'Parent';
        break;
      case 'Admin':
      case 'Super Admin':
        roleBadgeColor = Colors.red.shade700;
        roleLabel = 'Admin';
        break;
      default:
        roleBadgeColor = Colors.grey.shade600;
        roleLabel = 'User';
    }

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: roleBadgeColor.withOpacity(0.1),
        child: Text(
          conversation.otherPartyName.isNotEmpty
              ? conversation.otherPartyName[0].toUpperCase()
              : '?',
          style: TextStyle(color: roleBadgeColor, fontWeight: FontWeight.bold),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              conversation.otherPartyName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          // 🚀 Dynamic Badge for system role context
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: roleBadgeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              roleLabel,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTime(conversation.lastMessageTime),
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          const SizedBox(height: 4),
          if (conversation.unreadCount > 0)
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.red,
              child: Text(
                conversation.unreadCount.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final amPm = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }
}
