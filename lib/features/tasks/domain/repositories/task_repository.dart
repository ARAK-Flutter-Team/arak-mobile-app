import '../entities/task.dart';
import '../entities/teacher_tasks_result.dart';

abstract class TaskRepository {
  Future<TeacherTasksResult> getTeacherTasks({
    required int teacherId,
    required int classId,
  });

  Future<void> addTask(Task task);

  Future<void> deleteTask(String taskId);

  Future<void> updateTaskStatus(String taskId, TaskStatus status);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  Future<List<Task>> getStudentTasks(String studentId);

  Future<List<Task>> getParentTasks({required String studentId});
}