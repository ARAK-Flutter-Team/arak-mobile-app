import '../entities/task.dart';

abstract class TaskRepository {
  // Teacher
  Future<List<Task>> getTeacherTasks({
    required String teacherId,
    required String classId,
  });

  Future<void> addTask(Task task);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  // Student
  Future<List<Task>> getStudentTasks(String studentId);

  Future<void> updateTaskStatus(String taskId, TaskStatus status);
}