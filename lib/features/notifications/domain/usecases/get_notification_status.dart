import '../repositories/notification_repository.dart';

class GetNotificationStatus {
  final NotificationRepository repository;

  GetNotificationStatus(this.repository);

  Future<bool> hasNewTasks() async {
    try {
      final local = await repository.getLocalStatus();
      final remoteLatest = await repository.getLatestTaskId();

      return remoteLatest > local.lastSeenTaskId;
    } catch (_) {
      return false; // لو API وقع
    }
  }

  Future<bool> hasNewMessages() async {
    try {
      final local = await repository.getLocalStatus();
      final remoteLatest = await repository.getLatestMessageId();

      return remoteLatest > local.lastSeenMessageId;
    } catch (_) {
      return false;
    }
  }
}