/*import 'package:flutter/material.dart';
import '../../domain/enums/message_status.dart';

class MessageStatusWidget extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusWidget({
    super.key,
    required this.status,
  });

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

      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = Colors.red;
        break;

      case MessageStatus.deleted:
        icon = Icons.block;
        color = Colors.grey;
        break;
    }

    return Icon(
      icon,
      size: 16,
      color: color,
    );
  }
}*/
// lib/features/conversations/presentation/widgets/message_status.dart
import 'package:flutter/material.dart';

class MessageStatusWidget extends StatelessWidget {
  final bool isRead;
  final bool isSending; // اختياري
  final bool hasError;  // اختياري

  const MessageStatusWidget({
    super.key,
    required this.isRead,
    this.isSending = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    // لو فيه خطأ
    if (hasError) {
      return const Icon(
        Icons.error_outline,
        size: 14,
        color: Colors.red,
      );
    }

    // لو لسه بيتبعت
    if (isSending) {
      return const Icon(
        Icons.schedule,
        size: 14,
        color: Colors.grey,
      );
    }

    // لو اتقرأ
    if (isRead) {
      return const Icon(
        Icons.done_all,
        size: 14,
        color: Color(0xFF34B7F1), // أزرق فاتح زي الواتساب
      );
    }

    // لو اتوصّل بس مقرأش
    return const Icon(
      Icons.check,
      size: 14,
      color: Colors.grey,
    );
  }
}
