/*import '../../domain/entities/task_status_entity.dart';
import '../../domain/repositories/task_status_repository.dart';
import '../datasources/task_status_remote_data_source.dart';

class TaskStatusRepositoryImpl implements TaskStatusRepository {
  final TaskStatusRemoteDataSource remote;

  TaskStatusRepositoryImpl(this.remote);

  @override
  Future<List<TaskStatusEntity>> getTaskStatuses(String taskId) {
    return remote.getTaskStatuses(taskId);
  }

  @override
  Future<void> updateStatus({
    required String taskId,
    required String studentId,
    required bool isDone,
  }) {
    return remote.updateStatus(
      taskId: taskId,
      studentId: studentId,
      isDone: isDone,
    );
  }
}*/