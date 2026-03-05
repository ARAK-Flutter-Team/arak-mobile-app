/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_notifier.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends ConsumerStatefulWidget {

  final String otherUserId;
  final String otherUserName;
  final String otherUserAvatar;
  final String otherUserRole;

  const ChatScreen({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserAvatar,
    required this.otherUserRole,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState
    extends ConsumerState<ChatScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {

      final currentUser =
          ref.read(authProvider).user;

      ref.read(chatProvider.notifier).loadMessages(
        currentUser!.id,
        widget.otherUserId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(chatProvider);

    final currentUser =
        ref.watch(authProvider).user;

    return Scaffold(

      appBar: ChatAppBar(
        name: widget.otherUserName,
        role: widget.otherUserRole,
        avatarUrl: widget.otherUserAvatar,
      ),

      body: Column(
        children: [

          /// الرسائل
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {

                final message =
                state.messages.reversed.toList()[index];

                final isMe =
                    message.senderId == currentUser!.id;

                return MessageBubble(
                  message: message,
                  isMe: isMe,
                );
              },
            ),
          ),

          /// input
          ChatInput(
            onSend: (text) {

              ref
                  .read(chatProvider.notifier)
                  .sendMessage(
                senderId: currentUser!.id,
                receiverId: widget.otherUserId,
                text: text,
              );
            },
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/chat_provider.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/message_list.dart';
import '../widgets/chat_input_bar.dart';

class ChatScreen extends ConsumerStatefulWidget {

  final String currentUserId;
  final String otherUserId;
  final String name;
  final String role;
  final String avatarUrl;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(chatNotifierProvider.notifier)
          .loadMessages(
        widget.currentUserId,
        widget.otherUserId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: ChatAppBar(
        name: widget.name,
        role: widget.role,
        avatarUrl: widget.avatarUrl,
      ),

      body: Column(
        children: [

          Expanded(
            child: MessageList(
              currentUserId: widget.currentUserId,
            ),
          ),

          ChatInputBar(
            senderId: widget.currentUserId,
            receiverId: widget.otherUserId,
          ),

        ],
      ),
    );
  }
}