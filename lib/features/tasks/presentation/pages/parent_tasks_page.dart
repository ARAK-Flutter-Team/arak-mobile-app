import 'package:arak_app/shared/widgets/app_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/parent_tasks_notifier.dart';
import '../widgets/task_item_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_view.dart';
import '../../../../l10n/app_localizations.dart';

class ParentTasksPage extends ConsumerStatefulWidget {
  final String studentId;
  const ParentTasksPage({super.key, required this.studentId});

  @override
  ConsumerState<ParentTasksPage> createState() => _ParentTasksPageState();
}

class _ParentTasksPageState extends ConsumerState<ParentTasksPage> {
  @override
  void initState() {
    super.initState();
    print('🔥 studentId = ${widget.studentId}');
    Future.microtask(
      () => ref
          .read(parentTasksNotifierProvider.notifier)
          .fetchTasks(studentId: widget.studentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(parentTasksNotifierProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppMainAppBar(
        title: l10n.tasks,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Intro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.parentTasksTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.parentTasksSubtitle, // ✅ اتصلحت
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Body
            Expanded(
              child: state.isLoading
                  ? const LoadingView()
                  : state.error != null
                      ? ErrorView(message: state.error!)
                      : state.tasks.isEmpty
                          ? const EmptyView()
                          : RefreshIndicator(
                              onRefresh: () => ref
                                  .read(parentTasksNotifierProvider.notifier)
                                  .fetchTasks(studentId: widget.studentId),
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: state.tasks.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final task = state.tasks[index];
                                  return GestureDetector(
                                    onTap: () => context.push(
                                      '/parent-home/tasks/details',
                                      extra: task,
                                    ),
                                    child: TaskItemCard(task: task),
                                  );
                                },
                              ),
                            ),
            ),

            // ── View Reports Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    // ✅ شيلنا الـ const
                    l10n.viewReports,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
