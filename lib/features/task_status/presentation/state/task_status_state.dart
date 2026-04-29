import '../../../tasks/domain/entities/task_student_status.dart';

class TaskStatusState {
  final List<TaskStudentStatus> students;
  final bool isLoading;
  final bool isSaving;
  final String? error;

  const TaskStatusState({
    this.students = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.error,
  });

  TaskStatusState copyWith({
    List<TaskStudentStatus>? students,
    bool? isLoading,
    bool? isSaving,
    String? error,
  }) {
    return TaskStatusState(
      students: students ?? this.students,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}