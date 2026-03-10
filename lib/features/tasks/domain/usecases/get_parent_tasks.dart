import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetParentTasks {
  final TaskRepository repository;
  const GetParentTasks(this.repository);

  Future<List<Task>> call({required String studentId}) {
    return repository.getParentTasks(studentId: studentId);
  }
}
