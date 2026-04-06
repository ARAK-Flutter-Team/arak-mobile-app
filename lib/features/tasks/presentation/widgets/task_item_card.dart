/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task.dart';
import 'package:arak_app/shared/theme/app_colors.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  /// 🔥 ترجمة اسم المادة
  String getSubjectLabel(BuildContext context, String subject) {
    switch (subject.toLowerCase()) {
      case "math":
        return AppLocalizations.of(context)!.math;
      case "science":
        return AppLocalizations.of(context)!.science;
      case "english":
        return AppLocalizations.of(context)!.english;
      default:
        return subject;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);

    /// 👇 مهم جدًا (حل المشكلة)
    final subject = task.subject.toLowerCase();

    /// Mock submission numbers
    final submittedStudents = 12;
    final totalStudents = 30;

    /// ألوان لكل مادة
    final subjectColors = {
      "math": Colors.blue,
      "science": Colors.green,
      "english": Colors.orange,
    };

    /// أيقونات لكل مادة
    final subjectIcons = {
      "math": 'assets/icons/calculator_14116967.png',
      "science": 'assets/icons/microscope.png',
      "english": 'assets/icons/alphabet (1).png',
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
                /// 🔥 الأيقونة (هتظهر دلوقتي صح)
                if (subjectIcons[subject] != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (subjectColors[subject] ?? Colors.grey)
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      subjectIcons[subject]!,
                      width: 24,
                      height: 24,
                      color: subjectColors[subject],
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

            /// 🔥 اسم المادة (مترجم)
            Text(
              getSubjectLabel(context, task.subject),
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
                  "$submittedStudents / $totalStudents ${AppLocalizations.of(context)!.studentsSubmitted}",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// زر
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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../domain/entities/task.dart';
import '../providers/teacher_tasks_notifier.dart';

class TaskItemCard extends ConsumerWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  /// ترجمة المادة
  String getSubjectLabel(BuildContext context, String subject) {
    switch (subject.toLowerCase()) {
      case "math":
        return AppLocalizations.of(context)!.math;
      case "science":
        return AppLocalizations.of(context)!.science;
      case "english":
        return AppLocalizations.of(context)!.english;
      default:
        return subject;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);

    final subject = task.subject.toLowerCase();

    final submittedStudents = 12;
    final totalStudents = 30;

    final subjectColors = {
      "math": Colors.blue,
      "science": Colors.green,
      "english": Colors.orange,
    };

    final subjectIcons = {
      "math": 'assets/icons/calculator_14116967.png',
      "science": 'assets/icons/microscope.png',
      "english": 'assets/icons/alphabet (1).png',
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
            /// 🔥 Title + Icon + Delete
            Row(
              children: [
                if (subjectIcons[subject] != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (subjectColors[subject] ?? Colors.grey)
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      subjectIcons[subject]!,
                      width: 24,
                      height: 24,
                      color: subjectColors[subject],
                    ),
                  ),

                const SizedBox(width: 12),

                /// Title
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: task.isDeleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isDeleted
                          ? Colors.grey
                          : theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),

                /// 🔥 Delete Button
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ref
                        .read(teacherTasksNotifierProvider.notifier)
                        .deleteTask(task.id);

                    AppSnackBar.show(
                      context,
                      message: AppLocalizations.of(context)!.taskDeleted,
                      type: AppSnackBarType.error, // 👈 عشان delete
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Subject
            Text(
              getSubjectLabel(context, task.subject),
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 6),

            /// Due Date
            Text(
              "Due: $formattedDate",
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 12),

            /// 🔥 لو التاسك اتحذف
            if (task.isDeleted)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      AppLocalizations.of(context)!.taskDeleted,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),

            /// Submissions
            Row(
              children: [
                Icon(
                  Icons.upload_file,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  "$submittedStudents / $totalStudents ${AppLocalizations.of(context)!.studentsSubmitted}",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// View Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("View Submissions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}