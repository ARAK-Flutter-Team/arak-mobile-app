import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_parent_tasks.dart';
import 'teacher_tasks_notifier.dart'; // عشان نستخدم نفس الـ repository providers

// ── State
class ParentTasksState {
  final List<Task> tasks;
  final bool isLoading;
  final String? error;

  const ParentTasksState({
    required this.tasks,
    required this.isLoading,
    this.error,
  });

  factory ParentTasksState.initial() => const ParentTasksState(
        tasks: [],
        isLoading: false,
        error: null,
      );

  ParentTasksState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    Object? error = _sentinel,
  }) {
    return ParentTasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
    );
  }

  static const _sentinel = Object();
}

// ── Notifier
class ParentTasksNotifier extends StateNotifier<ParentTasksState> {
  final GetParentTasks getParentTasks;

  ParentTasksNotifier({required this.getParentTasks})
      : super(ParentTasksState.initial());

  Future<void> fetchTasks({required String studentId}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final tasks = await getParentTasks(studentId: studentId);
      state = state.copyWith(tasks: tasks, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to fetch tasks: ${e.toString()}",
      );
    }
  }
}

// ── Providers
final getParentTasksProvider = Provider((ref) => GetParentTasks(
      ref.watch(taskRepositoryProvider),
    ));

final parentTasksNotifierProvider =
    StateNotifierProvider<ParentTasksNotifier, ParentTasksState>((ref) {
  return ParentTasksNotifier(
    getParentTasks: ref.watch(getParentTasksProvider),
  );
});
