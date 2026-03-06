/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message.dart';
import '../providers/chat_provider.dart';
import 'message_bubble.dart';

class MessageList extends ConsumerWidget {
  final String currentUserId;
  final String otherUserId; // نحتاج الـ receiver أو الشخص التاني
  final ScrollController scrollController;

  const MessageList({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.scrollController,
  });

  // توليد chatId ثابت للشات بين شخصين (مثل ما في الـ controller)
  String chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    final id = chatId(currentUserId, otherUserId);
    final messages = state.messagesMap[id] ?? [];

    if (state.isLoading) return const Center(child: CircularProgressIndicator());
    if (messages.isEmpty) return const SizedBox();

    return ListView.builder(
      controller: scrollController,
      reverse: true, // عادة الرسائل الأخيرة تظهر تحت مثل واتساب
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final Message message = messages[index];
        final bool isMe = message.senderId == currentUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,
          onDeleteForMe: () => controller.deleteForMe(
            currentUserId,
            otherUserId,
            message.id,
          ),
          onDeleteForEveryone: () => controller.deleteForEveryone(
            currentUserId,
            otherUserId,
            message.id,
          ),
        );
      },
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../providers/chat_provider.dart';
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

  // توليد chatId ثابت بين المستخدمين
  String chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatControllerProvider);
    final controller = ref.read(chatControllerProvider.notifier);

    final id = chatId(currentUserId, otherUserId);

    // الرسائل الخاصة بهذا الشات فقط
    final List<Message> messages = state.messagesMap[id] ?? [];

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (messages.isEmpty) {
      return const Center(
        child: Text("No messages yet"),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final Message message = messages[index];

        final bool isMe = message.senderId == currentUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,

          // حذف الرسالة عندي فقط
          onDeleteForMe: () {
            controller.deleteForMe(
              currentUserId,
              otherUserId,
              message.id,
            );
          },

          // حذف الرسالة للجميع
          onDeleteForEveryone: () {
            controller.deleteForEveryone(
              currentUserId,
              otherUserId,
              message.id,
            );
          },
        );
      },
    );
  }
}