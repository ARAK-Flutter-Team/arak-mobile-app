import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/conversation_providers.dart';
import 'message_bubble.dart';

class MessageList extends ConsumerWidget {
  final String currentUserId;
  final String otherUserId;
  final ScrollController scrollController;

  const MessageList({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.scrollController,
  });

  String _chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    final chatId = _chatId(currentUserId, otherUserId);
    final allMessages = state.messagesMap[chatId] ?? [];

    final messages = allMessages.where((msg) {
      return (msg.senderId == currentUserId && msg.receiverId == otherUserId) ||
          (msg.senderId == otherUserId && msg.receiverId == currentUserId);
    }).toList();

    // بنرتب تنازلي (جديد -> قديم) عشان يتوافق مع reverse: true
    final sortedMessages = List.of(messages)
      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));

    final loc = AppLocalizations.of(context)!;

    if (state.isLoading && messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              loc.noMessages,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              loc.typeMessageHint,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: sortedMessages.length,
      itemBuilder: (context, index) {
        final message = sortedMessages[index];
        final isMe = message.senderId == currentUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,
        );
      },
    );
  }
}