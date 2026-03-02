class NotificationRemoteModel {
  final int latestTaskId;
  final int latestMessageId;

  NotificationRemoteModel({
    required this.latestTaskId,
    required this.latestMessageId,
  });

  factory NotificationRemoteModel.fromJson(Map<String, dynamic> json) {
    return NotificationRemoteModel(
      latestTaskId: json['latestTaskId'] ?? 0,
      latestMessageId: json['latestMessageId'] ?? 0,
    );
  }
}