import '../models/notification_model.dart';
import '../../domain/entities/notification.dart';
import 'notification_remote_datasource.dart';

class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {

  final List<NotificationModel> _mockNotifications = [

    NotificationModel(
      id: 1,
      type: NotificationType.message,
      title: "New Message",
      body: "You received a message from Ahmed's parent",
      isRead: false,
      createdAt: DateTime.now(),
    ),

    NotificationModel(
      id: 2,
      type: NotificationType.schedule,
      title: "Schedule Updated",
      body: "Your Math class moved to Room 3B",
      isRead: false,
      createdAt: DateTime.now(),
    ),

    NotificationModel(
      id: 3,
      type: NotificationType.admin,
      title: "Staff Meeting",
      body: "Staff meeting tomorrow at 10 AM",
      isRead: true,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockNotifications;
  }

  @override
  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockNotifications.where((n) => !n.isRead).length;
  }

  @override
  Future<void> markAllAsRead() async {

    for (int i = 0; i < _mockNotifications.length; i++) {

      final n = _mockNotifications[i];

      _mockNotifications[i] = NotificationModel(
        id: n.id,
        type: n.type,
        title: n.title,
        body: n.body,
        isRead: true,
        createdAt: n.createdAt,
      );
    }
  }
}
