// lib/features/conversations/presentation/widgets/chat_input_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/message.dart';
import '../../providers/conversation_providers.dart';

class ChatInputBar extends ConsumerStatefulWidget {
  final String senderId;
  final String receiverId;
  final Function(Message?) onMessageSent;

  const ChatInputBar({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.onMessageSent,
  });

  @override
  ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty || _isSending) return;

    final text = _controller.text.trim();
    _controller.clear();
    _hasText = false;

    setState(() => _isSending = true);

    try {
      final sentMessage = await ref.read(chatControllerProvider.notifier).sendTextMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        text: text,
      );

      if (sentMessage != null) {
        widget.onMessageSent(sentMessage);
      }
    } catch (e) {
      if (mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${loc.error}: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _focusNode.requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: loc.typeMessageHint,
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isSending ? null : _sendMessage,
              borderRadius: BorderRadius.circular(60.r),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: _hasText && !_isSending
                      ? theme.colorScheme.primary
                      : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isSending ? Icons.hourglass_empty : Icons.send,
                  size: 20.w,
                  color: _hasText && !_isSending
                      ? Colors.white
                      : (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
