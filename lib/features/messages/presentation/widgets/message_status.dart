import 'package:flutter/material.dart';

class MessageStatusWidget extends StatelessWidget {
  final bool isRead;
  final bool isSending;
  final bool hasError;

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
