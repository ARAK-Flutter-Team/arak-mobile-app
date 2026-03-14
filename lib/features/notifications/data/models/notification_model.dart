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
      id: json["id"],
      type: NotificationType.values.firstWhere(
            (e) => e.name == json["type"],
      ),
      title: json["title"],
      body: json["body"],
      isRead: json["isRead"],
      createdAt: DateTime.parse(json["createdAt"]),
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
