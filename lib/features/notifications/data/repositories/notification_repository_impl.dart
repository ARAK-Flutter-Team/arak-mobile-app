import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationsRepositoryImpl
    implements NotificationRepository {

  static const _key = "notifications_storage";

  /// تحميل الإشعارات
  @override
  Future<List<AppNotification>> getNotifications() async {

    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded.map((e) {

      return AppNotification(
        id: e['id'],
        title: e['title'],
        body: e['body'],
        isRead: e['isRead'],
        type: NotificationType.values[e['type']],
        createdAt: DateTime.parse(e['createdAt']),
      );

    }).toList();
  }

  /// حفظ الإشعارات
  Future<void> saveNotifications(
      List<AppNotification> notifications) async {

    final prefs = await SharedPreferences.getInstance();

    final json = notifications.map((n) {

      return {
        "id": n.id,
        "title": n.title,
        "body": n.body,
        "isRead": n.isRead,
        "type": n.type.index,
        "createdAt": n.createdAt.toIso8601String(),
      };

    }).toList();

    await prefs.setString(_key, jsonEncode(json));
  }

  /// عدد غير المقروء
  @override
  Future<int> getUnreadCount() async {

    final notifications = await getNotifications();

    return notifications.where((n) => !n.isRead).length;
  }

  /// قراءة الكل
  @override
  Future<void> markAllAsRead() async {

    final notifications = await getNotifications();

    final updated = notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();

    await saveNotifications(updated);
  }
}
