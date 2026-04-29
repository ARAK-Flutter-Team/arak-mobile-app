import 'package:flutter/material.dart';
import 'task_status_badge.dart';

class TaskStatusListItem extends StatelessWidget {
  final String studentId;
  final String studentName;
  final bool isDone;
  final VoidCallback onTap;

  const TaskStatusListItem({
    super.key,
    required this.studentId,
    required this.studentName,
    required this.isDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      title: Text(
        studentName,
        style: theme.textTheme.bodyLarge,
      ),
      trailing: TaskStatusBadge(
        isDone: isDone,
      ),
    );
  }
}