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
  // ✅ التغيير 1: شيلنا didChangeDependencies واستبدلناه بـ initState
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ✅ التغيير 2: invalidate بيمسح الكاش القديم أولاً
      ref.invalidate(parentTasksNotifierProvider);
      // ✅ التغيير 3: بعدين يجيب الداتا الجديدة من الـ API
      ref
          .read(parentTasksNotifierProvider.notifier)
          .fetchTasks(studentId: widget.studentId);
    });
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
                    l10n.parentTasksSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: state.isLoading
                  ? const LoadingView()
                  : state.error != null
                      ? ErrorView(
                          message: state.error!,
                          onRetry: () => ref
                              .read(parentTasksNotifierProvider.notifier)
                              .fetchTasks(studentId: widget.studentId),
                        )
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/parent-home/evaluation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
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
