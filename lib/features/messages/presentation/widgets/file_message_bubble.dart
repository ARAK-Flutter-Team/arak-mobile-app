import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class FileMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const FileMessageBubble({
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.insert_drive_file, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              "File",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}