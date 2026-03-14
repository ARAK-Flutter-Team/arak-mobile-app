/*import 'dart:io';
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
}*/
import 'dart:io';
import 'package:flutter/material.dart';

import '../../domain/entities/message.dart';
import '../widgets/message_time.dart';
import 'message_status.dart';

class ImageMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ImageMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  Widget _buildImage() {

    if (message.fileUrl == null) {
      return const SizedBox();
    }

    /// صورة من الموبايل
    if (message.fileUrl!.startsWith('/')) {
      return Image.file(
        File(message.fileUrl!),
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }

    /// صورة من السيرفر
    if (message.fileUrl!.startsWith('http')) {
      return Image.network(
        message.fileUrl!,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }

    return const SizedBox();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildImage(),
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                MessageTime(
                  time: message.createdAt,
                  isMe: isMe,
                ),

                const SizedBox(width: 4),

                if (isMe)
                  MessageStatusWidget(
                    status: message.status,
                  ),

              ],
            )

          ],
        ),
      ),
    );
  }
}