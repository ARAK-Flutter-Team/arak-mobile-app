import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../providers/task_status_provider.dart';
import '../widgets/task_status_list.dart';
import '../widgets/task_status_save_button.dart';
import '../../../tasks/domain/entities/task.dart';

class TaskStatusScreen extends ConsumerStatefulWidget {
  final Task task;

  const TaskStatusScreen({super.key, required this.task});

  @override
  ConsumerState<TaskStatusScreen> createState() =>
      _TaskStatusScreenState();
}

class _TaskStatusScreenState extends ConsumerState<TaskStatusScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(taskStatusProvider.notifier)
          .load(widget.task.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskStatusProvider);
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    final total = state.students.length;
    final done = state.students.where((e) => e.isDone).length;

    return Scaffold(
      appBar: AppMainAppBar(
        title: widget.task.title,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 60),
                        const SizedBox(height: 16),
                        Text(
                          loc.errorOccurred,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.error!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(taskStatusProvider.notifier)
                                .load(widget.task.id);
                          },
                          icon: const Icon(Icons.refresh),
                          label: Text(loc.retry),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "$done / $total",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            loc.studentsSubmitted,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: TaskStatusList(
                          students: state.students,
                          onToggle: (studentId) {
                            ref.read(taskStatusProvider.notifier).toggle(
                                  widget.task.id,
                                  studentId,
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      TaskStatusSaveButton(
                        isLoading: state.isSaving,
                        onPressed: () async {
                          try {
                            await ref
                                .read(taskStatusProvider.notifier)
                                .save(widget.task.id);

                            AppSnackBar.show(
                              context,
                              message: loc.savedSuccessfully,
                              type: AppSnackBarType.success,
                            );
                          } catch (e) {
                            AppSnackBar.show(
                              context,
                              message: loc.errorOccurred,
                              type: AppSnackBarType.error,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
    );
  }
}