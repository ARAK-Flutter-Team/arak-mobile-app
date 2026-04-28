import 'package:arak_app/features/tasks/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/domain/usecases/get_teacher_tasks.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class TeacherTasksState {
  final List<Task> tasks;
  final bool isLoading;
  final int selectedClass;
  final String? error;
  final DateTime? lastUpdated;

  const TeacherTasksState({
    required this.tasks,
    required this.isLoading,
    required this.selectedClass,
    this.error,
    this.lastUpdated,
  });

  factory TeacherTasksState.initial() => const TeacherTasksState(
    tasks: [],
    isLoading: true,
    selectedClass: 0,
    error: null,
    lastUpdated: null,
  );

  TeacherTasksState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    int? selectedClass,
    String? error,
    DateTime? lastUpdated,
  }) {
    return TeacherTasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      selectedClass: selectedClass ?? this.selectedClass,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class TeacherTasksNotifier extends StateNotifier<TeacherTasksState> {
  final GetTeacherTasks getTeacherTasks;
  final Ref ref;

  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.ref,
  }) : super(TeacherTasksState.initial());

  Future<void> fetchTasks({
    required int teacherId,
    required int classId,
  }) async {
    print('========== FETCH TASKS ==========');
    print('Teacher ID: $teacherId, Class ID: $classId');

    if (teacherId == 0) {
      state = state.copyWith(error: "Teacher ID not found", isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: null, selectedClass: classId);

    try {
      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      state = state.copyWith(
        tasks: result.tasks,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
      print('Got ${result.tasks.length} tasks');
    } catch (e) {
      print('Fetch tasks error: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> changeClass({
    required int teacherId,
    required int newClassId,
  }) async {
    print('Change class to: $newClassId');
    await fetchTasks(teacherId: teacherId, classId: newClassId);
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await ref.read(taskRepositoryProvider).deleteTask(taskId);
      final teacherId = ref.read(currentTeacherIdProvider);
      if (teacherId != 0 && state.selectedClass != 0) {
        await fetchTasks(teacherId: teacherId, classId: state.selectedClass);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final teacherTasksNotifierProvider = StateNotifierProvider<TeacherTasksNotifier, TeacherTasksState>((ref) {
  return TeacherTasksNotifier(
    getTeacherTasks: ref.watch(getTeacherTasksProvider),
    ref: ref,
  );
});