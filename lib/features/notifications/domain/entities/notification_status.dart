class NotificationStatus {
  final int lastSeenTaskId;
  final int lastSeenMessageId;

  const NotificationStatus({
    required this.lastSeenTaskId,
    required this.lastSeenMessageId,
  });

  NotificationStatus copyWith({
    int? lastSeenTaskId,
    int? lastSeenMessageId,
  }) {
    return NotificationStatus(
      lastSeenTaskId: lastSeenTaskId ?? this.lastSeenTaskId,
      lastSeenMessageId: lastSeenMessageId ?? this.lastSeenMessageId,
    );
  }
}