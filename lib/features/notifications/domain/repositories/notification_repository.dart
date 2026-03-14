import '../entities/notification.dart';

abstract class NotificationRepository {

  Future<List<AppNotification>> getNotifications();

  Future<int> getUnreadCount();

  Future<void> markAllAsRead();
}
