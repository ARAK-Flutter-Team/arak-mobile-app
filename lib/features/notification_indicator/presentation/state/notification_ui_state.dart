// ✅ Simplified: single hasUnread field driven by the real API unread count.
// hasNewTasks / hasNewMessages split is no longer needed since the badge
// is now driven by GET /api/notifications/unread-count.
class NotificationUIState {
  final bool hasUnread;

  const NotificationUIState({required this.hasUnread});

  // Convenience getters kept for backward compatibility with QuickActionsGrid
  // which still checks hasNewTasks / hasNewMessages.
  bool get hasNewTasks => hasUnread;
  bool get hasNewMessages => hasUnread;
}