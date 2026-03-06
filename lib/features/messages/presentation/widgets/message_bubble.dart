import 'package:flutter/material.dart';

import '../../domain/entities/message.dart';
import '../../domain/enums/message_type.dart';

import 'text_message_bubble.dart';
import 'image_message_bubble.dart';
import 'file_message_bubble.dart';
import 'voice_message_bubble.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  final VoidCallback onDeleteForMe;
  final VoidCallback onDeleteForEveryone;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.onDeleteForMe,
    required this.onDeleteForEveryone,
  });

  void _showDeleteOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text("Delete for me"),
                onTap: () {
                  Navigator.pop(context);
                  onDeleteForMe();
                },
              ),
              if (isMe)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Delete for everyone"),
                  onTap: () {
                    Navigator.pop(context);
                    onDeleteForEveryone();
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
    Widget child;

    switch (message.type) {
      case MessageType.text:
        child = TextMessageBubble(
          message: message,
          isMe: isMe,
        );
        break;

      case MessageType.image:
        child = ImageMessageBubble(
          message: message,
          isMe: isMe,
        );
        break;

      case MessageType.file:
        child = FileMessageBubble(
          message: message,
          isMe: isMe,
        );
        break;

      case MessageType.voice:
        child = VoiceMessageBubble(
          message: message,
          isMe: isMe,
        );
        break;

      default:
        child = const SizedBox();
    }

    return Align(
      alignment:
      isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showDeleteOptions(context),
        child: child,
      ),
    );
  }
}