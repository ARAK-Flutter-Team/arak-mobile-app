import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../providers/chat_provider.dart';
import 'message_bubble.dart';

class MessageList extends ConsumerWidget {

  final String currentUserId;

  const MessageList({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(chatNotifierProvider);

    final notifier = ref.read(chatNotifierProvider.notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      reverse: true,
      itemCount: state.messages.length,

      itemBuilder: (context, index) {

        final Message message =
        state.messages[state.messages.length - 1 - index];

        final isMe = message.senderId == currentUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,

          onDeleteForMe: () {
            notifier.deleteForMe(message.id);
          },

          onDeleteForEveryone: () {
            notifier.deleteForEveryone(message.id);
          },
        );
      },
    );
  }
}