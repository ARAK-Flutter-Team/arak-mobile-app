import 'package:flutter/material.dart';
import '../../domain/entities/notification.dart';

class NotificationTile extends StatelessWidget {

  final AppNotification notification;

  const NotificationTile({
    super.key,
    required this.notification,
  });

  IconData _iconForType(NotificationType type) {

    switch (type) {

      case NotificationType.message:
        return Icons.message;

      case NotificationType.schedule:
        return Icons.schedule;

      case NotificationType.admin:
        return Icons.campaign;
    }
  }

  Color _colorForType(NotificationType type) {

    switch (type) {

      case NotificationType.message:
        return Colors.blue;

      case NotificationType.schedule:
        return Colors.orange;

      case NotificationType.admin:
        return Colors.purple;
    }
  }

  String _formatTime(DateTime date) {

    final hour = date.hour.toString().padLeft(2,'0');
    final minute = date.minute.toString().padLeft(2,'0');

    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {

    final color = _colorForType(notification.type);

    return Container(

      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0,3),
          )
        ],
      ),

      child: ListTile(

        /// icon

        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(
            _iconForType(notification.type),
            color: color,
          ),
        ),

        /// title

        title: Text(
          notification.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        /// body

        subtitle: Padding(
          padding: const EdgeInsets.only(top:4),
          child: Text(notification.body),
        ),

        /// time + unread dot

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              _formatTime(notification.createdAt),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),

            if (!notification.isRead)
              Container(
                margin: const EdgeInsets.only(top:6),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),

        /// unread background

        tileColor: notification.isRead
            ? null
            : color.withOpacity(.08),
      ),
    );
  }
}
