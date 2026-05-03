enum NotificationType {
  message,
  schedule,
  admin,
  // Additional types the backend may return
  task,
  attendance,
  general,
  announcement,
  // Fallback for any unknown value from the server
  unknown,
}

class AppNotification {
  final int id;
  final NotificationType type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  AppNotification copyWith({
    bool? isRead,
  }) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      body: body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}
