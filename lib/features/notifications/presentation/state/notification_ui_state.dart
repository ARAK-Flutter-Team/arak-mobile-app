class NotificationUIState {
  final bool hasNewTasks;
  final bool hasNewMessages;
  final bool showNewTasksLabel;

  const NotificationUIState({
    required this.hasNewTasks,
    required this.hasNewMessages,
    required this.showNewTasksLabel,
  });
}