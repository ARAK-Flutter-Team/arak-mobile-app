import '../../domain/entities/task_status_entity.dart';

abstract class TaskStatusRemoteDataSource {
  Future<List<TaskStatusEntity>> getTaskStatuses(String taskId);

  Future<void> updateStatus({
    required String taskId,
    required String studentId,
    required bool isDone,
  });
}