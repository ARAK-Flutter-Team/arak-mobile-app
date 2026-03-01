import '../../domain/entities/notification_status.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource local;
  final NotificationRemoteDataSource remote;

  NotificationRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<NotificationStatus> getLocalStatus() async {
    final taskId = await local.getLastSeenTaskId();
    final messageId = await local.getLastSeenMessageId();

    return NotificationStatus(
      lastSeenTaskId: taskId,
      lastSeenMessageId: messageId,
    );
  }

  @override
  Future<int> getLatestTaskId() {
    return remote.getLatestTaskId();
  }

  @override
  Future<int> getLatestMessageId() {
    return remote.getLatestMessageId();
  }

  @override
  Future<void> saveStatus(NotificationStatus status) async {
    await local.saveLastSeenTaskId(status.lastSeenTaskId);
    await local.saveLastSeenMessageId(status.lastSeenMessageId);
  }
}