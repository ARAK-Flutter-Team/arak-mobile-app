import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/task_status_entity.dart';
import '../../domain/repositories/task_status_repository.dart';
import '../state/task_status_state.dart';

class TaskStatusNotifier extends StateNotifier<TaskStatusState> {

  final TaskStatusRepository repository;

  TaskStatusNotifier(this.repository)
      : super(const TaskStatusState());

  /// Load task status
  Future<void> load(String taskId) async {
    state = state.copyWith(isLoading: true);

    final data = await repository.getTaskStatuses(taskId);

    state = state.copyWith(
      students: data,
      isLoading: false,
    );
  }

  /// Toggle student status
  Future<void> toggle(String taskId, String studentId) async {
    final index =
    state.students.indexWhere((e) => e.studentId == studentId);

    if (index == -1) return;

    final current = state.students[index];
    final updated = !current.isDone;

    await repository.updateStatus(
      taskId: taskId,
      studentId: studentId,
      isDone: updated,
    );

    final newList = [...state.students];
    newList[index] = TaskStatusEntity(
      taskId: current.taskId,
      studentId: current.studentId,
      studentName: current.studentName,
      isDone: updated,
    );

    state = state.copyWith(students: newList);
  }
  /// save student status
  Future<void> save(String taskId) async {
    state = state.copyWith(isSaving: true);

    try {
      for (final student in state.students) {
        await repository.updateStatus(
          taskId: taskId,
          studentId: student.studentId,
          isDone: student.isDone,
        );
      }
    } catch (e) {
      // ممكن تضيفي error handling بعدين
    }

    state = state.copyWith(isSaving: false);
  }
}