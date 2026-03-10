import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/parent_tasks_notifier.dart';
import '../widgets/task_item_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_view.dart';

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
    Future.microtask(
      () => ref
          .read(parentTasksNotifierProvider.notifier)
          .fetchTasks(studentId: widget.studentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parentTasksNotifierProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => context.pop(),
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme.outline),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Tasks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Intro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks for your child',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Here you can track your child's daily tasks and progress",
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
                  child: const Text(
                    'View Reports',
                    style: TextStyle(
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
