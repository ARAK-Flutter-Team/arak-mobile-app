import 'package:flutter/material.dart';
import '../../domain/enums/message_status.dart'; // استدعاء enum من الدومين

class MessageStatusWidget extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        icon = Icons.schedule;
        color = Colors.grey;
        break;
      case MessageStatus.sent:
        icon = Icons.check;
        color = Colors.grey;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.grey;
        break;
      case MessageStatus.seen:
        icon = Icons.done_all;
        color = Colors.blue;
        break;
    }

    return Icon(
      icon,
      size: 16,
      color: color,
    );
  }
}