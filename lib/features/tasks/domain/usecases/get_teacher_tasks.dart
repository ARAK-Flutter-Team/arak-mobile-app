import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTeacherTasks {
  final TaskRepository repository;

  GetTeacherTasks(this.repository);

  Future<List<Task>> call({
    required String teacherId,
    required String classId,
  }) {
    return repository.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }
}