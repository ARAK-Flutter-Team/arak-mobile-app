import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/task.dart';
import 'package:arak_app/shared/theme/app_colors.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);
    final isCompleted = task.status == TaskStatus.completed;

    final Color badgeColor = switch (task.status) {
      TaskStatus.completed => const Color(0xFF4CAF50),
      TaskStatus.pending => const Color(0xFFFF9800),
      TaskStatus.notStarted => const Color(0xFF5D5D5D),
    };

    final String badgeLabel = switch (task.status) {
      TaskStatus.completed => 'Done',
      TaskStatus.pending => 'In progress',
      TaskStatus.notStarted => 'Not started',
    };

    return Card(
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.strokeColor,
          width: 0.7,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCompleted
              ? Colors.green.withOpacity(0.1)
              : theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(
            isCompleted ? Icons.check : Icons.pending_actions,
            color: isCompleted ? Colors.green : theme.colorScheme.primary,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(formattedDate, style: theme.textTheme.bodySmall),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badgeLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
