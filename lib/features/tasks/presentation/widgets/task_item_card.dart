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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    String formattedDate = 'No date';
    if (task.dueDate != null) {
      try {
        formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);
      } catch (e) {
        formattedDate = 'Invalid date';
      }
    }

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
            Row(
              children: [
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
                Expanded(
                  child: Text(
                    task.title ??
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)?.confirmDelete ?? 'Delete Task'),
                        content: Text(AppLocalizations.of(context)?.deleteTaskMessage ?? 'This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(AppLocalizations.of(context)?.delete ?? 'Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref
                          .read(teacherTasksNotifierProvider.notifier)
                          .deleteTask(task.id ?? '');

                      AppSnackBar.show(
                        context,
                        message: AppLocalizations.of(context)?.taskDeleted ?? 'Task deleted',
                        type: AppSnackBarType.error,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
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
                        AppLocalizations.of(context)?.checkStatus ?? 'Check Status',
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
import '../../../../core/entities/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
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
    final userRole = ref.watch(authProvider).user?.role;
    final isTeacher = userRole == UserRole.teacher;
    final isParent = userRole == UserRole.parent;

    String formattedDate = 'No date';
    try {
      formattedDate = DateFormat('dd MMM yyyy').format(task.dueDate);
    } catch (e) {
      formattedDate = 'Invalid date';
    }

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
            Row(
              children: [
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
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isTeacher)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                              AppLocalizations.of(context)?.confirmDelete ??
                                  'Delete Task'),
                          content: Text(
                              AppLocalizations.of(context)?.deleteTaskMessage ??
                                  'This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                  AppLocalizations.of(context)?.cancel ??
                                      'Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                  AppLocalizations.of(context)?.delete ??
                                      'Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await ref
                              .read(teacherTasksNotifierProvider.notifier)
                              .deleteTask(task.id);

                          if (!context.mounted) return;

                          AppSnackBar.show(
                            context,
                            message:
                                AppLocalizations.of(context)?.taskDeleted ??
                                    'Task deleted',
                            type: AppSnackBarType.success,
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          AppSnackBar.show(
                            context,
                            message: 'Failed to delete task. Please try again.',
                            type: AppSnackBarType.error,
                          );
                        }
                      }
                    },
                  ),
                if (isParent) _buildStatusBadge(context, task.status),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (isTeacher) ...[
              const SizedBox(height: 14),
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
                          AppLocalizations.of(context)?.checkStatus ??
                              'Check Status',
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
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, TaskStatus status) {
    final loc = AppLocalizations.of(context)!;

    final color = status == TaskStatus.completed
        ? const Color(0xFF4CAF50)
        : const Color(0xFFFF9800);

    final text = status == TaskStatus.completed ? loc.done : loc.pending;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
