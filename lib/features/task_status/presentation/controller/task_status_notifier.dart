import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../tasks/domain/entities/task_student_status.dart';
import '../../../tasks/domain/usecases/get_task_status.dart';
import '../../../tasks/domain/usecases/update_task_student_status.dart';
import '../state/task_status_state.dart';

class TaskStatusNotifier extends StateNotifier<TaskStatusState> {
  final GetTaskStatus getTaskStatus;
  final UpdateTaskStudentStatus updateTaskStudentStatus;

  TaskStatusNotifier({
    required this.getTaskStatus,
    required this.updateTaskStudentStatus,
  }) : super(const TaskStatusState());

  Future<void> load(String taskId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final taskIdInt = int.tryParse(taskId) ?? 0;
      final result = await getTaskStatus(taskIdInt);

      final students = result.map((status) {
        return TaskStudentStatus(
          studentId: status.studentId,
          studentName: status.studentName,
          isDone: status.isDone,
        );
      }).toList();

      state = state.copyWith(
        isLoading: false,
        students: students,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void toggle(String taskId, String studentId) {
    final updatedStudents = state.students.map((student) {
      if (student.studentId == studentId) {
        return TaskStudentStatus(
          studentId: student.studentId,
          studentName: student.studentName,
          isDone: !student.isDone,
        );
      }
      return student;
    }).toList();

    state = state.copyWith(students: updatedStudents);
  }

  Future<void> save(String taskId) async {
    state = state.copyWith(isSaving: true, error: null);

    try {
      final taskIdInt = int.tryParse(taskId) ?? 0;
      final updates = state.students.map((student) {
        return {
          "studentId": student.studentId,
          "isDone": student.isDone,
        };
      }).toList();

      await updateTaskStudentStatus(taskIdInt, updates);

      state = state.copyWith(isSaving: false);

      // ✅ التعديل — بعد الـ save بيعمل load تاني
      await load(taskId);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}
