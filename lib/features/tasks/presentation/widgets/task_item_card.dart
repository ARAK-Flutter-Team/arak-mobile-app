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
}*/
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

    /// حماية من null date من الباك
    final formattedDate = task.dueDate != null
        ? DateFormat('dd MMM yyyy').format(task.dueDate)
        : "-";

    final subject = task.subject.toLowerCase();

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

    final iconPath = subjectIcons[subject];
    final color = subjectColors[subject] ?? Colors.grey;

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

            /// HEADER
            Row(
              children: [

                /// ICON (safe)
                if (iconPath != null)
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(iconPath),
                  ),

                const SizedBox(width: 12),

                /// TITLE (from backend only)
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: task.isDeleted ? TextDecoration.lineThrough : null,
                      color: task.isDeleted ? Colors.grey : null,
                    ),
                  ),
                ),

                /// DELETE
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {

                    if (task.id.isEmpty) {
                      AppSnackBar.show(
                        context,
                        message: "Invalid task id",
                        type: AppSnackBarType.error,
                      );
                      return;
                    }

                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.confirmDelete),
                        content: Text(AppLocalizations.of(context)!.deleteTaskMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(AppLocalizations.of(context)!.delete),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref
                          .read(teacherTasksNotifierProvider.notifier)
                          .deleteTask(task.id);

                      AppSnackBar.show(
                        context,
                        message: AppLocalizations.of(context)!.taskDeleted,
                        type: AppSnackBarType.error,
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// SUBJECT + DATE (backend only)
            Text(
              "${getSubjectLabel(context, task.subject)} • $formattedDate",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 14),

            /// STATUS BUTTON
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.08),
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
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// DELETED FLAG (from backend only)
            if (task.isDeleted == true) ...[
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
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../task_status/presentation/screens/task_status_screen.dart';
import '../../domain/entities/task.dart';
import '../providers/teacher_tasks_notifier.dart'; // ✅ مهم جداً عشان زر الحذف يشتغل

class TaskItemCard extends ConsumerWidget {
  final Task task;

  const TaskItemCard({
    super.key,
    required this.task,
  });

  String getSubjectLabel(BuildContext context, String subject) {
    // ملاحظة: لو الباك بيرجع أسماء مختلفة (زي "Mathematics" بدل "math")، لازم تعدلي القيم هنا
    switch (subject.toLowerCase()) {
      case "math":
        return AppLocalizations.of(context)!.math;
      case "science":
        return AppLocalizations.of(context)!.science;
      case "english":
        return AppLocalizations.of(context)!.english;
      default:
        return subject; // نرجع الاسم زي ما جاي من الباك لو مش موجود في الكيس
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    /// تنسيق التاريخ (مع الحماية لو الباك بعت null)
    final formattedDate = task.dueDate != null
        ? DateFormat('dd MMM yyyy').format(task.dueDate!)
        : "-";

    //final subject = task.subject.toLowerCase();

    // تعريف الألوان والأيقونات (ده UI Logic، مش Mock Data)
    // لازم أسماء المواد اللي جايه من الباك تطابق المفاتيح دي عشان الأيقونات تظهر
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

    //final iconPath = subjectIcons[subject];
    //final color = subjectColors[subject] ?? Colors.grey;

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
            /// HEADER
            Row(
              children: [
                /// ICON
                /*if (iconPath != null)
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(iconPath, errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.book, color: color); // Fallback Icon لو الصورة مش موجودة
                    }),
                  ),*/

                const SizedBox(width: 12),

                /// TITLE
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: task.isDeleted ? TextDecoration.lineThrough : null,
                      color: task.isDeleted ? Colors.grey : null,
                    ),
                  ),
                ),

                /// DELETE BUTTON (Connection to Backend)
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    // التأكد من وجود ID
                    if (task.id.isEmpty) {
                      AppSnackBar.show(
                        context,
                        message: "Invalid task id",
                        type: AppSnackBarType.error,
                      );
                      return;
                    }

                    // تأكيد الحذف
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.confirmDelete),
                        content: Text(AppLocalizations.of(context)!.deleteTaskMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(AppLocalizations.of(context)!.delete),
                          ),
                        ],
                      ),
                    );

                    // تنفيذ الحذف من الباك
                    if (confirm == true) {
                      await ref
                          .read(teacherTasksNotifierProvider.notifier)
                          .deleteTask(task.id);

                      AppSnackBar.show(
                        context,
                        message: AppLocalizations.of(context)!.taskDeleted,
                        type: AppSnackBarType.error,
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// SUBJECT + DATE
            Text(
              "${getSubjectLabel(context, /*task.subject*/)} • $formattedDate",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 14),

            /// STATUS BUTTON
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.08),
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
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// DELETED FLAG
            if (task.isDeleted == true) ...[
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    /// 📅 Format Date
    final formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);

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

            /// 🔹 HEADER
            Row(
              children: [
                /// ICON (ثابت بدل subject)
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.assignment, color: Colors.blue),
                ),

                const SizedBox(width: 12),

                /// TITLE
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration:
                      task.isDeleted ? TextDecoration.lineThrough : null,
                      color: task.isDeleted ? Colors.grey : null,
                    ),
                  ),
                ),

                /// 🗑️ DELETE BUTTON
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    if (task.id.isEmpty) {
                      AppSnackBar.show(
                        context,
                        message: "Invalid task id",
                        type: AppSnackBarType.error,
                      );
                      return;
                    }

                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.confirmDelete),
                        content: Text(AppLocalizations.of(context)!.deleteTaskMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(AppLocalizations.of(context)!.delete),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref
                          .read(teacherTasksNotifierProvider.notifier)
                          .deleteTask(task.id);

                      AppSnackBar.show(
                        context,
                        message: AppLocalizations.of(context)!.taskDeleted,
                        type: AppSnackBarType.error,
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 📅 DATE ONLY (بدل subject + date)
            Text(
              formattedDate,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 14),

            /// 👁️ STATUS BUTTON
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.08),
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
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// ❌ DELETED FLAG
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