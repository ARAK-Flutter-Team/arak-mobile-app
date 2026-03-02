import '../repositories/notification_repository.dart';
import '../entities/notification_status.dart';

class MarkNotificationsAsSeen {
  final NotificationRepository repository;

  MarkNotificationsAsSeen(this.repository);

  /// ---------------------------
  /// Mark Tasks
  /// ---------------------------
  Future<void> markTasksSeen(int latestId) async {
    final local = await repository.getLocalStatus();

    final updated = local.copyWith(
      lastSeenTaskId: latestId,
    );

    await repository.saveStatus(updated);
  }

  /// ---------------------------
  /// Mark Messages
  /// ---------------------------
  Future<void> markMessagesSeen(int latestId) async {
    final local = await repository.getLocalStatus();

    final updated = local.copyWith(
      lastSeenMessageId: latestId,
    );

    await repository.saveStatus(updated);
  }
}