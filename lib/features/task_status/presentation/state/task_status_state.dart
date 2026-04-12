import '../../domain/entities/task_status_entity.dart';

class TaskStatusState {
  final List<TaskStatusEntity> students;
  final bool isLoading;
  final bool isSaving;

  const TaskStatusState({
    this.students = const [],
    this.isLoading = false,
    this.isSaving = false,
  });

  TaskStatusState copyWith({
    List<TaskStatusEntity>? students,
    bool? isLoading,
    bool? isSaving,
  }) {
    return TaskStatusState(
      students: students ?? this.students,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}