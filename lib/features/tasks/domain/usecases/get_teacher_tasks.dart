import '../entities/teacher_tasks_result.dart';
import '../repositories/task_repository.dart';

class GetTeacherTasks {
  final TaskRepository repository;

  GetTeacherTasks(this.repository);

  Future<TeacherTasksResult> call({
    required int teacherId,
    required int classId,
  }) {
    return repository.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }
}
