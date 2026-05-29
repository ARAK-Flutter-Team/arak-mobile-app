import 'dart:async'; // ✅ [تعديل] استيراد dart:async عشان نستخدم Timer للـ polling
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../providers/conversation_providers.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isFirstLoad = true;

  // ✅ [تعديل] متغير الـ Timer اللي هيعمل polling تلقائي للرسائل
  Timer? _pollingTimer;

  void _scrollToBottom({bool animate = true}) {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        if (animate) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(0);
        }
        debugPrint(' Scrolled to bottom');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint(' [CHAT SCREEN] Initializing');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMessages();
    });

    // ✅ [تعديل] بدء الـ Polling — بيجيب الرسائل الجديدة كل 5 ثوانياً تلقائياً
    // ده بيحل مشكلة إن الطرف التاني مش بيشوف الرسالة غير لما يعمل refresh يدوي
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        ref.read(chatControllerProvider.notifier).loadMessages(
              currentUserId: widget.currentUserId,
              otherUserId: widget.otherUserId,
              showLoading:
                  false, // ✅ [تعديل] false عشان متبانيش loading spinner مع كل poll
            );
      }
    });
  }

  Future<void> _loadMessages() async {
    debugPrint(' Loading messages...');
    setState(() => _isLoading = true);

    await ref.read(chatControllerProvider.notifier).loadMessages(
          currentUserId: widget.currentUserId,
          otherUserId: widget.otherUserId,
        );

    if (mounted) {
      setState(() => _isLoading = false);
      _isFirstLoad = true;
      _scrollToBottom();
      debugPrint(' Messages loaded');
    }
  }

  @override
  void dispose() {
    debugPrint(' [CHAT SCREEN] Disposing');

    // ✅ [تعديل] إلغاء الـ Timer لما الشاشة تتقفل عشان منعملش memory leak
    _pollingTimer?.cancel();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    final chatId = _chatId(widget.currentUserId, widget.otherUserId);
    final messages = state.messagesMap[chatId] ?? [];

    // التمرير التلقائي عند إضافة رسالة جديدة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isFirstLoad && mounted && _scrollController.hasClients) {
        _scrollToBottom();
      }
      _isFirstLoad = false;
    });

    return Scaffold(
      appBar: AppMainAppBar(
        title: widget.name,
        showBackButton: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .read(chatControllerProvider.notifier)
                          .refreshMessages(
                            currentUserId: widget.currentUserId,
                            otherUserId: widget.otherUserId,
                          );
                      _scrollToBottom();
                    },
                    child: MessageList(
                      currentUserId: widget.currentUserId,
                      otherUserId: widget.otherUserId,
                      scrollController: _scrollController,
                    ),
                  ),
                ),
                ChatInputBar(
                  senderId: widget.currentUserId,
                  receiverId: widget.otherUserId,
                  onMessageSent: (message) {
                    debugPrint(' Message sent, scrolling to bottom');
                    _scrollToBottom();
                  },
                ),
              ],
            ),
    );
  }

  String _chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }
}
