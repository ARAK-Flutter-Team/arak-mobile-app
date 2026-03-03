import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> cacheTeacherTasks(List<TaskModel> tasks, String classId);

  Future<List<TaskModel>> getCachedTeacherTasks(String classId);

  Future<void> clearTeacherTasks(String classId);

  Future<void> updateTaskStatusLocally(String taskId, String status);
}