import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/task.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formattedDate =
    DateFormat('dd MMM yyyy').format(task.dueDate);

    final formattedTime =
    DateFormat('hh:mm a').format(task.dueDate);

    final isCompleted =
        task.status == TaskStatus.completed;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCompleted
              ? Colors.green.withOpacity(0.1)
              : theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(
            isCompleted
                ? Icons.check
                : Icons.pending_actions,
            color: isCompleted
                ? Colors.green
                : theme.colorScheme.primary,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            /// Subject
            Text(
              task.subject,
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 4),

            /// Description
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            /// Time
            Text(
              formattedTime,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Text(
          formattedDate,
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}