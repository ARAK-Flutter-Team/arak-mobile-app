import '../entities/task.dart';
import '../entities/teacher_tasks_result.dart';
import '../repositories/task_repository.dart';

class GetTeacherTasks {
  final TaskRepository repository;

  GetTeacherTasks(this.repository);

  //Future<List<Task>> call({
  Future<TeacherTasksResult> call({
    required String teacherId,
    required String classId,
  }) {
    return repository.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }
}