/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/message_list.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indicator.dart';

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
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(chatControllerProvider.notifier).loadMessages(
        widget.currentUserId,
        widget.otherUserId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);

    /// Scroll بعد كل تحديث
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              otherUserId: widget.otherUserId, // لازم يكون عندك ال id للشخص التاني
              scrollController: _scrollController,
            ),
          ),
          if (state.isTyping)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TypingIndicator(),
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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../notification_indicator/presentation/providers/notification_indicator_notifier.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/message_list.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indicator.dart';

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
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {

      /// تحميل الرسائل
      await ref.read(chatControllerProvider.notifier).loadMessages(
        widget.currentUserId,
        widget.otherUserId,
      );

      /// إزالة NEW
      await ref
          .read(notificationProvider.notifier)
          .markMessagesAsSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              otherUserId: widget.otherUserId,
              scrollController: _scrollController,
            ),
          ),

          if (state.isTyping)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TypingIndicator(),
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