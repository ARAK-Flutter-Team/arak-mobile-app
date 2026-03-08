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

    return Scaffold(
      backgroundColor: Colors.white,
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
                        border: Border.all(color: Colors.black54),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Intro
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks for your child',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Here you can track your child's daily tasks and progress",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
                      ? ErrorView(message: state.error!) // ✅ بدون onRetry
                      : state.tasks.isEmpty
                          ? const EmptyView() // ✅ بدون message
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
                                  // ✅ GestureDetector بدل onTap في TaskItemCard
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
                    backgroundColor: const Color(0xFF007BFF),
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
                      color: Colors.white,
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
