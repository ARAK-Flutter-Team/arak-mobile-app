/*import 'package:flutter/material.dart';
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
*/
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

    /// Mock submission numbers
    final submittedStudents = 12;
    final totalStudents = 30;

    /// ألوان لكل مادة
    final subjectColors = {
      "Math": Colors.blue,
      "Science": Colors.green,
      "English": Colors.orange,
    };

    /// أيقونات PNG لكل مادة
    final subjectIcons = {
      "Math": 'assets/icons/tools.png',
      "Science": 'assets/icons/chemistry.png',
      "English": 'assets/icons/english.png',
    };

    return Card(
      elevation: 2,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.strokeColor,
          width: 0.7,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Subject Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// أيقونة المادة داخل كونتينر دائري
                if (subjectIcons[task.subject] != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (subjectColors[task.subject] ?? Colors.grey)
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      subjectIcons[task.subject]!,
                      width: 24,
                      height: 24,
                      color: subjectColors[task.subject],
                    ),
                  ),
                const SizedBox(width: 12),

                /// عنوان المهمة
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// اسم المادة
            Text(
              task.subject,
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 6),

            /// موعد التسليم
            Text(
              "Due: $formattedDate",
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 14),

            /// عدد التسليمات
            Row(
              children: [
                Icon(
                  Icons.upload_file,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  "$submittedStudents / $totalStudents Students Submitted",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// زر "View Submissions"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                child: const Text("View Submissions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}