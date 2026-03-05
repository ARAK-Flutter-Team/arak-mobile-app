import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class MessageBubble extends StatelessWidget {

  final Message message;
  final bool isMe;
  final VoidCallback? onDeleteForMe;
  final VoidCallback? onDeleteForEveryone;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onDeleteForMe,
    this.onDeleteForEveryone,
  });

  void _showDeleteOptions(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (_) {

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                title: const Text("Delete for me"),
                onTap: () {
                  Navigator.pop(context);
                  onDeleteForMe?.call();
                },
              ),

              if (isMe)
                ListTile(
                  title: const Text("Delete for everyone"),
                  onTap: () {
                    Navigator.pop(context);
                    onDeleteForEveryone?.call();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final bubbleColor = isMe
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceVariant;

    final textColor = isMe
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    return Align(
      alignment:
      isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: GestureDetector(
        onLongPress: () => _showDeleteOptions(context),

        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),

          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}