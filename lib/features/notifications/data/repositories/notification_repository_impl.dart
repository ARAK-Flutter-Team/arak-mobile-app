import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../datasources/notification_remote_datasource_impl.dart';

class NotificationsRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource =
      NotificationRemoteDataSourceImpl();

  @override
  Future<List<AppNotification>> getNotifications() async {
    return await _remoteDataSource.getNotifications();
  }

  @override
  Future<int> getUnreadCount() async {
    return await _remoteDataSource.getUnreadCount();
  }

  @override
  Future<void> markAllAsRead() async {
    await _remoteDataSource.markAllAsRead();
  }

  Future<void> markAsRead(int id) async {
    await _remoteDataSource.markAsRead(id);
  }
}
