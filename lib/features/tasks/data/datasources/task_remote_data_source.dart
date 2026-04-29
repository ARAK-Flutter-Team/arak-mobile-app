import '../../domain/entities/task_student_status.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';
import "../../domain/entities/task.dart";

abstract class TaskRemoteDataSource {
  // Existing methods
  Future<TeacherTasksResult> getTeacherTasks({
    required int teacherId,
    required int classId,
  });

  Future<void> addTask(TaskModel task);

  Future<void> deleteTask(String taskId);

  Future<void> updateTaskStatus(String taskId, TaskStatus status);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  Future<List<TaskModel>> getStudentTasks(String studentId);

  Future<List<Task>> getParentTasks({required String studentId});

  // New methods for Task Status Tracking
  Future<List<TaskStudentStatus>> getTaskStatus(int taskId);

  Future<void> updateTaskStudentStatus(int taskId, List<Map<String, dynamic>> updates);
}