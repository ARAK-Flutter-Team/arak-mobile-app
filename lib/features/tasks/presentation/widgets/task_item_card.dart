/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../task_status/presentation/screens/task_status_screen.dart';
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
            ///  Title + Icon + Delete
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

                ///  Delete Button
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ref
                        .read(teacherTasksNotifierProvider.notifier)
                        .deleteTask(task.id);

                    AppSnackBar.show(
                      context,
                      message: AppLocalizations.of(context)!.taskDeleted,
                      type: AppSnackBarType.error, //  delete
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
            /// viewStudents
Center(
  child:             Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary.withOpacity(0.08),
      border: Border.all(
        color: theme.colorScheme.primary.withOpacity(0),
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskStatusScreen(task: task),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            AppLocalizations.of(context)!.checkStatus,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  ),
),
            ///  لو التاسك اتحذف
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
            /*Row(
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
            ),*/
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
import '../../../task_status/presentation/screens/task_status_screen.dart';
import '../../domain/entities/task.dart';
import '../providers/teacher_tasks_notifier.dart';

class TaskItemCard extends ConsumerWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

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

    /// Mock (هتتربط بعدين)
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
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: AppColors.strokeColor.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///  Header
            Row(
              children: [
                if (subjectIcons[subject] != null)
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: (subjectColors[subject] ?? Colors.grey)
                          .withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(
                      subjectIcons[subject]!,
                      color: subjectColors[subject],
                    ),
                  ),

                const SizedBox(width: 12),

                /// Title
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
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

                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    final theme = Theme.of(context);
                    final colorScheme = theme.colorScheme;
                    final loc = AppLocalizations.of(context)!;

                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: theme.dialogBackgroundColor,

                        title: Text(
                          loc.confirmDelete,
                          style: TextStyle(color: theme.colorScheme.onBackground),
                        ),

                        content: Text(
                          loc.deleteTaskMessage,
                          style: TextStyle(color: theme.colorScheme.onBackground),
                        ),

                        actions: [
                          ///  Cancel
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              loc.cancel,
                              style: TextStyle(color: colorScheme.primary),
                            ),
                          ),

                          ///  Delete
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              loc.delete,
                              style: TextStyle(color: colorScheme.error),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      ref
                          .read(teacherTasksNotifierProvider.notifier)
                          .deleteTask(task.id);

                      AppSnackBar.show(
                        context,
                        message: loc.taskDeleted,
                        type: AppSnackBarType.error,
                      );
                    }
                  },
                )
              ],
            ),

            const SizedBox(height: 10),

            ///  Subject + Date
            Text(
              "${getSubjectLabel(context, task.subject)} • $formattedDate",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 14),

            ///  Action Button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskStatusScreen(task: task),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary
                        .withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        AppLocalizations.of(context)!.checkStatus,
                        style:
                        theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///  Deleted Banner
            if (task.isDeleted) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
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
            ],
          ],
        ),
      ),
    );
  }
}