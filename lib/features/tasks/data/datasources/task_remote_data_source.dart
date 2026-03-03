import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTeacherTasks({
    required String teacherId,
    required String classId,
  });

  Future<void> addTask(TaskModel task);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  Future<List<TaskModel>> getStudentTasks(String studentId);

  Future<void> updateTaskStatus(String taskId, String status);
}