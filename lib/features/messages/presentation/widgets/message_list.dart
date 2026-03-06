import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message.dart';
import '../providers/chat_provider.dart';
import 'message_bubble.dart';

class MessageList extends ConsumerWidget {
  final String currentUserId;
  final ScrollController scrollController;

  const MessageList({
    super.key,
    required this.currentUserId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    if (state.isLoading) return const Center(child: CircularProgressIndicator());
    if (state.messages.isEmpty) return const Center(child: Text("No messages yet"));

    return ListView.builder(
      controller: scrollController,
      reverse: false,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final Message message = state.messages[index];
        final bool isMe = message.senderId == currentUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,
          onDeleteForMe: () => controller.deleteForMe(message.id),
          onDeleteForEveryone: () => controller.deleteForEveryone(message.id),
        );
      },
    );
  }
}