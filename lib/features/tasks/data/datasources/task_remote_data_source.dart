import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';
import "../../domain/entities/task.dart";

abstract class TaskRemoteDataSource {
  // Future<List<TaskModel>> getTeacherTasks({
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  });

  Future<void> addTask(TaskModel task);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  Future<List<TaskModel>> getStudentTasks(String studentId);

  Future<void> updateTaskStatus(String taskId, String status);

  Future<List<Task>> getParentTasks({required String studentId});
}
