/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/notification.dart';
import '../../../../shared/providers/current_user_provider.dart';

class NotificationTile extends ConsumerWidget {

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
      case NotificationType.task:
        return Icons.task_alt;
      case NotificationType.attendance:
        return Icons.how_to_reg;
      case NotificationType.announcement:
        return Icons.announcement;
      case NotificationType.general:
      case NotificationType.unknown:
      default:
        return Icons.notifications;
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
      case NotificationType.task:
        return Colors.teal;
      case NotificationType.attendance:
        return Colors.green;
      case NotificationType.announcement:
        return Colors.deepOrange;
      case NotificationType.general:
      case NotificationType.unknown:
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime date) {

    final hour = date.hour.toString().padLeft(2,'0');
    final minute = date.minute.toString().padLeft(2,'0');

    return "$hour:$minute";
  }

  /// Navigate based on notification type
  void _handleTap(BuildContext context, WidgetRef ref) {
    switch (notification.type) {
      case NotificationType.message:
        final userId = ref.read(currentUserProvider)?.id.toString() ?? '';
        context.push('/chat-users', extra: {
          'currentUserId': userId,
          'users': [],
        });
        break;
      case NotificationType.schedule:
        context.push('/parent-home/schedule');
        break;
      case NotificationType.task:
        context.push('/parent-home/tasks');
        break;
      case NotificationType.attendance:
        context.push('/parent-home/attendance');
        break;
      case NotificationType.admin:
      case NotificationType.general:
      case NotificationType.announcement:
      case NotificationType.unknown:
        break; // info-only, no navigation
    }
  }

  bool get _isTappable =>
      notification.type == NotificationType.message ||
      notification.type == NotificationType.schedule ||
      notification.type == NotificationType.task ||
      notification.type == NotificationType.attendance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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

        onTap: _isTappable ? () => _handleTap(context, ref) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notification.dart';
import '../../../../shared/providers/current_user_provider.dart';

class NotificationTile extends ConsumerWidget {
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

      case NotificationType.task:
        return Icons.task_alt;

      case NotificationType.attendance:
        return Icons.how_to_reg;

      case NotificationType.announcement:
        return Icons.announcement;

      case NotificationType.general:
      case NotificationType.unknown:
      default:
        return Icons.notifications;
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

      case NotificationType.task:
        return Colors.teal;

      case NotificationType.attendance:
        return Colors.green;

      case NotificationType.announcement:
        return Colors.deepOrange;

      case NotificationType.general:
      case NotificationType.unknown:
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }

  /// Navigation
  void _handleTap(BuildContext context, WidgetRef ref) {
    switch (notification.type) {
    /// MESSAGE
      case NotificationType.message:
        final userId =
            ref.read(currentUserProvider)?.id.toString() ?? '';

        context.push(
          '/conversations',
          extra: userId,
        );
        break;

    /// SCHEDULE
      case NotificationType.schedule:
        context.push('/parent-home/schedule');
        break;

    /// TASKS
      case NotificationType.task:
        context.push('/parent-home/tasks');
        break;

    /// ATTENDANCE
      case NotificationType.attendance:
        context.push('/parent-home/attendance');
        break;

    /// OTHER TYPES
      case NotificationType.admin:
      case NotificationType.general:
      case NotificationType.announcement:
      case NotificationType.unknown:
        break;
    }
  }

  bool get _isTappable =>
      notification.type == NotificationType.message ||
          notification.type == NotificationType.schedule ||
          notification.type == NotificationType.task ||
          notification.type == NotificationType.attendance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        onTap: _isTappable
            ? () => _handleTap(context, ref)
            : null,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        /// ICON
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),

          child: Icon(
            _iconForType(notification.type),
            color: color,
          ),
        ),

        /// TITLE
        title: Text(
          notification.title,

          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        /// BODY
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),

          child: Text(notification.body),
        ),

        /// TIME + UNREAD DOT
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
                margin: const EdgeInsets.only(top: 6),

                width: 8,
                height: 8,

                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),

        /// UNREAD BACKGROUND
        tileColor: notification.isRead
            ? null
            : color.withOpacity(.08),
      ),
    );
  }
}