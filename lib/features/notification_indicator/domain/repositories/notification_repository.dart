import '../entities/notification_status.dart';

abstract class NotificationRepository {
  Future<NotificationStatus> getLocalStatus();

  Future<int> getLatestTaskId();
  Future<int> getLatestMessageId();

  Future<void> saveStatus(NotificationStatus status);
}