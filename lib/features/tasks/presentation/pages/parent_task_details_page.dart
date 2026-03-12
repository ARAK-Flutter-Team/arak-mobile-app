import 'package:arak_app/shared/widgets/app_main_appbar.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class ParentTaskDetailsPage extends StatelessWidget {
  final Task task;
  const ParentTaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final cardBg =
        isDark ? colorScheme.surfaceContainerHigh : const Color(0xFFE8F3FF);
    final noteBg =
        isDark ? colorScheme.surfaceContainerHigh : const Color(0xFFFFF8F0);
    final noteBorder = isDark ? colorScheme.outline : const Color(0xFFFFCC80);
    final noteIconColor = isDark ? Colors.orangeAccent : Colors.orange;

    return Scaffold(
      appBar: AppMainAppBar(
        title: 'Task Details',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: colorScheme.primary,
                    size: 44,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Title
              Center(
                child: Text(
                  task.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ── Subject + Date
              Center(
                child: Text(
                  '${task.subject} • ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Status
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: switch (task.status) {
                      TaskStatus.completed => const Color(0xFF4CAF50),
                      TaskStatus.pending => const Color(0xFFFF9800),
                      TaskStatus.notStarted => const Color(0xFF5D5D5D),
                    },
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    switch (task.status) {
                      TaskStatus.completed => 'Done',
                      TaskStatus.pending => 'In progress',
                      TaskStatus.notStarted => 'Not started',
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Description
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Read-only note
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: noteBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: noteBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: noteIconColor, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can only view tasks. Contact the teacher to update status.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: noteIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
