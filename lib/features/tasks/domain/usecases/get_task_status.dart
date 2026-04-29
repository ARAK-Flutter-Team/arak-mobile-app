import '../entities/task_student_status.dart';
import '../repositories/task_repository.dart';

class GetTaskStatus {
  final TaskRepository repository;

  GetTaskStatus(this.repository);

  Future<List<TaskStudentStatus>> call(int taskId) {
    return repository.getTaskStatus(taskId);
  }
}