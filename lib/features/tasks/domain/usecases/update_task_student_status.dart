import '../repositories/task_repository.dart';

class UpdateTaskStudentStatus {
  final TaskRepository repository;

  UpdateTaskStudentStatus(this.repository);

  Future<void> call(int taskId, List<Map<String, dynamic>> updates) {
    return repository.updateTaskStudentStatus(taskId, updates);
  }
}