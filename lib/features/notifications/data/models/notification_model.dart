import '../../domain/entities/notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.isRead,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: (json["id"] as num?)?.toInt() ?? 0,
      type: NotificationType.values.firstWhere(
        (e) => e.name == (json["type"] as String?),
        orElse: () => NotificationType.unknown,
      ),
      title: json["title"] as String? ?? '',
      body: json["body"] as String? ?? '',
      isRead: json["isRead"] as bool? ?? false,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type.name,
      "title": title,
      "body": body,
      "isRead": isRead,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
