import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class ImageMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ImageMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: message.fileUrl != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(message.fileUrl!),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        )
            : const SizedBox(),
      ),
    );
  }
}